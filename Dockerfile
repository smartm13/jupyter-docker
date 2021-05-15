FROM continuumio/anaconda3:2020.02
#set corporate proxy
#ENV http_proxy=http://genproxy:8080 https_proxy=http://genproxy:8080 no_proxy=localhost,127.0.0.1,.corp.xyz.com
RUN apt-get update
RUN apt-get install -y curl wget nano htop

#apply auto-git patch of jupyter
COPY jupyter_git_patch.py /tmp/jupyter_git_patch.py
RUN /opt/conda/bin/pip install gitpython
RUN cat /tmp/jupyter_git_patch.py >> /opt/conda/lib/python3.7/site-packages/notebook/services/contents/fileio.py

CMD /opt/conda/bin/jupyter notebook --NotebookApp.open_browser=False --NotebookApp.token= --notebook-dir=/home/mounted --NotebookApp.ip=0.0.0.0 --NotebookApp.port_retries=0 --NotebookApp.password=sha1:04bc0ac53dc8:455b574033db7db3a16be8b0a714c1c981f1fc87 --port=8080 --debug --allow-root
