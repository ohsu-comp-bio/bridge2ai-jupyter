# Restricted CPU Root

Dockerfile containing the Jupyter Notebooks for the Bridge2AI project, adapted from the [restricted-gpu-slim/Dockerfile](https://github.com/uc-cdis/containers/blob/master/jupyter-slim/Dockerfile) from Center for Translational Data Science at University of Chicago. Briefly, it provides a VM with a Jupyter Notebooks server and restrictions on downloads (disabled access to download buttons). No GPU features are enabled in this Dockerfile but root access is provided, making this a suitable image for building off of. 
