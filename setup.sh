#!/bin/bash
# This script installs the necessary dependencies on Fedora
set -xe

sudo dnf group install "C Development Tools and Libraries" -y
# FeedParser is used for RSS feed
# spec dependencies for Capybara & Webkit testing
sudo dnf install -y ruby-devel zlib-devel libxml2-devel libxslt-devel nodejs \
  rubygem-jekyll python-feedparser rubygem-rack rubygem-capybara \
  rubygem-rspec rubygem-nokogiri redhat-rpm-config

gem uninstall jekyll || :
gem install jekyll-lunr-js-search
gem install jekyll-sitemap
gem install jekyll-email-protect
