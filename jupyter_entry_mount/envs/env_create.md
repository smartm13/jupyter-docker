conda create -y --prefix /home/mounted/envs/py37_tp python=3.7
cd /home/mounted/envs/
conda activate ./py37_tp
conda install -y pip ipykernel
python -m ipykernel install --user --name py37_tp --display-name "py37_tp"

to uninstall:
cd /home/mounted/envs/
jupyter kernelspec uninstall py37_tp
conda env remove -p py37_tp
safe_rm -rfi py37_tp
