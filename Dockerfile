# Usage: docker run --restart=always -v /var/data/blockchain-xmr:/root/.bitmonero -p 18080:18080 -p 18081:18081 --name=monerod -td kannix/monero-full-node
FROM ubuntu:18.04 AS build

ENV MONERO_VERSION=0.15.0.5 MONERO_SHA256=6cae57cdfc89d85c612980c6a71a0483bbfc1b0f56bbb30e87e933e7ba6fc7e7

RUN apt-get update && apt-get install -y curl bzip2

WORKDIR /root

RUN curl https://downloads.getmonero.org/cli/monero-linux-x64-v$MONERO_VERSION.tar.bz2 -O &&\
  echo "$MONERO_SHA256  monero-linux-x64-v$MONERO_VERSION.tar.bz2" | sha256sum -c - &&\
  tar -xvf monero-linux-x64-v$MONERO_VERSION.tar.bz2 &&\
  rm monero-linux-x64-v$MONERO_VERSION.tar.bz2 &&\
  cp ./monero-x86_64-linux-gnu-v$MONERO_VERSION/monerod . &&\
  rm -r monero-*
  
FROM ubuntu:18.04

RUN useradd -ms /bin/bash monero && mkdir -p /home/monero/.bitmonero && chown -R monero:monero /home/monero/.bitmonero
USER monero
WORKDIR /home/monero

COPY --chown=monero:monero --from=build /root/monerod /home/monero/monerod

# blockchain loaction
#VOLUME /home/monero/.bitmonero

EXPOSE 18080 18081

ENTRYPOINT ["./monerod"] 

CMD ["--p2p-bind-ip=0.0.0.0", "--p2p-bind-port=18080", "--rpc-bind-ip=0.0.0.0", "--rpc-bind-port=18081", "--rpc-login=javi:hache", "--non-interactive", "--restricted-rpc", "--confirm-external-bind", "--prune-blockchain"]
