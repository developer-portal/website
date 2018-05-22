# Development

## Local development instance

You can run the site locally on your host or via Vagrant or Docker.
We recommend you to use Vagrant or Local installation.

- [Using Vagrant](DEVELOPMENT.md#using-vagrant)
- [Using local installation](DEVELOPMENT.md#using-local-installation)
- [Using a Docker container](DEVELOPMENT.md#using-a-docker-container)

### Using Vagrant

If you don't have Vagrant installed, you can check Fedora Developer Portal on [installing Vagrant with libvirt provider](https://developer.fedoraproject.org/tools/vagrant/vagrant-libvirt.html). Other dependencies are installed automatically on the guest.

To start developing clone the *website* and *content* repositories and run `vagrant up`. Afterwards just start the Jekyll server at 0.0.0.0 (instead of default loopback).

```bash
$ git clone https://github.com/developer-portal/website.git && cd website
$ git clone https://github.com/developer-portal/content.git
$ vagrant up
$ vagrant ssh
vagrant$ cd /vagrant
vagrant$ jekyll serve --force_polling -H 0.0.0.0
```

Once done, you can open http://127.0.0.1:4000/ on your host to see the generated site.

We use `rsync` by default so you need to run `vagrant rsync-auto` on your host to keep the sources synced.


### Using local installation

Before fetching the sources from GitHub make sure you have the public keys uploaded to your GitHub account. Here is how to do it:  https://help.github.com/articles/error-permission-denied-publickey/.

Then run:

```bash
$ git clone git@github.com:developer-portal/website.git && cd website
$ git submodule init
$ git submodule update
$ jekyll serve --force_polling
```

`jekyll serve --force_polling` will start the development server at `http://127.0.0.1:4000/` and regenerate any modified files for you. If you don't have Jekyll installed, here is the installation guide: http://jekyllrb.com/docs/installation/.

If you want to **install Jekyll on Fedora**, you can just run the `./setup.sh` script included in this repository.

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


### Using a Docker container

If you don't have Docker installed, you can check Fedora Developer Portal on[installing Docker with libvirt provider](https://developer.fedoraproject.org/tools/docker/about.html).

Docker container provides a simple way how to run the development instance of Developer Portal. Following command will start the Jekyll server in a container (with very similar output):

```
$ sudo docker run -it --rm developerportal/devel
Configuration file: /website/_config.yml
            Source: /website
       Destination: /website/_site
      Generating...
                    done.
 Auto-regeneration: enabled for '/website'
Configuration file: /website/_config.yml
    Server address: http://172.17.1.16:8080/
  Server running... press ctrl-c to stop.

```

The above command will serve the latest content available in Github repository. If you want to do some changes in a `website` repository and view them, you need to add argument `-v /path/to/your/repo:/opt/developerportal/website`:

```
$ sudo docker run -it --rm -v $PWD:/opt/developerportal/website:z developerportal/devel
```

In case you want to modify the `content` repository, you need to add argument `-v /path/to/content/repo:/opt/developerportal/website/content`:

```
$ sudo docker run -it --rm -v $PWD/content:/opt/developerportal/website/content developerportal/devel
```
