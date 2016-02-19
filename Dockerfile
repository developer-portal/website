FROM fedora:22
MAINTAINER Vaclav Pavlin <vpavlin@redhat.com>

# Gems require ruby-devel and group C Development Tools and Libraries
# We need git to get a website and a content of Developer Portal
# Nodejs is needed by Jekyll and iproute provides ip command which let's us to set host for Jekyll properly
RUN dnf -y update && \
    dnf -y install ruby-devel git nodejs iproute zlib-devel libxml2-devel libxslt-devel rubygem-nokogiri rubygem-actionview rubygem-rack rubygem-capybara rubygem-rspec && \
    dnf -y group install "C Development Tools and Libraries" && \
    dnf -y clean all

RUN groupadd dp && useradd -g dp -u 1000 dp

RUN mkdir /opt/developerportal
WORKDIR /opt/developerportal

ADD . website/
RUN chown -R dp:dp /opt/developerportal

USER dp

RUN gem install jekyll --version 3.0.0.pre.beta10
RUN gem install nokogiri -- --use-system-libraries
RUN gem install jekyll-lunr-js-search jekyll-sitemap


WORKDIR /opt/developerportal/website

# Latest content for the Developer Portal is pulled automatically via submodules
#RUN git submodule init && \
#    git submodule update && \
#    cd content && \
#    git checkout master && \
#    git pull

# Jekyll runs on port 80
EXPOSE 8080


VOLUME [ /opt/developerportal/website, /opt/developerportal/website/content ]

# Update the content on every run of the container
CMD /home/dp/bin/jekyll serve --force_polling -P 8080 -H $(ip addr show eth0 | sed -n 's/inet \([^ /]*\).*/\1/p')
