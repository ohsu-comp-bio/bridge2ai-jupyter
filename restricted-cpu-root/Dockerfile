# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM quay.io/cdis/scipy-notebook:2023-03-13
USER root

## Configure default locale, see https://github.com/rocker-org/rocker/issues/19
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen en_US.utf8 \
	&& /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

#
# !!!!!NOTE!!!!!
# Do not install conda, python, pip, etc dependencies as root
# It screws up directory permissions
#
USER $NB_UID
WORKDIR /home/$NB_USER


RUN pip install --upgrade nbconvert==5.6.1 && \
   pip install --upgrade gen3


COPY --chown=jovyan:users resources/custom.js /home/$NB_USER/.jupyter/custom/
COPY --chown=jovyan:users resources/jupyter_notebook_config.py /home/$NB_USER/.jupyter/tmp.py
RUN cat /home/$NB_USER/.jupyter/tmp.py >> /home/$NB_USER/.jupyter/jupyter_notebook_config.py && rm /home/$NB_USER/.jupyter/tmp.py

RUN pip install --upgrade pip
RUN pip install jupyter --upgrade

# step 1 to disable downloads:
RUN jupyter labextension disable @jupyterlab/docmanager-extension:download \
    && jupyter labextension disable @jupyterlab/filebrowser-extension:download

# step 2 to disable downloads:
RUN pip uninstall nbconvert --yes

RUN pip install gen3
RUN pip install gen3-tracker

