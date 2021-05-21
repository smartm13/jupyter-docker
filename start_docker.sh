#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
docker rm jupyter-instance
docker run -d --name jupyter-instance -p "7080-7090:7080-7090" -v $DIR/jupyter_entry_mount/:/home/mounted \
--entrypoint bash -e JUPYTER_PORT=7080 --restart=always --net=host jupyter-python \
-c "bash -c /home/mounted/envs/install_all.sh ; bash -c /home/mounted/envs/jupyter_launcher.sh"
docker logs -f jupyter-instance

