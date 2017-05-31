#!/usr/bin/python -u

import sys, os, time
import random

class DNSLookup(object):
    """Handle PowerDNS pipe-backend domain name lookups."""
    ttl = 1


    def __init__(self, query, wservers):
        """parse DNS query and produce lookup result.

        query: a sequence containing the DNS query as per PowerDNS manual appendix A:
        http://downloads.powerdns.com/documentation/html/backends-detail.html#PIPEBACKEND-PROTOCOL
        """
        (_type, qname, qclass, qtype, _id, ip) = query
        self.has_result = False  # has a DNS query response
        qname_lower = qname.lower()

        """List of servers to round-robin"""
        #servers_base = "192.168.2"
        #server = "%s.%s" % (servers_base, random.choice(range(1,255)))
        server = random.choice(wservers)

        self.results = []

        if (qtype == 'A' or qtype == 'ANY') and qname_lower == 'pdns.exp.dev.lacnic.net':
          self.results.append('DATA\t%s\t%s\tA\t%d\t-1\t%s' % (qname, qclass, DNSLookup.ttl, server))
          self.has_result = True
        elif qtype == 'SOA' and qname_lower == 'pdns.exp.dev.lacnic.net':
          self.results.append('DATA\t%s\t%s\t%s\t3600\t-1\tns1.test.soa\tadmin.test.soa\t2014032110\t10800\t3600\t604800\t3600'
                                % (qname, qclass, qtype))
          self.has_result = True

    def str_result(self):
        """return string result suitable for pipe-backend output to PowerDNS."""
        if self.has_result:
            return '\n'.join(self.results)
        else:
            return ''

class Logger(object):
    def __init__(self):
        pid = os.getpid()
        self.logfile = '/tmp/backend.log'
        """self.logfile = '/tmp/backend-%d.log' % pid"""

    def write(self, msg):
        logline = '%s|%s\n' % (time.asctime(), msg)
        f = file(self.logfile, 'a')
        f.write(logline)
        f.close()

def debug_log(msg):
    logger.write(msg)

class PowerDNSbackend(object):
    """The main PowerDNS pipe backend process."""

    def __init__(self, filein, fileout):
        """initialise and run PowerDNS pipe backend process."""
        self.filein = filein
        self.fileout = fileout

        # carlos
        ip_textfile = "/data/powerdns/var/africa.txt"
        f = open(ip_textfile, "r")
        self.exp_addreses = []
        for l in f:
            self.exp_addreses.append(l.strip())
        # carlos

        self._process_requests()   # main program loop

    def _process_requests(self):
        """main program loop"""
        first_time = True
        while 1:
            rawline = self.filein.readline()
            if rawline == '':
                debug_log('EOF')
                return  # EOF detected
            line = rawline.rstrip()

            debug_log('received from pdns:%s' % line)

            if first_time:
                if line == 'HELO\t1':
                    self._fprint('OK\tPython backend firing up')
                else:
                    self._fprint('FAIL')
                    debug_log('HELO input not received - execution aborted')
                    rawline = self.filein.readline()  # as per docs - read another line before aborting
                    debug_log('calling sys.exit()')
                    sys.exit(1)
                first_time = False
            else:
                query = line.split('\t')
                if len(query) != 6:
                    self._fprint('LOG\tPowerDNS sent unparseable line')
                    self._fprint('FAIL')
                else:
                    debug_log('Performing DNSLookup(%s)' % repr(query))
                    lookup = DNSLookup(query, self.exp_addreses)
                    if lookup.has_result:
                        pdns_result = lookup.str_result()
                        self._fprint(pdns_result)
                        debug_log('DNSLookup result(%s)' % pdns_result)
                    self._fprint('END')

    def _fprint(self, message):
        """Print the given message with newline and flushing."""
        self.fileout.write(message + '\n')
        self.fileout.flush()
        debug_log('sent to pdns:%s' % message)

if __name__ == '__main__':
    logger = Logger()
    infile = sys.stdin
    #sys.stdout.close()
    #outfile = os.fdopen(1, 'w', 1)
    outfile = sys.stdout
    try:
        PowerDNSbackend(infile, outfile)
    except:
        debug_log('execution failure:' + str(sys.exc_info()[0]))
        raise
