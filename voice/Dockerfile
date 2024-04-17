# use base image
FROM quay.io/ohsu-comp-bio/bridge2ai-jupyter:cpu-root

RUN pip install --no-cache-dir b2aiprep ipympl huggingface_hub[cli]

# download models
RUN MODEL_DIR=$HOME/models && \
   huggingface-cli download --local-dir $MODEL_DIR/speechbrain/spkrec-ecapa-voxceleb speechbrain/spkrec-ecapa-voxceleb --cache-dir ${MODEL_DIR}/cache && \
   huggingface-cli download --local-dir $MODEL_DIR/openai/whisper-base openai/whisper-base --cache-dir ${MODEL_DIR}/cache

# allow use of conda envs
RUN conda init bash && exec bash
