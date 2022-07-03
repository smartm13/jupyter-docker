#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
if [[ "$*" == *--force* ]]
then
    trap "echo Okay, wont stop.. take care next time && kill -9 $$" INT
    docker inspect jupyter-instance > /dev/null 2>/dev/null && echo "Will force terminate already running container... in 5secs" && sleep 7
    trap - INT
    rm_args__=-f
fi

docker rm $rm_args__ jupyter-instance || ( echo "Already running?" && kill -9 $$ )
docker run -d --name jupyter-instance -p "7080-7090:7080-7090" -v $DIR/jupyter_entry_mount/:/home/mounted \
--entrypoint bash -e JUPYTER_PORT=7080 -e SHELL=/bin/bash -v $DIR/mounted_root:/root --restart=always \
--net=host jupyter-python \
-c "bash -c /home/mounted/envs/install_all.sh ; bash -c /home/mounted/envs/jupyter_launcher.sh"
docker logs -f jupyter-instance
