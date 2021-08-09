bash -c 'VERSION_ALIAS="3.8.6-mask-former" PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install 3.8.6'
pip install -U pip
pip install ipdb
pip install torch==1.8.0 torchvision==0.9.0
python -m pip install detectron2 -f \
  https://dl.fbaipublicfiles.com/detectron2/wheels/cu102/torch1.8/index.html
pip install -r requirements.txt
pip install opencv-python opencv-contrib-python
pip install git+https://github.com/cocodataset/panopticapi.git
