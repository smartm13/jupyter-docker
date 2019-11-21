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
Open a terminal using jupyter itself (run `bash -i` in this jupyter terminal for interactivity - using TAB :) ).
```
cd /home/mounted/envs
                                            # To create a new env-kernel-
./create_env.sh my_env_name [python=3.8]
                                            # To properly unregister and delete whole env-
./rm_env.sh my_env_name
```

> PS:
> Here the notebooks will be under a git version control automatically, so instead of multiple checkpoints of jupyter, we are on local Git.
> Now, Never lose any code while using concurrent sessions over same notebooks.