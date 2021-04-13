# Development

## Local development instance

You can run the site locally on your host or via Vagrant or Docker.
We recommend you to use Docker container.

- [Using a Docker container](DEVELOPMENT.md#using-a-docker-container)
- [Using Vagrant](DEVELOPMENT.md#using-vagrant)
- [Using local installation](DEVELOPMENT.md#using-local-installation)

### Using a Docker container

If you don't have Podman or Docker installed, you can check Fedora Developer Portal page on [installing Docker](https://developer.fedoraproject.org/tools/docker/about.html).

Docker / Podman container provides a simple way how to run the development instance of Developer Portal. Following command will start the Jekyll server in a container (with very similar output):

```
$ podman run -it --rm -p4000:4000 quay.io/developer-portal/devel
Configuration file: /opt/developerportal/website/_config.yml
            Source: /opt/developerportal/website
       Destination: /opt/developerportal/website/_site
 Incremental build: enabled
      Generating...
       Git authors: Generating authors...
                    done in 5.293 seconds.
 Auto-regeneration: enabled for '/opt/developerportal/website'
LiveReload address: http://0.0.0.0:35729
    Server address: http://0.0.0.0:4000/
  Server running... press ctrl-c to stop.
```
The above command will serve the latest content available in Github repository at the server address http://127.0.0.1:4000/.

If you want to do some changes in a `website` repository and view them, you need to add volume mount, using argument `-v /path/to/your/repo:/opt/developerportal/website:Z`. You'll also need to clone, and step into the particular repository:

```
$ git clone --recursive https://github.com/developer-portal/website.git
$ cd website
$ podman run -it --rm -p4000:4000 -v "${PWD}:/opt/developerportal/website:Z" quay.io/developer-portal/devel
```

In case you want to modify only the `content` repository, you need to add argument `-v /path/to/content/repo:/opt/developerportal/website/content`:
```
$ git clone https://github.com/developer-portal/content.git
$ cd content
$ podman run -it --rm -p4000:4000 -v "${PWD}:/opt/developerportal/website/content:Z" quay.io/developer-portal/devel
```
The website auto-regenates on any change!

### Using Vagrant

If you don't have Vagrant installed, you can check Fedora Developer Portal on [installing Vagrant with libvirt provider](https://developer.fedoraproject.org/tools/vagrant/vagrant-libvirt.html). Other dependencies are installed automatically on the guest.

To start developing clone the *website* repository recursively and run `vagrant up`. Afterwards just start the Jekyll server at 0.0.0.0 (instead of default loopback).

```bash
$ git clone --recursive https://github.com/developer-portal/website.git && cd website
$ vagrant up
$ vagrant ssh -c "jekyll serve --force_polling -H 0.0.0.0 -l -I -w"
```

Once done, you can open http://127.0.0.1:4000/ on your host to see the generated site.

We use `rsync` by default so you need to run `vagrant rsync-auto` on your host to keep the sources synced.


### Using local installation

If you want to install Jekyll and all dependencies **on Fedora**, you can just run the `./setup.sh` script included in this repository.

For other distros use this installation guide: http://jekyllrb.com/docs/installation/

Cloning the repository:

```bash
$ git clone --recursive git@github.com:developer-portal/website.git
$ cd website
```

To update the content/ directory fetched by just switch to that directory, make sure you are on the master branch and pull the latest stuff:

```bash
$ cd content
$ git checkout master
$ git pull
```

`jekyll serve --force_polling` will start the development server at `http://127.0.0.1:4000/` and regenerate any modified files for you:
```bash
$ jekyll serve --force_polling -H 0.0.0.0 -l -I -w
```
