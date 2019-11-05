#!/bin/bash
eval "$(/opt/conda/bin/conda shell.bash hook)"
conda config --add envs_dirs /home/mounted/envs/
cd /home/mounted/envs/
for d in */; do
  conda activate /home/mounted/envs/$d;
  conda install -y -p ./$d pip ipykernel;
  python -m ipykernel install --user --name ${d:0:-1} --display-name "${d:0:-1}";
  conda deactivate;
done
