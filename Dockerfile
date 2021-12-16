FROM ubuntu:18.04

WORKDIR /usr/src/install

## Rust ##
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

COPY install_rust.sh install_cmake.sh ./

RUN ./install_rust.sh \
    && apt-get update && apt-get install -y --no-install-recommends \
      pkg-config libssl-dev protobuf-compiler make cmake clang python3 gcc-multilib libz-dev \
    && rustup default nightly \
    && rustup target add x86_64-fortanix-unknown-sgx --toolchain nightly \
    && cargo install fortanix-sgx-tools sgxs-tools \
    && ./install_cmake.sh \
    && rm -rf /usr/src/install /var/lib/apt/lists/*

WORKDIR /usr/src/app
