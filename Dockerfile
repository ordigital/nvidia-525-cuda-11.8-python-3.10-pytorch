FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

ENV PYTHONUNBUFFERED=1 

# SYSTEM
RUN apt-get update --yes --quiet && DEBIAN_FRONTEND=noninteractive apt-get install --yes --quiet --no-install-recommends \
    software-properties-common \
    build-essential apt-utils \
    wget curl vim git ca-certificates kmod \
    nvidia-driver-525 \
 && rm -rf /var/lib/apt/lists/*

# PYTHON 3.10
RUN add-apt-repository --yes ppa:deadsnakes/ppa && apt-get update --yes --quiet
RUN DEBIAN_FRONTEND=noninteractive apt-get install --yes --quiet --no-install-recommends \
    python3.10 \
    python3.10-dev \
    python3.10-distutils \
    python3.10-lib2to3 \
    python3.10-gdbm \
    python3.10-tk \
    pip

RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 999 \
    && update-alternatives --config python3 && ln -s /usr/bin/python3 /usr/bin/python

RUN pip install --upgrade pip

# ANACONDA
RUN wget -O /tmp/anaconda.sh https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh \
    && bash /tmp/anaconda.sh -b -p /anaconda \
    && eval "$(/anaconda/bin/conda shell.bash hook)" \
    && conda init \
    && conda update -n base -c defaults conda \
    && conda create --name env \
    && conda activate env \
    && conda install -y pytorch torchvision torchaudio pytorch-cuda=11.8 -c pytorch-nightly -c nvidia
