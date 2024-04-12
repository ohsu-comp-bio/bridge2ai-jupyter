ARG ROOT_CONTAINER=quay.io/cdis/ubuntu:focal

FROM $ROOT_CONTAINER

LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

# Fix DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

# Install all OS dependencies for the notebook server that starts but lacks all
# features (e.g., download as all possible file formats)
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    python3.9 \
    python3-pip \
    tini \
    wget \
    git \
    curl \
    ca-certificates \
    sudo \
    locales \
    # fonts-liberation \
    # vim \
    run-one && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

# Set Python 3.9 as the default Python version
RUN ln -s /usr/bin/python3.9 /usr/bin/python

# Add the Python 3.9 executable path to the PATH environment variable
ENV PATH="/usr/bin/python3.9:$PATH"

# Upgrade pip to ensure it's associated with Python 3.9.5
RUN python3.9 -m pip install --upgrade pip

# Remove /usr/bin/pip3 if it exists
RUN rm -f /usr/bin/pip3

# Create a symbolic link from pip3 to pip
RUN ln -s /usr/bin/pip /usr/bin/pip3

RUN pip install JPype1 jupyter

RUN jupyter notebook --generate-config

# step 1 to disable downloads:
RUN jupyter labextension disable @jupyterlab/docmanager-extension:download \
    && jupyter labextension disable @jupyterlab/filebrowser-extension:download

RUN pip install pandas numpy seaborn scipy matplotlib pyNetLogo SALib boto3 awscli --upgrade
RUN pip install gen3==4.18.0 --upgrade
RUN pip install jupyter --upgrade
# step 2 to disable downloads:
RUN pip uninstall nbconvert --yes
# step 3 to install packages:
RUN pip install tensorflow[and-cuda]==2.14.0 
RUN pip install torch==2.2.0 torchvision==0.17.0 torchaudio==2.2.0 --index-url https://download.pytorch.org/whl/cu118

# Create a non-root user for Jupyter without copying /bin or /bin/bash
ARG NB_USER=jovyan
ARG NB_UID=1000
ARG NB_GID=100
RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER && \
    chown -R $NB_USER:users /home/$NB_USER && \
    chmod -R u+rwx /home/$NB_USER && \
    mkdir -p /home/$NB_USER/pd

# Configure environment
ENV CONDA_DIR=/opt/conda \
    PATH=/usr/local/bin:$PATH \
    SHELL=/bin/bash \
    NB_USER=${NB_USER} \
    NB_UID=${NB_UID} \
    NB_GID=${NB_GID} \
    HOME=/home/$NB_USER \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8

# Expose port 8888 for JupyterLab
EXPOSE 8888

# Add local files as late as possible to avoid cache busting
RUN wget https://raw.githubusercontent.com/jupyter/docker-stacks/7e1a19a8427f99652c75d1d4fda3df780721b574/images/docker-stacks-foundation/fix-permissions
RUN mv fix-permissions /usr/local/bin/fix-permissions.sh
COPY start.sh /usr/local/bin/
COPY start-notebook.sh /usr/local/bin/
COPY start-singleuser.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

COPY resources/custom.js /home/$NB_USER/.jupyter/custom/
COPY resources/jupyter_notebook_config.py /home/$NB_USER/.jupyter/tmp.py
RUN cat /home/$NB_USER/.jupyter/tmp.py >> /home/$NB_USER/.jupyter/jupyter_notebook_config.py && rm /home/$NB_USER/.jupyter/tmp.py

RUN fix-permissions.sh "/home/${NB_USER}"

USER $NB_USER

# Set the default command to start JupyterLab
WORKDIR /home/$NB_USER
ENTRYPOINT ["jupyter", "lab", "--allow-root", "--ip=0.0.0.0", "--port=8888", "--no-browser"]
