# monero-full-node

docker image to run a monero full network node


# Usage

`docker run -tid --restart=always --mount type=bind,source=/home/$USER/.bitmonero,target=/home/monero/.bitmonero -p 18080:18080 -p 18081:18081 --name=monero javihache/monero-full-node`

## Updates
Manual Way
```
docker stop monerod
docker rm monerod
docker pull javihache/monero-full-node
```
Then launch using the "how to use" command above

Automatic way
https://github.com/v2tec/watchtower

# Donations
42HzsMTuQGmdbK8NgXLBCxQX3jy4M4kuR4fZP6C7Szmm48k8FWzugAJjJPPHrxbrAYdeKgisPLpRq4q5oACiCBem9igv58H
