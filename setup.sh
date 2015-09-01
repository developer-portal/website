# This script installs the necessary dependencies on Fedora

sudo dnf group install "C Development Tools and Libraries" -y || :
sudo dnf install ruby-devel zlib-devel libxml2-devel libxslt-devel nodejs -y || :
gem install jekyll || :
gem install nokogiri -- --use-system-libraries || :
gem install jekyll-lunr-js-search || :
