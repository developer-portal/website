# Release

## Staging and release branches

- content
  - `master` - development branch
  - `release` - what is released (or in staging)
- website
  - `master` - development branch
  - `release` - what was used to generate the latest release (or staging)
- developer.fedoraproject.org
  - `master` - staging
  - `release` - production

## Release process

### From development to staging

First merge the latest desired changes from `master` to `release` branch in the `content` repository using `git merge master` from `release` branch.

Afterwards merge the desired changes from `master` to `release` branch in the `website` repository using `git merge master` from `release` branch.

Than you are able to generate the site (`jekyll generate`), run the tests (`rspec spec`) and copy the files from newly generated `_site/` directory alongside the `rss.py` script over to `master` branch in the `developer.fedoraproject.org` repository.

e.g.:

```
cp -r ../website/_site/* .
cp -r ../website/rss.py .
```

Don't forget to `git add` new files!


### From staging to production

Once all the changes look good in the staging instance (http://developer.stg.fedoraproject.org/),
they are to be merged from `master` to `release` branch in the `developer.fedoraproject.org` repository.
