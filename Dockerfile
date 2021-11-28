FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    curl \
    jq \
    && apt-get purge --auto-remove -y  \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd -r dehydrated && useradd -r -g dehydrated dehydrated \
    && mkdir -p /home/dehydrated /accounts /certs /chains \
    && chown dehydrated:dehydrated /home/dehydrated /accounts /certs /chains

RUN curl -sSL https://github.com/lukas2511/dehydrated/releases/download/v0.6.5/dehydrated-0.6.5.tar.gz \
    | tar xvz -C /home/dehydrated --strip-components 1

RUN curl -SsL https://raw.githubusercontent.com/silkeh/pdns_api.sh/master/pdns_api.sh \
    -o /home/dehydrated/hook.sh && chmod 755 /home/dehydrated/hook.sh


WORKDIR /home/dehydrated

COPY scripts/gen_config.sh /usr/local/bin/
COPY scripts/docker-entrypoint.sh /home/dehydrated


VOLUME ["/accounts", "/certs", "/chains"]

RUN chmod +x /home/dehydrated/docker-entrypoint.sh

ENTRYPOINT [ "/home/dehydrated/docker-entrypoint.sh" ]

