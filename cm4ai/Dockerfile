# use base image
FROM quay.io/ohsu-comp-bio/bridge2ai-jupyter:cpu-root

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