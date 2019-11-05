# jupyter-docker
Docker repo to setup conda and jupyter along with few patchs and ability to quickly manage virtual python environments which are registered as jupyter kernels.

To setup on a linux:
```
git clone jupyter-docker
cd jupyter-docker
docker build -t py/conda .
docker-composer up -d
docker ps | grep py35_conda
```

And your jupyter will be started on 8080.  
__To configure things__ like password, port number: Change arguments in ./jupyter_entry_mount/envs/jupyter_launcher.sh"

__To manage virtual env:__  
Open a terminal using jupyter itself (run bash -i in terminal for interactivity).
```
cd /home/mounted/envs
./create_env.sh my_env_name [python=3.8]
./rm_env.sh my_env_name #TO correctly unregister and delete whole env
```