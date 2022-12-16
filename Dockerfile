FROM ubuntu:18.04
MAINTAINER Olivier Bilodeau <obilodeau@gosecure.ca>
# Modified from a Dockerfile by Madison Bahmer <madison.bahmer@istresearch.com>
# Under the MIT license
# https://github.com/istresearch/scrapy-cluster/blob/master/docker/crawler/Dockerfile

RUN apt-get update && apt-get install -y software-properties-common gcc && \
  add-apt-repository -y ppa:deadsnakes/ppa

# os setup
RUN apt-get update && apt-get -y install \
  python-lxml \
  build-essential \
  libssl-dev \
  libffi-dev \
  python-dev \
  libxml2-dev \
  libxslt1-dev \
  haproxy \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y python3.10 python3-distutils python3-pip python3-apt

RUN apt-get update && apt-get install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget

RUN apt-get update \
  && apt-get --yes --no-install-recommends install \
  python3 python3-dev \
  python3-pip python3-venv python3-wheel python3-setuptools \
  build-essential cmake \
  graphviz git openssh-client \
  libssl-dev libffi-dev \
  && rm -rf /var/lib/apt/lists/*

## Check Python version
RUN python3.10 --version


RUN mkdir -p /opt/torscraper/
WORKDIR /opt/torscraper

# install requirements
COPY requirements.txt /opt/torscraper
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --upgrade requests

# move codebase over
COPY . /opt/torscraper

# move haproxy config to haproxy directory
COPY init/haproxy.cfg /etc/haproxy/haproxy.cfg
#Need to automate the service start when boot


## override settings via localsettings.py
#COPY docker/crawler/settings.py /usr/src/app/crawling/localsettings.py
#
## copy testing script into container
#COPY docker/run_docker_tests.sh /usr/src/app/run_docker_tests.sh
#
## set up environment variables
#
## run the spider
#CMD ["scrapy", "runspider", "crawling/spiders/link_spider.py"]
CMD ["/opt/torscraper/scripts/docker_haproxy_harvest_scrape.sh"]