# Dehydrated with AWS CLI in a Docker Container

[Dehydrated](https://dehydrated.io/) is a very simple shell script that implements the letsencrypt/acme client protocol and impressively facilitates an easy DNS based challenge to [Route 53](https://aws.amazon.com/route53/), the benefits of the DNS challenge is that you will not expose any services to the internet, and you can even run this as part of a CI/CD pipeline without having any servers.

In particular, this container is leveraged in a [Concourse](https://concourse-ci.org/) pipeline to get the necessary publicly trusted certificates that a [PCF](https://pivotal.io/platform) installation would need without exposing anything.

This is created bu using a few bits from other developers.

1) pdns_api.sh - https://github.com/silkeh/pdns_api.sh
2) Example dehydrated dockerfile: https://github.com/voor/dehydrated-route53-docker

## Usage

Volumes required:

/certs
/accounts
/chains

Also you will need to mount some files, i had mine stored in /opt on the docker host.

/opt/dehydrated-pdns/domains.txt mounted as /home/dehydrated/domains.txt
/opt/dehydrated-pdns/zones.txt mounted as /home/dehydrated/zones.txt

For the content of domains.txt and zones.txt:

zones.txt should contain just the zone so "example.com" and domains.txt should contain the subdomain "domain1.example.com"

## Example Usage:

```docker run -v $PWD/chains:/chains -v $PWD/certs:/certs -v $PWD/accounts:/accounts -v $PWD/domains.txt:/home/dehydrated/domains.txt -v $PWD/zones.txt:/home/dehydrated/zones.txt -e PDNS_HOST=http://ns1.xxx.com:8081 -e PDNS_PORT=8081 -e PDNS_KEY="changeme" -e PDNS_VERSION=1  dehydrated-pdns```