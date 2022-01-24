# Website for Fedora Developer Portal
**[Project Page](https://fedoraproject.org/wiki/Websites/Developer)** |
**[Content Repository](https://github.com/developer-portal/content)** |
[Website Repository](https://github.com/developer-portal/website)
<hr>

This repository contains [Jekyll](http://jekyllrb.com/) templates, CSS styles and images for the [Fedora Developer Portal](https://developer.fedoraproject.org/).

Please submit your **ideas**, **bug reports** or **requests** regarding:
- content of the portal in our [content repository issue tracker](https://github.com/developer-portal/content/issues).
- the project, our processes or the portal itself on our [website repository issue tracker](https://github.com/developer-portal/website/issues).

## Implementation

The whole site is generated with [Jekyll](http://jekyllrb.com/) as a static site with some dynamic parts. Site search functionality is implemented in JavaScript and the index is pre-generated during the Jekyll build.

There is an `rss.py` script that replaces the blog posts section on the index page in the generated `_site/` from the Fedora Planet.

## Development

We use [Jekyll](http://jekyllrb.com/) to generate the site, `setup.sh` script to install development dependencies (on Fedora) and we also provide [Vagrantfile](/Vagrantfile) and [Dockerfile](/Dockerfile)
to spin up the whole development environment. [content](https://github.com/developer-portal/content) repository is a git submodule.

See our [development guide](/DEVELOPMENT.md) on how to run the site locally for development.

To build the site run `jekyll build` or `jekyll serve`. You need to install [dependencies](/setup.sh) first.

## Tests

We have some basic Capybara/Webkit test specifications that can help you to notice if something broke. They will also check all internal links between pages so you should also run them to test changes in `content` repository.

To execute the test suite run `rspec spec`. You need to install [dependencies](/setup.sh) first and the site has to be already generated and available in `_site/` folder.

## Contributing

Contributions are welcome! For more information see our [Contributing Guide](https://developer-portal.github.io/contributing).

You can find us on `libera` under [#developer-portal](https://web.libera.chat/?channels=#developer-portal) if you have any further questions.

