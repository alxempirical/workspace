FROM ubuntu:16.04
# Copy these separately so that modifications can preserve the cache
COPY ./scripts/apt-get.sh /scripts/
RUN sh /scripts/apt-get.sh
COPY ./scripts/install-anaconda.sh /scripts/
RUN sh /scripts/install-anaconda.sh
COPY ./.spacemacs /root
COPY ./scripts/build-spacemacs.sh /scripts/
ENV SHELL=/bin/bash APATH=/root/anaconda2/bin/
RUN sh /scripts/build-spacemacs.sh
# Install bayeslite-apsw, which is needed by bayeslite
RUN $APATH/conda skeleton pypi bayeslite-apsw
# conda-build complains about the "-" in the version field and the "::" in the
# licence field of the meta.yaml file. Remove them.
RUN sed -i 's/version: "3.9.2-r1"/version: "3.9.2"/' bayeslite-apsw/meta.yaml && \
    sed -i 's/:://' bayeslite-apsw/meta.yaml
RUN $APATH/conda build bayeslite-apsw && rm -rf bayeslite-apsw
RUN $APATH/conda install --use-local bayeslite-apsw
# Make sure the python path is set when the container is started up.
ENTRYPOINT cd /probcomp/crosscat  && $APATH/python setup.py develop && \
           cd /probcomp/bayeslite && $APATH/python setup.py develop && \
           tmux

#TODO: - Move .emacs.d to a mounted volume, so spacemacs doesn't do as much on
#        each startup.
#      - Set up VNC so that we can connect via X.
#      - Set up a proper tmux file
#      - ADD crosscat & bayeslite at their appointed locations and run python
#        setup.py develop on them so that doing so doesn't slow down container
#        startup.
