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

Merge the latest desired changes to `master` branch in the `content` and `website` repositories.

Afterwards generate the site using `jekyll generate`, and run the tests using `rspec spec`. Then copy the files from newly generated `./_site/` directory and the `rss.py` script to `master` branch in the `developer.fedoraproject.org` repository.

```
cp -r ../website/_site/* .
cp -r ../website/rss.py .
```

Alternatively, you can use a script `container.sh` in `tools` repository, which does the above for you, inside a development container. See the `README.md` for usage.

Don't forget to `git add` new files!


### From staging to production

Once all the changes look good in the staging instance (http://developer.stg.fedoraproject.org/),
they are to be merged from `master` to `release` branch in the `developer.fedoraproject.org` repository.
