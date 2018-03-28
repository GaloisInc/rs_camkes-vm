#!/bin/bash -e

stdbuf -oL printf "Fetching sel4-aware Rust compiler..."
(
    rm -rf rust &&
        mkdir rust &&
        cd rust &&
        curl -O https://infinitenegativeutility.com/rust-x86_64.tar.gz &&
        tar -xf rust-x86_64.tar.gz
) >/dev/null 2>&1
echo " done."

stdbuf -oL printf "Fetching sel4 sysroot..."
(
    rm -rf sysroot &&
        mkdir sysroot &&
        cd sysroot &&
        curl -O https://infinitenegativeutility.com/i686-sel4-robigalia.tar.gz &&
        tar -xf i686-sel4-robigalia.tar.gz
) >/dev/null 2>&1
echo " done."

stdbuf -oL printf "Setting up tree-local Cargo configuration..."
mkdir -p .cargo
cat >.cargo/config <<EOF
[build]
target = "i686-sel4-robigalia"
rustflags = ["--sysroot", "sysroot"]
rustc = "rust/bin/rustc"
EOF
echo " done."
