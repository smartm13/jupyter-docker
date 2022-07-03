FROM continuumio/miniconda3:4.12.0
#set corporate proxy
ENV http_proxy=http://genproxy:8080 https_proxy=http://genproxy:8080 no_proxy=localhost,127.0.0.1,.corp.amdocs.com
RUN apt-get update
RUN apt-get install -y curl wget nano htop vim ncdu netcat 

#apply auto-git patch of jupyter
COPY jupyter_git_patch.py /tmp/jupyter_git_patch.py
RUN /opt/conda/bin/pip install gitpython jupyterlab==3.4.3

# RUN cat /tmp/jupyter_git_patch.py >> /opt/conda/lib/python3.9/site-packages/notebook/services/contents/fileio.py
RUN cat /tmp/jupyter_git_patch.py >> /opt/conda/lib/python3.9/site-packages/jupyter_server/services/contents/fileio.py

# ------------------------------------ EXTENSIONS ------------------------------------

# RUN apt-get install -y nodejs 
# RUN node --version
# RUN apt-get install -y npm || ( apt-get install -y npm || apt-get install -y npm )

# Selected:
RUN /opt/conda/bin/pip install jupyterlab-link-share==0.2.4 ipympl==0.9.1 nbdime==3.1.1 jupyterlab-git==0.37.1 jupyterlab-autoversion==0.3.6 # nice to have
RUN /opt/conda/bin/pip install jupyterlab-system-monitor==0.8.0 # jupyterlab-topbar-extension jupyter-resource-usage 
RUN /opt/conda/bin/pip install lckr-jupyterlab-variableinspector==3.0.9
RUN /opt/conda/bin/pip install jupyterlab-lsp==3.10.1 'python-lsp-server[all]==1.4.1'
RUN /opt/conda/bin/pip install jupyter-archive==3.3.1
RUN /opt/conda/bin/pip install jupyterlab-code-formatter==1.4.11 black==22.6.0 isort==5.10.1
RUN /opt/conda/bin/pip install jupyterlab-favorites==3.1.0
RUN /opt/conda/bin/pip install jupyterlab-code-cell-collapser==1.0.0
RUN /opt/conda/bin/pip install stickyland==0.2.1

# Optted out:
# RUN /opt/conda/bin/pip install jupyterlab-notifications  # since chrome Blocked notifications
# Fix:
#  1. Open chrome://flags/#unsafely-treat-insecure-origin-as-secure
#  2. Mark 'Insecure origins treated as secure' as Enabled
#  3. Put this in text box http://SERVER_HOSTNAME:7080
#  4. Relaunch Chrome
#  5. Open http://SERVER_HOSTNAME:7080, Press Allow notifications!

# Failed/Not working:
# RUN /opt/conda/bin/pip install jupyterlab-topbar
# RUN /opt/conda/bin/pip install jupyterlab_execute_time

# Build failed:
# RUN jupyter labextension install verdant-history
# RUN jupyter labextension install @yeebc/jupyterlab_neon_theme
# RUN /opt/conda/bin/pip install jupyterlab_sql && jupyter serverextension enable jupyterlab_sql --py --sys-prefix && jupyter lab build

# ------------------------------------ EXTENSIONS ---end----------------------------------

# CMD /opt/conda/bin/jupyter lab --NotebookApp.open_browser=False --NotebookApp.token= --notebook-dir=/home/mounted --NotebookApp.ip=0.0.0.0 --NotebookApp.port_retries=0 --NotebookApp.password=sha1:04bc0ac53dc8:455b574033db7db3a16be8b0a714c1c981f1fc87 --port=8080 --debug --allow-root
