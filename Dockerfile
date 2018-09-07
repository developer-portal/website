FROM fedora
MAINTAINER Developer-portal <developer-portal@lists.fedoraproject.org>

# Gems require ruby-devel and group C Development Tools and Libraries
# We need git to get a website and a content of Developer Portal
# Nodejs is needed by Jekyll and iproute provides ip command which let's us to set host for Jekyll properly
# sudo is needed for setup.sh to not fail when run as root

ADD . /opt/developerportal/website/
RUN dnf -y update && \
    dnf -y install sudo git iproute && \
    useradd -u 1000 -d /opt/developerportal/website dp && \
    chown -R dp:dp /opt/developerportal && \
    /bin/bash /opt/developerportal/website/setup.sh && \
    dnf -y clean all

USER dp
# Latest content for the Developer Portal is pulled automatically via submodules
RUN cd /opt/developerportal/website && \
    git checkout master && \
    git reset --hard origin/master && \
    git submodule init && \
    git submodule update && \
    cd content && \
    git checkout master && \
    git reset --hard origin/master

# Jekyll runs on port 8080
EXPOSE 8080

# VOLUME [ /opt/developerportal/website, /opt/developerportal/website/content ]

# Update the content on every run of the container
CMD export LANG=en_US.UTF-8 && \
    cd /opt/developerportal/website/content && \
    git pull && \
    cd /opt/developerportal/website && \
    jekyll serve --force_polling -P 8080 -H $(ip addr show eth0 | sed -n 's/inet \([^ /]*\).*/\1/p')
