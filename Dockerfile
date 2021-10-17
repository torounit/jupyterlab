FROM gibiansky/ihaskell

## Install Rust
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    wget \
    cmake \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \

ENV RUSTUP_HOME=/usr/local/rustup;
ENV CARGO_HOME=/usr/local/cargo
ENV PATH=/usr/local/cargo/bin:$PATH

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

RUN chmod -R a+w $RUSTUP_HOME $CARGO_HOME;

RUN rustup --version;
RUN cargo --version;
RUN rustc --version;

## Install Evcxr
USER 1000
RUN rustup default stable
RUN cargo install evcxr_jupyter && \
    evcxr_jupyter --install
