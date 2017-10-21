# -*- mode: ruby -*-
# vi: set ft=ruby :
FROM aquabiota/realm-geospatial:latest
LABEL maintainer "Aquabiota Solutions AB <mapcloud@aquabiota.se>"
# See aquabiota/realm-r-ver:latest for ENV variables
# And aquabiota/realm-rstudio:latest  for adding new users and

ENV DATA_DIR=/home/aqua/data
ENV AQUABIOTA_GIT_DIR=home/aqua/git

# Create the workspace and workspace for data
RUN mkdir -p /home/aqua/data
# WORKDIR $WORKSPACE_DIR
RUN mkdir -p /home/aqua/git
RUN mkdir -p /home/aqua/bookdown
# Ensure workspace belongs to user
# Ensure access to .local
RUN mkdir -p /home/aqua/.local

RUN install2.r --error dismo biomod2

VOLUME /home/aqua/data
VOLUME /home/aqua/git
VOLUME /home/aqua/bookdown

RUN chown -R aqua:aqua /home/aqua/data && \
    chown -R aqua:aqua $AQUABIOTA_GIT_DIR && \
    chown -R aqua:aqua /home/aqua/.local
    chown -R aqua:aqua /home/aqua/bookdown

# Making sure aqua is a sudoer
# RUN adduser $NB_USER sudo && \
#    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
