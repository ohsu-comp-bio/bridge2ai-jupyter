# use base image
FROM quay.io/ohsu-comp-bio/bridge2ai-jupyter:restricted-gpu-root

# return to non-root user
USER $NB_UID
WORKDIR /home/$NB_USER

# create environments
RUN git clone --recurse-submodules https://github.com/wadeschulz/b2ai-f2f.git
RUN cd b2ai-f2f && conda env create -f hpa_densenet.yml
RUN cd b2ai-f2f && conda env create -f perturbseq.yml
RUN cd b2ai-f2f && conda env create -f pipeline.yml

# additional cellmap pipeline setup from readme
SHELL ["conda", "run", "-n", "cm4ai-pipeline", "/bin/bash", "-c"]
RUN cd b2ai-f2f/cellmaps_pipeline \
    && make dist \
    && pip install dist/cellmaps_pipeline*whl

RUN conda init bash && exec bash