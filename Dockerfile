FROM docker.dbc.dk/dbc-python3.5
MAINTAINER Søren Mollerup <shm@dbc.dk>

ARG PORT=7371
ENV PORT=${PORT}

RUN apt-install git
RUN git config --global http.sslVerify false
RUN pip install "git+https://github.com/DBCDK/pyutils.git"
RUN pip install "git+https://github.com/DBCDK/cobet.git"
RUN pip install "git+https://github.com/DBCDK/mobus.git"
RUN pip install "git+https://github.com/DBCDK/recomole.git"
RUN apt-get purge -y git
CMD recomole --verbose --ab-id 1 --port ${PORT}

LABEL "PORT"="Port to expose service on"
LABEL "LOWELL_URL"="Url to lowell database"
LABEL "RECMOD_URL"="Url to recommender-models database"
