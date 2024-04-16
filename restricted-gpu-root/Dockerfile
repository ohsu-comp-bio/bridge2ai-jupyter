# use base image
FROM quay.io/ohsu-comp-bio/bridge2ai-jupyter:cpu-root

RUN sudo apt update

# setup CUDA
RUN sudo apt-get install -y kmod \
    && wget https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda_11.8.0_520.61.05_linux.run \
    && sudo bash cuda_11.8.0_520.61.05_linux.run --silent --toolkit

# setup cuDNN
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb \
    && sudo dpkg -i cuda-keyring_1.1-1_all.deb \
    && sudo apt-get update \
    && sudo apt-get -y install cudnn \
    && echo 'export PATH=$PATH:/usr/local/cuda-11.8/bin' > ~/.bashrc \
    && echo 'export LD_LIBRARY_PATH=/usr/local/cuda-11.8/lib6:$LD_LIBRARY_PATH' >> ~/.bashrc \
    && source ~/.bashrc

RUN rm cuda_11.8.0_520.61.05_linux.run cuda-keyring_1.1-1_all.deb