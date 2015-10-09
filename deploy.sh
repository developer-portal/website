#/bin/bash
# This is a script for deployment which installs the dependencies and uploads
# the site and associated scripts to the production server
#
# Make sure that _site/ contains the already generated files (jekyll build)
export SITE=root@developer.fedorainfracloud.org

if [ ! -d "./_site" ]; then
  echo "_site/ is missing. Run `jekyll build`"
fi

# Install dependencies if missing
echo "Checking dependencies..."
ssh $SITE "rpm -q ruby && rpm -q rubygem-liquid && rpm -q rubygem-actionview"
if [ "$?" != 0 ]; then
  echo "Installing dependencies..."
  ssh $SITE "sudo dnf install -y ruby rubygem-liquid rubygem-actionview"
fi

# Install the generated site from _site to /var/www/html
echo "Uploading site from _site/, check that the content is current"
scp -r _site/** $SITE:/var/www/html

# Install the RSS and associated cron job scripts
echo "Uploading scripts..."
scp rss.rb $SITE:/root
scp cron.sh $SITE:/etc/cron.hourly
