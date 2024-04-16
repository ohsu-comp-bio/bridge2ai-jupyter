# Voice

Docker file for Voice. Builds off `restricted-gpu-root` image, reverting use back to  non-root privileges. Installs relevant packages into `voice` conda environment and downloads `speechbrain/spkrec-ecapa-voxceleb ` and `openai/whisper-base` models from HuggingFace.