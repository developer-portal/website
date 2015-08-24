# Website for Fedora Developer Portal

This repository contains Jekyll templates, HTML and CSS files for the Fedora Developer Portal website.

## Local Development Instance

Before fetching the sources from GitHub make sure you have the public keys uploaded to your GitHub account. Here is how to do it:  https://help.github.com/articles/error-permission-denied-publickey/.

Then run:

```bash
$ git clone git@github.com:developer-portal/website.git && cd website
$ git submodule init
$ git submodule update
$ jekyll serve --force_polling
```

If you just want to download the sources without uploading your keys get the sources as:

```
$ git clone https://github.com/developer-portal/content.git
```
