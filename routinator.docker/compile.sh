#!/bin/bash
curl https://sh.rustup.rs -sSf > /root/rustup.sh
/bin/sh /root/rustup.sh -y
source ~/.cargo/env
cargo install routinator
#routinator init --accept-arin-rpa
