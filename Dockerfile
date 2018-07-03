FROM gitlab/gitlab-runner:latest
MAINTAINER Antoine Morisseau <antoine@morisseau.me>

ENV GITLAB_RUNNER_VERSION=10.2.0 \
    GITLAB_RUNNER_USER=gitlab_runner \
    GITLAB_RUNNER_HOME_DIR="/home/gitlab_runner"
ENV GITLAB_RUNNER_DATA_DIR="${GITLAB_RUNNER_HOME_DIR}/data"

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E1DD270288B4E6030699E45FA1715D88E1DF1F24
RUN echo "deb http://ppa.launchpad.net/git-core/ppa/ubuntu trusty main" >> /etc/apt/sources.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y  git-core openssh-client curl libapparmor1
RUN adduser --disabled-login --gecos 'GitLab CI Runner' ${GITLAB_RUNNER_USER}
RUN sudo -HEu ${GITLAB_RUNNER_USER} ln -sf ${GITLAB_RUNNER_DATA_DIR}/.ssh ${GITLAB_RUNNER_HOME_DIR}/.ssh
RUN rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

RUN apt-get update

# install build essentials
RUN apt-get install -y --no-install-recommends \
        git-core \
        curl \
		autoconf \
		automake \
		asciidoc \
		asciidoctor \
		bzip2 \
		file \
		g++ \
		gcc \
		imagemagick \
		libbz2-dev \
		libc6-dev \
		libcurl4-openssl-dev \
		libevent-dev \
		libffi-dev \
		libglib2.0-dev \
		libjpeg-dev \
		liblzma-dev \
		libmagickcore-dev \
		libmagickwand-dev \
		libmysqlclient-dev \
		libncurses-dev \
		libpq-dev \
		libreadline-dev \
		libsqlite3-dev \
		libssl-dev \
		libtool \
		libxml2-dev \
		libxslt-dev \
		libyaml-dev \
		make \
		nodejs \
		pandoc \
		patch \
		wkhtmltopdf \
		xz-utils \
		zlib1g-dev


RUN chown -R ${GITLAB_RUNNER_USER}:${GITLAB_RUNNER_USER} ${GITLAB_RUNNER_HOME_DIR}

RUN locale-gen en_US.UTF-8

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

ENV REGISTER_NON_INTERACTIVE=true
ENV REGISTRATION_TOKEN=
ENV CI_SERVER_URL=
ENV RUNNER_NAME=asciidoctor
ENV RUNNER_EXECUTOR=shell
ENV RUNNER_TAG_LIST=asciidoctor
ENV RUNNER_LIMIT=1

VOLUME ["${GITLAB_RUNNER_DATA_DIR}"]
WORKDIR "${GITLAB_RUNNER_HOME_DIR}"
ENTRYPOINT ["/sbin/entrypoint.sh"]
