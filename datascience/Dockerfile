# -*- mode: ruby -*-
# vi: set ft=ruby :
FROM aquabiota/realm-modelling:latest

# Previous realm:  aquabiota/realm-geospatial
# docker build -t aquabiota/realm-datascience .
# Next to follow: aquabiota/realm-cloud

LABEL maintainer "Aquabiota Solutions AB <mapcloud@aquabiota.se>"

ARG DEBIAN_FRONTEND=noninteractive

ENV SHELL=/bin/bash \
    CONDA_DIR=/home/aqua/conda/ \
    PATH=/home/aqua/conda/bin:$PATH  \
    JUPYTER_CONFIG_DIR=/home/aqua/.ipython/profile_default/
# Environments for gdal to work
ENV GDAL_DATA /home/aqua/conda/share/gdal/
# /home/aqua/conda/lib/python3.6/site-packages
ENV GEOS_DIR /home/aqua/conda

# Create aqua user with UID=1000 and in the 'users' group
RUN mkdir -p /home/aqua/conda  && mkdir -p /home/aqua/git

# Install not yet installed OS dependencies for fully functional notebook server
RUN apt-get update --fix-missing && \
    apt-get -yq dist-upgrade && \
    apt-get install -yq --no-install-recommends \
    jed \
    build-essential \
    fonts-liberation \
    pandoc \
    python-dev \
    p7zip-full \
    software-properties-common

RUN echo 'export PATH=/home/aqua/conda/bin:$PATH' > /etc/profile.d/conda.sh

#RUN cd /home/aqua
#RUN wget --quiet https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh -O /home/aqua/anaconda.sh && \
#    /bin/bash /home/aqua/anaconda.sh -f -b -p /home/aqua/conda
#RUN rm /home/aqua/anaconda.sh && \
#    /home/aqua/conda/bin/conda config --system --prepend channels conda-forge && \
#    /home/aqua/conda/bin/conda config --system --set auto_update_conda false && \
#    /home/aqua/conda/bin/conda config --system --set show_channel_urls true && \
#    /home/aqua/conda/bin/conda update -y --all

    # Install MiniConda, set up Python 2.7 Conda env, and install packages.
RUN  wget --quiet -O ~/miniconda.sh \
        http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
        chmod +x ~/miniconda.sh && \
        ~/miniconda.sh -b -f -p /home/aqua/conda && \
        rm ~/miniconda.sh && \
        conda update conda --quiet --yes && \
        conda config --system --append channels conda-forge && \
        conda config --system --append channels IOOS && \
        conda config --system --append channels r && \
        conda config --system --set show_channel_urls true && \
        conda config --system --set auto_update_conda false && \
        conda update --all --quiet --yes && \
        conda install -c conda-forge --yes --quiet \
                crcmod \
                dask \
                dill \
                google-api-python-client \
                httplib2 \
                h5py \
                ipykernel \
                ipywidgets \
                jinja2 \
                jsonschema \
                jupyterlab \
                matplotlib \
                mock \
                nltk \
                notebook \
                numpy \
                oauth2client \
                pandas-gbq \
                pandas \
                pandocfilters \
                pillow \
                pip \
                plotly \
                psutil \
                pygments \
                python-dateutil \
                python-snappy \
                pytz \
                pyzmq \
                requests \
                scikit-image \
                scikit-learn \
                scipy \
                seaborn \
                six \
                statsmodels \
                sympy \
                tornado \
                widgetsnbextension \
                xgboost
        # Install Python3 packages that aren't available or up-to-date in Conda.
RUN  pip install --quiet -U --upgrade-strategy only-if-needed --no-cache-dir \
                bs4 \
                ggplot \
                google-cloud-monitoring \
                lime \
                protobuf \
                tensorflow \
                s2sphere

# Careful gdal has conflicts with fiona and rasterio
RUN conda install --quiet -c conda-forge --yes gdal && \
conda install -c conda-forge --quiet --yes \
geopandas \
scipy-sugar \
tinydb \
bcrypt \
passlib \
libgdal \
geopy \
folium \
rasterio \
ipyleaflet \
bqplot \
cmocean \
cartopy \
iris \
shapely \
pyproj \
fiona \
xmltodict \
&& conda update -y --all && conda clean -tipsy


RUN echo 'export PATH="/home/aqua/conda/bin:$PATH"' > /etc/profile.d/conda.sh
RUN echo 'export PATH="/home/aqua/conda/bin:$PATH"' >> /home/aqua/.bashrc && \
    echo 'source /home/aqua/.bashrc'

#RUN conda remove -y spyder jupyter notebook
# amasing requirements
#RUN conda install -y bcrypt passlib && \
#    conda install -y -c conda-forge libgdal geopy folium rasterio \
#    ipyleaflet bqplot cmocean cartopy iris shapely pyproj \
#    fiona geopandas && \
#    conda update -y --all && conda clean -tipsy

# installing jupyterlab from conda-forge
# RUN conda install -y -c conda-forge jupyterlab jupyterhub
# RUN jupyter nbextension enable vega --py --sys-prefix
# Enable ipywidgets in jupyterlab See https://github.com/jupyterlab/jupyterlab/issues/3050
# RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager

# The following line will update all the conda packages to the latest version
# using the conda-forge channel. When in production better to set up
# directly with version numbers.
# RUN conda clean -tipsy
# CAREFULL when update as it will raise the following error when running geopandas
# ImportError: /usr/lib/libgdal.so.20: undefined symbol: sqlite3_column_table_name
# So, we make sure to downgrade fiona and upgrade gdal to solve the errors
# Need it to install after geopandas to fix errors

#RUN conda install -y gdal -c conda-forge
# Installing pip requirements not available through conda
# COPY pip-requirements.txt /tmp/
# untangle useful to while dealing with xml see: https://github.com/stchris/untangle

# RUN pip install s2sphere pyorient
#
# make sure ipython will know where to find the git packages.
# Install R packages
# RUN install2.r --error RCurl devtools repr  evaluate crayon digest
# pbdZMQ IRdisplay
#
# Source https://www.datacamp.com/community/blog/jupyter-notebook-r

USER aqua
RUN ipython profile create && echo $(ipython locate)
# Ensure AMASING will find its packages
COPY ipython_config.py /home/aqua/.ipython/profile_default/

USER root
# Ensure access to $CONDA_DIR
# Ensure writing access to user aqua to following dirs

# RUN conda install -y -c conda-forge xmltodict

RUN chown -R aqua:aqua /home/aqua/conda && \
    chown -R aqua:aqua /home/aqua/git && \
    chown -R aqua:aqua /home/aqua/.ipython && \
    chown -R aqua:aqua /usr/local/lib/R/site-library

## Currently no need to run it using jupyter notebook.
# RUN mkdir -p /etc/services.d/amasing \
#    && echo '#!/bin/bash \
#             \n jupyter notebook --ip='*' --port=8889  --no-browser' \
#             > /etc/services.d/amasing/run \
#    && echo '#!/bin/bash \
#             \n jupyter notebook stop 8889' \
#             > /etc/services.d/amasing/finish
EXPOSE 8889

RUN install2.r --error \
  --deps TRUE DT


USER aqua
#RUN (echo "library(devtools)" && \
#     echo "install_github(armstrtw/rzmq)" && \
#     echo "install_github(IRkernel/repr)" && \
#     echo "install_github(IRkernel/IRkernel)" && \
#     echo "IRkernel::installspec(user = FALSE)" ) \
#    | Rscript -e "source(file('stdin'))"


# COPY rpackages.R /home/aqua/rpackages.R
# RUN echo "source /home/aqua/rpackages.R"

# CMD ["/init"]
