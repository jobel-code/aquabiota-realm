# -*- mode: ruby -*-
# vi: set ft=ruby :
FROM aquabiota/realm-datascience:latest

# Previous realm:  aquabiota/realm-datascience
# docker build -t aquabiota/realm-cloud .
# Next to follow: none

LABEL maintainer "Aquabiota Solutions AB <mapcloud@aquabiota.se>"

ARG DEBIAN_FRONTEND=noninteractive


# Needed to run "source" for switching Conda environments.
SHELL ["/bin/bash", "-c"]

## Setup OS and core packages
#RUN echo "deb-src http://ftp.us.debian.org/debian testing main" >> /etc/apt/sources.list && \
#    apt-get update -y && \
#    apt-get install -y -q debian-archive-keyring debian-keyring && \
#    apt-get update -y && \
#    apt-get install --no-install-recommends -y -q \
#        build-essential \
#        ca-certificates \
#        curl \
#        git \
#        locales \
#        openssh-client \
#        pkg-config \
#        unzip \
#        wget \
#        zip && \
#    mkdir -p /tools && \
# Save GPL source packages
    mkdir -p /srcs && \
    cd /srcs && \
    apt-get source -d wget git python-zmq ca-certificates pkg-config libpng-dev && \
    cd / && \


    conda create --yes --quiet --name $PYTHON_3_ENV python=3.5 \
        crcmod==1.7 \
        dask==0.17.1 \
        dill==0.2.6 \
        google-api-python-client==1.6.2 \
        httplib2==0.10.3 \
        h5py==2.7.1 \
        ipykernel==4.8.2 \
        ipywidgets==7.2.1 \
        jinja2==2.8 \
        jsonschema==2.6.0 \
        matplotlib==2.1.2 \
        mock==2.0.0 \
        nltk==3.2.1 \
        notebook==5.6.0 \
        numpy==1.14.0 \
        oauth2client==2.2.0 \
        pandas-gbq==0.3.0 \
        pandas==0.22.0 \
        pandocfilters==1.4.2 \
        pillow==5.0.0 \
        pip==18.0 \
        plotly==1.12.5 \
        psutil==4.3.0 \
        pygments==2.1.3 \
        python-dateutil==2.5.0 \
        python-snappy==0.5.1 \
        pytz==2018.4 \
        pyzmq==17.1.0 \
        requests==2.18.4 \
        scikit-image==0.13.0 \
        scikit-learn==0.19.1 \
        scipy==1.0.0 \
        seaborn==0.7.0 \
        six==1.11.0 \
        statsmodels==0.8.0 \
        sympy==0.7.6.1 \
        tornado==4.5.1 \
        widgetsnbextension==3.2.1 \
        xgboost==0.6a2 && \
# Install Python3 packages that aren't available or up-to-date in Conda.
    source activate $PYTHON_3_ENV && \
    pip install --quiet -U --upgrade-strategy only-if-needed --no-cache-dir \
        apache-airflow==1.9.0 \
        bs4==0.0.1 \
        ggplot==0.6.8 \
        google-cloud-monitoring==0.28.0 \
        lime==0.1.1.23 \
        protobuf==3.5.2 \
        tensorflow==1.8.0 && \
# Make pip3 a copy of pip for the Python 3 environment.
