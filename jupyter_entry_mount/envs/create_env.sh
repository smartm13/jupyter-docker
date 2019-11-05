#!/bin/bash
package="python=3.7"
if [ -z "$1" ]
  then
    echo "No \$1=env_name supplied"
    exit 1
fi
env_name="$1"
if [ -z "$2" ]
  then
    echo "No package supplied. Using $package"
else
    package="$2"
fi

eval "$(conda shell.bash hook)"
conda create -y --prefix /home/mounted/envs/$env_name $package
cd /home/mounted/envs/

source activate ./$env_name
conda install -y pip ipykernel
python -m ipykernel install --user --name $env_name --display-name "$env_name"

