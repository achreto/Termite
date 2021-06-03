FROM ubuntu:20.04
LABEL maintainer="Reto Achermann <achreto@gmail.com>"

# arguments for this docker container
# the user name and id of the container
ARG arg_uid=1000
ARG arg_user=user

# set the environment arguments (will be used in the script)
ENV ENV_USER=$arg_user
ENV ENV_UID=$arg_uid

COPY docker-entrypoint.sh /entrypoint.sh


RUN apt-get -qq update && \
    DEBIAN_FRONTEND=noninteractive apt-get -qq install -y \
              libglib2.0-dev  ghc cabal-install git z3 \
              libghc-cairo-dev libghc-glib-dev libghc-gtk-dev \
              libcairo2-dev libpangocairo-1.0 libgtk2.0-dev \
              libpango1.0-dev libgtksourceview2.0-dev graphviz \
              libgtksourceview2.0-dev

# adding the termite user
RUN useradd ${ENV_USER} -u ${ENV_UID} -m -s /bin/bash && chown -R ${ENV_USER} /home/${ENV_USER}

RUN chmod o+rx /entrypoint.sh

# next steps as user
USER ${ENV_USER}

ENTRYPOINT ["/entrypoint.sh"]

