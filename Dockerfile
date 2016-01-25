FROM pypy:2-4.0.1-slim
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -qy gcc libc6-dev libffi-dev libssl-dev libxml2-dev libxslt1-dev libsqlite3-dev ca-certificates libjpeg-dev zlib1g-dev bzr git mercurial jarwrapper openjdk-7-jre-headless
RUN pip install --no-cache-dir virtualenv && pypy -m virtualenv /appenv
RUN . /appenv/bin/activate && pip install --no-cache-dir --upgrade pip setuptools wheel
ENTRYPOINT ./appenv/bin/activate \
 && cd /application \
 && pip wheel --wheel-dir /wheelhouse --find-links /wheelhouse --no-cache-dir --requirement requirements.txt
CMD []
