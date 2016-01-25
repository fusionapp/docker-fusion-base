FROM debian:jessie
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -qy virtualenv pypy pypy-dev libffi-dev libssl-dev libxml2-dev libxslt1-dev libsqlite3-dev ca-certificates libjpeg-dev zlib1g-dev bzr git mercurial jarwrapper openjdk-7-jre-headless
RUN virtualenv -p /usr/bin/pypy /appenv
RUN . /appenv/bin/activate && pip install --upgrade pip setuptools wheel requests[security] 'cryptography<1.0'
ENTRYPOINT ./appenv/bin/activate \
 && cd /application \
 && pip wheel --wheel-dir /wheelhouse --find-links /wheelhouse --no-cache-dir --requirement requirements.txt
