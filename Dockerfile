FROM docker.dbc.dk/dbc-python3.5
MAINTAINER Søren Mollerup <shm@dbc.dk>

ARG PORT=7371
ENV PORT=${PORT}


RUN apt-get install -y --no-install-recommends git &&\
    git config --global http.sslVerify false &&\
    pip install git+https://github.com/DBCDK/pyutils.git &&\
    pip install git+https://github.com/DBCDK/mobus.git &&\
    pip install git+https://github.com/DBCDK/recomole.git &&\
    apt-get remove -y git && \
    apt-get autoremove -y
CMD recomole --verbose --ab-id 1 --port ${PORT}

LABEL "PORT"="Port to expose service on"
LABEL "LOWELL_URL"="Url to lowell database"
LABEL "RECMOD_URL"="Url to recommender-models database"
