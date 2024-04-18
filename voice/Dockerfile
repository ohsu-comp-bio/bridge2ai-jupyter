# use base image
FROM quay.io/ohsu-comp-bio/bridge2ai-jupyter:cpu-root

# return to non-root user
USER $NB_UID
WORKDIR /home/$NB_USER

# create environment
# setup environment
RUN conda create -n voice
SHELL ["conda", "run", "-n", "voice", "/bin/bash", "-c"]
RUN conda install python=3.11
RUN pip install --no-cache-dir b2aiprep ipympl huggingface_hub[cli]
RUN pip install ipykernel
RUN python -m ipykernel install --user --name voice --display-name "Python (voice)"

# download models
RUN MODEL_DIR=$HOME/models && \
   huggingface-cli download --local-dir $MODEL_DIR/speechbrain/spkrec-ecapa-voxceleb speechbrain/spkrec-ecapa-voxceleb --cache-dir ${MODEL_DIR}/cache && \
   huggingface-cli download --local-dir $MODEL_DIR/openai/whisper-base openai/whisper-base --cache-dir ${MODEL_DIR}/cache

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