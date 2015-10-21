#/bin/bash
# This is a script for deployment which installs the dependencies and uploads
# the site and associated scripts to the production server
#
# Make sure that _site/ contains the already generated files (jekyll build)
export SITE=root@developer.fedorainfracloud.org

if [ ! -d "./_site" ]; then
  echo "_site/ is missing. Run `jekyll build`"
fi

echo "Running specs..."
rspec spec
if [ "$?" != 0 ]; then
  echo "Specs failed, aborting deploy."
  exit 1
fi

# Install dependencies if missing
echo "Checking dependencies..."
ssh $SITE "rpm -q python-feedparser"
if [ "$?" != 0 ]; then
  echo "Installing dependencies..."
  ssh $SITE "sudo dnf install -y python-feedparser"
fi

# Install the generated site from _site to /var/www/html
echo "Uploading site from _site/, check that the content is current"
scp -r _site/** $SITE:/var/www/html

# Install the RSS and associated cron job scripts
echo "Uploading scripts..."
scp rss.py $SITE:/root
scp cron.sh $SITE:/etc/cron.hourly
