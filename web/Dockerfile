FROM ubuntu:18.04
MAINTAINER Olivier Bilodeau <obilodeau@gosecure.ca>

# RUN apt-get update && \
#     apt-get add python python-dev libffi-dev gcc make musl-dev py-pip mysql-client openssl-dev

RUN apt-get update && apt-get install -y python3.10 python3-distutils python3-pip python3-apt 

RUN apt-get update \
    && apt-get --yes --no-install-recommends install \
    build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget

RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata

RUN app-get update && \
    app-get add gcc make musl-dev mysql-client openssl-dev

RUN apt-get update \
    && apt-get --yes --no-install-recommends install \
    python3 python3-dev \
    python3-pip python3-venv python3-wheel python3-setuptools \
    build-essential cmake \
    graphviz git openssh-client \
    libssl-dev libffi-dev \
    mysql-client \
    openssl-dev \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/torscraper/web
COPY . /opt/torscraper/web
WORKDIR /opt/torscraper/web

RUN pip install -r requirements.txt

RUN chmod +x /opt/torscraper/web/docker-entrypoint.sh

CMD ["/opt/torscraper/web/docker-entrypoint.sh"]
