#!/bin/sh

set -e
sh -n "$0"

# FeedParser is used for RSS feed
# spec dependencies for Capybara & Webkit testing
RPMS=(
ruby-devel
zlib-devel
libxml2-devel
libxslt-devel
python-feedparser
redhat-rpm-config
sudo
git
)

# Sorted alpha
GEMS=(
activesupport
addressable
capybara
colorator
concurrent-ruby
em-websocket
eventmachine
ffi
forwardable-extended
http_parser.rb
i18n
jekyll
jekyll-email-protect
jekyll-git-authors
jekyll-lunr-js-search
jekyll-sass-converter
jekyll-sitemap
jekyll-watch
json
kramdown
kramdown-parser-gfm
libv8
liquid
listen
mercenary
minitest
nokogiri
pathutil
public_suffix
rack
rack-test
rb-fsevent
rb-inotify
ref
rexml
rouge
rspec
safe_yaml
sassc
terminal-table
therubyracer
thread_safe
tzinfo
unicode-display_width
zeitwerk
`tr -s ' ' < Gemfile \
  | sed -e 's/^\s*//' \
  | grep -E '^\s*gem ' \
  | cut -d"," -f1 \
  | cut -d"'" -f2 \
  | grep -v '^gem '`
)

set -xe

sudo dnf install -y 'dnf-command(copr)'
sudo dnf copr enable -y 'pvalena/rubygems'

sudo dnf group install "C Development Tools and Libraries" -y
sudo dnf install -y ${RPMS[@]}

set +e

PKGS="$(echo ${GEMS[@]} | tr -s ' ' '\n' | xargs -i echo "rubygem({})")"
sudo dnf install -y --skip-broken $PKGS

rm *.lock
sed -i 's/~> />= /g' Gemfile

bundle config build.nokogiri --use-system-libraries

bundle install --local || \
bundle install

#echo ${GEMS[@]} | tr -s ' ' '\n' | sort -r | xargs -i sh -c "set -x; gem info '{}' -q | grep -q '^{} ' && exit 0; gem install '{}' --use-system-libraries && exit 0; gem install '{}' || exit 255"
