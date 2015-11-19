# Website for Fedora Developer Portal

This repository contains [Jekyll](http://jekyllrb.com/) templates, CSS styles and images for the [Fedora Developer Portal](https://developer.fedoraproject.org/).

If you are here to submit issue or PR regarding the content of the portal, please do so in the `content` repository:
[https://github.com/developer-portal/content](https://github.com/developer-portal/content).

## Implementation

### Dynamic part of the site

There is an `rss.rb` script that replaces the blog posts section on the index page in generated `_site/` from the Fedora Planet.

## Development

We use [Jekyll](http://jekyllrb.com/) to generate the site, `setup.sh` script to install development dependencies (on Fedora) and we also provide `Vagrantfile` and `Dockerfile`
to spin up the whole development environment. [content](https://github.com/developer-portal/content) repository is a git submodule.

See our [development guide](/DEVELOPMENT.md) on how to run the site locally for development.

To build the site run `jekyll build` or `jekyll serve`.

## Tests

We have some basic Capybara/Webkit test specifications that can help you to notice if something broke. They will also check all internal links between pages so you should also run them to test changes in `content` repository.

To install test dependencies run:

```
$ sudo dnf install rubygem-rack rubygem-capybara rubygem-rspec -y
```

They are part of `setup.sh` script that installs all development dependencies.

To execute the test suite run:

```
$ rspec spec
```

## Contributing

Contributions are welcome! You can find us on `freenode` under `#developer-portal` if you have any further questions.
