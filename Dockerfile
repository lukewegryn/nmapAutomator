FROM kalilinux/kali-rolling

LABEL org.label-schema.name='Sn1per - Kali Linux' \
    org.label-schema.description='Automated Nmap Scanning' \
    org.label-schema.usage='https://github.com/lukewegryn/nmapAutomator' \
    org.label-schema.url='https://github.com/lukewegryn/nmapAutomator' \
    org.label-schema.vendor='https://pensivesecurity.io' \
    org.label-schema.schema-version='1.0' \
    org.label-schema.docker.cmd.devel='docker run --rm -v $(pwd):/reports/:rw pensivesecurity/nmapAutomator ./nmapAutomator.sh <TARGET> <TYPE>' \
    MAINTAINER="@lukewegryn"

RUN echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" > /etc/apt/sources.list && \
    echo "deb-src http://http.kali.org/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

RUN apt-get install -y \
  python3 \
  python3-pip \
  python2.7 \
  python2.7-dev \
  python-pip \
  python-docutils \
  git \
  perl \
  nmap \
  sslscan

RUN pip install wheel
RUN pip install pip==9.0.3
RUN pip install awscli
RUN pip install futures==2.1.5
RUN pip install ffsend

RUN apt-get install -y \
  wget \
  dmitry \
  dnsrecon \
  wapiti \
  nmap \
  sslyze \
  dnsenum \
  wafw00f \
  dirb \
  host \
  lbd \
  xsser \
  dnsmap \
  dnswalk \
  fierce \
  davtest \
  whatweb \
  nikto \
  uniscan \
  whois \
  theharvester \
  wpscan \
  joomscan \
  wpscan \
  enum4linux \
  dnsrecon \
  odat \
  gobuster 

RUN apt-get --yes install zip gzip tar sed iputils-ping

COPY http-vulners-regex.nse ~/.nmap/scripts/

WORKDIR /
COPY nmapAutomator.sh /usr/local/bin
RUN chmod +x /usr/local/bin/nmapAutomator.sh

RUN mkdir /report
WORKDIR /report

ENTRYPOINT nmapAutomator.sh ${TARGET} ${SCAN_TYPE}