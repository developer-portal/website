# Development

## Running a local development instance

You can run the site locally on your host or via Vagrant or Docker.
We recommend you to use Docker container.

- [Using a Docker container](DEVELOPMENT.md#using-a-docker--podman-container)
- [Using Vagrant](DEVELOPMENT.md#using-vagrant)
- [Using local installation](DEVELOPMENT.md#using-local-installation)

You also need already cloned out repositories. You can check the [git guide](DEVELOPMENT.md#Git-repositories).

### Using a Docker / Podman container

If you don't have Podman or Docker installed, you can check Fedora Developer Portal page on [installing Docker](https://developer.fedoraproject.org/tools/docker/about.html). 

If you have podman, you can install `podman-docker` wrapper, which gives you docker executable as well:
```
$ sudo dnf install podman-docker
```

The container provides a simple way how to run the development instance of Developer Portal. Following command will download our development container, which includes Jekyll & all dependencies for building the site (and also a pre-built site):

```
$ docker pull quay.io/developer-portal/devel
```

#### Option 1: Mounting `content` repository

If you want to modify and view changes in the `content` repository, you need to add volume mount, using argument `-v /path/to/content/repo:/opt/developerportal/website/content`. Ideally, run it from the `content` folder, like this:

```
$ cd content
$ docker run -it --rm -p4000:4000 -v "${PWD}:/opt/developerportal/website/content:Z" quay.io/developer-portal/devel
```
This will serve the in you local folder at the server address http://127.0.0.1:4000/. The website auto-regenates on any change!

#### Option 2: Mounting `website` repository

If you want to do some changes in both `website` and `content` repositories, run the container from website repository, like this:

```
$ cd website
$ docker run -it --rm -p4000:4000 -v "${PWD}:/opt/developerportal/website:Z" quay.io/developer-portal/devel
```

### Using Vagrant

If you don't have Vagrant installed, you can check Fedora Developer Portal on [installing Vagrant with libvirt provider](https://developer.fedoraproject.org/tools/vagrant/vagrant-libvirt.html). Other dependencies are installed automatically on the guest.

To start developing clone the *website* repository recursively and run `vagrant up`. Afterwards just start the Jekyll server at 0.0.0.0 (instead of default loopback).

```bash
$ cd website
$ vagrant up
$ vagrant ssh -c "jekyll serve --force_polling -H 0.0.0.0 -l -I -w"
```

Once done, you can open http://127.0.0.1:4000/ on your host to see the generated site.

We use `rsync` by default so you need to run `vagrant rsync-auto` on your host to keep the sources synced.


### Using local installation

If you want to install Jekyll and all dependencies **on Fedora**, you can just run the `./setup.sh` script included in this repository.

For other distros use this installation guide: http://jekyllrb.com/docs/installation/

Jekyll will start the development server at `http://127.0.0.1:4000/` and regenerate any modified files for you, using command:
```bash
$ jekyll serve --force_polling -H 0.0.0.0 -l -I -w
```

## Git repositories

### Cloning

It's advised to make a fork in the github WebUI, but clone the origin repository instead:

```
$ git clone --recursive https://github.com/developer-portal/website.git
```

Then add your fork as a remote:
```
$ cd website
# Change my-github-name to your github name. It will also be used later on.
$ remote=my-github-name
$ git remote add $remote ssh://$remote@pkgs.fedoraproject.org/forks/$remote/rpms/website.git
$ git fetch $remote
```

And the same for `content` repository:
```
$ cd content
$ git remote add $remote ssh://$remote@pkgs.fedoraproject.org/forks/$remote/rpms/content.git
$ git fetch $remote
```

### Pushing

You need to create a branch, which will hold your changes, first:
```
# We'll create the branch from latest master commit
$ git checkout master
$ git pull
# Change my-branch to your new branch name. It will also be used later.
$ branch=my-branch
$ git checkout -b $branch
```

Now edit the files, and ideally view the changes using a [local development instance](DEVELOPMENT.md#Running-a-local-development-instance).

And then to push your changes to your fork:
```
# We're using variables created above, holding your remote and branch names.
$ git push -u $remote $branch
```

### Pulling

In case you want to view some changes wich are already in your fork (e.g. modified using Github WebUI). We're using variables holding your remote and branch names:

```bash
# Set it to already existing remote branch
$ branch=my-branch-name
```

You can fetch the changes from your fork:

```bash
$ git fetch $remote
```

And then checkout the branch:

```bash
$ git checkout -b $branch -t $remote/$branch 
```

### Rebases

To update the `content/` directory, switch to that directory, make sure you are on your development branch and rebase on the latest stuff:

```bash
$ cd content
$ git checkout my-devel-branch
$ git fetch origin
$ git rebase origin/master
```

If conflicts occured, you need to resolve them, and continue with rebase.

```bash
$ nano file/that/has/conflict.md
# properly adjusted / edited to show correct content
$ git add file/that/has/conflict.md
$ git rebase --continue
```

### Errors

In case you encounter error like:
```
Could not find jekyll-4.2.0 in any of the sources
```

Try removing `Gemfile.lock`:
```
$ cd website
$ rm Gemfile.lock
```
