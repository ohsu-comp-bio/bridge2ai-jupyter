# use base image
FROM quay.io/ohsu-comp-bio/bridge2ai-jupyter:cpu-root

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

# add g3t
SHELL ["conda", "run", "-n", "base", "/bin/bash", "-c"]
RUN pip install --upgrade pip 
RUN pip install --user gen3-tracker==0.0.3rc9

# allow use of conda envs
RUN conda init bash && exec bash

# add gen3-client
RUN wget https://github.com/ACED-IDP/cdis-data-client/releases/latest/download/gen3-client-linux-amd64.zip \
    && unzip gen3-client-linux-amd64.zip \
    && mkdir ~/.gen3 \
    && echo 'export PATH=$PATH:~/.gen3' >> ~/.bashrc \
    && source ~/.bashrc

# copy gen3-client and cleanup 
USER root
RUN rm gen3-client-linux-amd64.zip \
    && mv gen3-client /usr/local/bin

# return to non-root user
USER $NB_UID
WORKDIR /home/$NB_USER