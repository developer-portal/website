FROM fedora:22
MAINTAINER Vaclav Pavlin <vpavlin@redhat.com>

# Gems rewuire ruby-devel and group C Development Tools and Libreries
# We need git to get a website and a content of Developer Portal
# Nodejs is needed by jekyll and iproute provides ip command which let's us to set host for jekyll properly
RUN dnf -y update && \
    dnf -y install ruby-devel git nodejs iproute && \
    dnf -y group install "C Development Tools and Libraries"
    dnf -y clean all
RUN gem install jekyll jekyll-lunr-js-search

RUN git clone https://github.com/developer-portal/website

WORKDIR website

# Latest content for the Developer Portal is pulled automatically via submodules
RUN git submodule init && \
    git submodule update

# Jekyll runs on port 80
EXPOSE 8080

VOLUME [ /website, /website/content ]

USER 1000

# Update the content on every run of the container
CMD cd content; \
    git checkout master &> /dev/null; \
    git pull &> /dev/null; \
    cd ..; \
    jekyll serve --force_polling -P 8080 -H $(ip addr show eth0 | sed -n 's/inet \([^ /]*\).*/\1/p')
