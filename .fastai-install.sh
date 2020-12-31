#!/bin/bash
# 2020-12-30
# this is fastai install script from sagemaker
# used this to add-on and to finish configuring fastbook conda env
# so the enviornment on mac is fastbook and not fastai
set -e
echo "Creating dirs and symlinks"
mkdir -p /home/ec2-user/SageMaker/.cache
mkdir -p /home/ec2-user/SageMaker/.fastai
[ ! -L "/home/ec2-user/.cache" ] && ln -s /home/ec2-user/SageMaker/.cache /home/ec2-user/.cache
[ ! -L "/home/ec2-user/.fastai" ] && ln -s /home/ec2-user/SageMaker/.fastai /home/ec2-user/.fastai

echo "Updating conda"
conda update -n base -c defaults conda -y
conda update --all -y
echo "Starting conda create command for fastai env"
conda create -mqyp /home/ec2-user/SageMaker/.env/fastai python=3.6
echo "Activate fastai conda env"
conda init bash
source ~/.bashrc
conda activate /home/ec2-user/SageMaker/.env/fastai
echo "Install ipython kernel and widgets"
conda install ipywidgets ipykernel -y
echo "Installing fastai lib"
pip install -r /home/ec2-user/SageMaker/fastbook/requirements.txt
pip install fastbook sagemaker
echo "Installing Jupyter kernel for fastai"
python -m ipykernel install --name 'fastai' --user
echo "Finished installing fastai conda env"
echo "Install Jupyter nbextensions"
conda activate JupyterSystemEnv
pip install jupyter_contrib_nbextensions
jupyter contrib nbextensions install --user
echo "Restarting jupyter notebook server"
pkill -f jupyter-notebook
rm /home/ec2-user/SageMaker/.create-notebook
echo "Exiting install script"
