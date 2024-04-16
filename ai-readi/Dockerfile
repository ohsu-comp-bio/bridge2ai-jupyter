# use base image
FROM quay.io/ohsu-comp-bio/bridge2ai-jupyter:restricted-gpu-root

# return to non-root user
USER $NB_UID
WORKDIR /home/$NB_USER

# create image from requirements.txt
RUN conda create --name ai-readi
SHELL ["conda", "run", "-n", "ai-readi", "/bin/bash", "-c"]
COPY --chown=$NB_USER:$NB_GID requirements.txt .
RUN pip install -r requirements.txt && \
    rm requirements.txt

# setup retfound
RUN conda create -n retfound python=3.7.5 -y
SHELL ["conda", "run", "-n", "retfound", "/bin/bash", "-c"]
RUN git clone https://github.com/rmaphoh/RETFound_MAE/ && \
    cd RETFound_MAE && \
    pip install -r requirement.txt && \
    cd $HOME

# setup automorph
RUN conda create -n automorph python=3.6 -y
SHELL ["conda", "run", "-n", "automorph", "/bin/bash", "-c"]
RUN git clone https://github.com/rmaphoh/AutoMorph.git && \
    cd AutoMorph && \
    conda install pytorch==1.7.0 torchvision==0.8.0 torchaudio==0.7.0 cudatoolkit=11.1 -c pytorch -y && \
    pip install --ignore-installed certifi && \
    pip install -r requirement.txt && \
    pip install efficientnet_pytorch

# allow use of conda envs
RUN conda init bash && exec bash

# USER root