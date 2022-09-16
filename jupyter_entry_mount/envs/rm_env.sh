#!/bin/bash
if [ -z "$1" ]
  then
    echo "No \$1=env_name supplied"
    exit 1
fi
env_name="$1"

cd /home/mounted/envs/
python3 -m jupyter kernelspec uninstall -y $env_name
conda env remove -p $env_name
FILE=./$env_name
if [ -f "$FILE" ]; then
    rm -rfi ./$env_name
fi
