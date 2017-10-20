# -*- mode: ruby -*-
# vi: set ft=ruby :
FROM aquabiota/realm-geospatial:latest
LABEL maintainer "Aquabiota Solutions AB <mapcloud@aquabiota.se>"
# See aquabiota/realm-r-ver:latest for ENV variables
# And aquabiota/realm-rstudio:latest  for adding new users and

ENV DATA_DIR=$HOME_AQUA/data
ENV AQUABIOTA_GIT_DIR=$HOME_AQUA/git


# Create the workspace and workspace for data
RUN mkdir -p $HOME_AQUA/data
# WORKDIR $WORKSPACE_DIR
RUN mkdir -p $HOME_AQUA/git
# Ensure workspace belongs to user
# Ensure access to .local
RUN mkdir -p $HOME_AQUA/.local

RUN chown -R $NB_USER:users $DATA_DIR && \
    chown -R $NB_USER:users $AQUABIOTA_GIT_DIR && \
    chown -R $NB_USER:users $HOME_AQUA/.local

RUN install2.r --error dismo biomod2

# Making sure aqua is a sudoer
RUN adduser $NB_USER sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
