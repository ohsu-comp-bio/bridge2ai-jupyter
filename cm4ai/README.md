# CM4AI

Docker file for CM4AI. Builds off `restricted-gpu-root` image, reverting use back to  non-root privileges. Creates individual conda environments for hpa_densenet, perturbseq, and cellmaps pipeline. 