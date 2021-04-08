FROM fedora
MAINTAINER Developer-portal <developer-portal@lists.fedoraproject.org>

ENV APPDIR="/opt/developerportal/website/"
ADD . "${APPDIR}"
WORKDIR "${APPDIR}"

RUN set -x && cd "${APPDIR}" && \
    echo "Set disable_coredump false" >> /etc/sudo.conf && \
    \
    ./setup.sh && \
    \
    dnf autoremove -y && \
    dnf clean all -y && \
    \
    git reset --hard origin/master && \
    git submodule update --init --recursive && \
    cd content && \
    git reset --hard origin/master && \
    \
    jekyll build

# Jekyll runs on port 4000 by default
EXPOSE 4000

# Update the content on every run of the container
#ENTRYPOINT LANG=en_US.UTF-8 bundle exec bash -i "$@"
CMD jekyll serve --force_polling -H 0.0.0.0 -l -I -w
