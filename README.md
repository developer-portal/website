# Website for Fedora Developer Portal

This repository contains Jekyll templates, HTML and CSS files for the Fedora Developer Portal.

## Local development instance

Before fetching the sources from GitHub make sure you have the public keys uploaded to your GitHub account. Here is how to do it:  https://help.github.com/articles/error-permission-denied-publickey/.

Then run:

```bash
$ git clone git@github.com:developer-portal/website.git && cd website
$ git submodule init
$ git submodule update
$ jekyll serve --force_polling
```

`jekyll serve --force_polling` will start the development server at `http://127.0.0.1:4000/` and regenerate any modified files for you. If you don't have Jekyll installed, here is the installation guide: http://jekyllrb.com/docs/installation/.

To update the content/ directory fetched by `git submodule update` just switch to that directory, make sure you are on the master branch and pull the latest stuff:

```bash
$ cd content
$ git checkout master
$ git pull
```

If you just want to download the sources without uploading your keys get the sources as:

```bash
$ git clone https://github.com/developer-portal/content.git
```
