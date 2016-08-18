# Virtualized Stacks

URL: https://github.com/LACNIC/virtualized-stacks

Author: LACNICLabs (carlos@lacnic.net)

Virtualized appliances using Vagrant and Docker for different networking technologies and uses.

## Stacks

### BIND9 DNS Server
* Based on Bind 9.10
* DNSSEC Ready (includes root key)
* Use cases
  * basic validating recursive server
  * basic zone signer
  * policy zone server (RPZ)

### Quagga RPKI-Enabled Router
* Based on Quagga patches by Freie-Universitaet Berlin
* Includes RTRLib and dependencies

### Desktops (xfce 32 and 64 bits)
* Based on Ubuntu
* Basic desktops
* Both versions are equivalent, the only difference being the base architecture



