# FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04
FROM nvidia/cuda:10.1-cudnn7-devel

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
  apt-get install -y software-properties-common

RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update
RUN add-apt-repository ppa:jonathonf/ffmpeg-4 && \
  apt-get purge -y ffmpeg x264 libx264-dev && \
  apt-get install -y --no-install-recommends \
  # utils
  sudo \
  openssh-client \
  bash \
  unzip \
  vim \
  build-essential \
  make \
  cmake \
  git \
  wget \
  curl \
  lv \
  less \
  tree \
  htop \
  tzdata \
  ffmpeg \
  # python
  python3.6 \
  python3.6-dev \
  python3-pip \
  # pyenv
  libbz2-dev \
  libffi-dev \
  libncurses5-dev \
  libncursesw5-dev \
  libreadline-dev \
  libsqlite3-dev \
  libssl-dev \
  liblzma-dev \
  zlib1g-dev \
  # pyenv utils
  llvm \
  tk-dev \
  ca-certificates \
  netbase \
  xz-utils \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

ARG TIMEZONE
RUN ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime

ENV USER_NAME=docker
RUN echo "${USER_NAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${USER_NAME}
RUN chmod u+s /usr/sbin/useradd && chmod u+s /usr/sbin/groupadd

# pyenv
ARG PYTHON_VERSION
ENV PYENV_ROOT /.pyenv
ENV PATH ${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}
RUN git clone https://github.com/pyenv/pyenv.git /.pyenv
RUN pyenv install ${PYTHON_VERSION}
RUN pyenv global ${PYTHON_VERSION}
RUN chmod -R 777 /.pyenv

ENV CUDA_HOME /usr/local/cuda

RUN pip install -U pip
RUN pip install cython scipy shapely timm h5py
RUN pip install opencv-python opencv-contrib-python
RUN pip install git+https://github.com/cocodataset/panopticapi.git

# install dependencies
# See https://pytorch.org/ for other options if you use a different version of CUDA
RUN pip install tensorboard cmake   # cmake from apt-get is too old
RUN pip install torch==1.8 torchvision==0.9 -f https://download.pytorch.org/whl/cu101/torch_stable.html
# RUN pip install torch==1.7.1+cu101 torchvision==0.8.2+cu101 torchaudio==0.7.2 -f https://download.pytorch.org/whl/torch_stable.html

RUN pip install 'git+https://github.com/facebookresearch/fvcore'
# install detectron2
COPY ./detectron2-0.4.1 /detectron2_repo
# set FORCE_CUDA because during `docker build` cuda is not accessible
ENV FORCE_CUDA="1"
# This will by default build detectron2 for all common cuda architectures and take a lot more time,
# because inside `docker build`, there is no way to tell which architecture will be used.
ARG TORCH_CUDA_ARCH_LIST="Kepler;Kepler+Tesla;Maxwell;Maxwell+Tegra;Pascal;Volta;Turing"
ENV TORCH_CUDA_ARCH_LIST="${TORCH_CUDA_ARCH_LIST}"

RUN pip install -e detectron2_repo

# clean up
RUN sudo apt-get clean && \
  sudo rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

COPY ./docker/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
