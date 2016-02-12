FROM pypy:2-4.0.1-slim
COPY ["uuid.py", "/usr/local/lib-python/2.7/uuid.py"]
RUN ["/bin/rm", "/usr/local/lib-python/2.7/uuid.pyc"]
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -qy gcc libc6-dev libffi-dev libssl-dev libxml2-dev libxslt1-dev libsqlite3-dev ca-certificates libjpeg-dev zlib1g-dev bzr git mercurial jarwrapper openjdk-7-jre-headless curl
RUN pip install --no-cache-dir virtualenv && pypy -m virtualenv /appenv
COPY ["requirements.txt", "/appenv/requirements.txt"]
RUN . /appenv/bin/activate && pip install --no-cache-dir --requirement /appenv/requirements.txt
WORKDIR /application
CMD [ \
 "/appenv/bin/pip", "wheel", \
 "--wheel-dir", "/wheelhouse", \
 "--find-links", "/wheelhouse", \
 "--no-cache-dir", \
 "--requirement", "/application/requirements.txt", "/application"]
