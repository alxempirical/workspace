FROM ubuntu:16.04
# Copy these separately so that modifications can preserve the cache
COPY ./scripts/apt-get.sh /scripts/
RUN sh /scripts/apt-get.sh
COPY ./scripts/install-anaconda.sh /scripts/
RUN sh /scripts/install-anaconda.sh
COPY ./.spacemacs /root
COPY ./scripts/build-spacemacs.sh /scripts/
ENV SHELL=/bin/bash
RUN sh /scripts/build-spacemacs.sh
