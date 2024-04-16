# use base image
FROM quay.io/ohsu-comp-bio/bridge2ai-jupyter:restricted-gpu-root

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

# allow use of conda envs
RUN conda init bash && exec bash