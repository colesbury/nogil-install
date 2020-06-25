```
# PyTorch 1.5.1
git clone https://github.com/colesbury/vision.git -b v0.6.1-nogil torchvision
cd torchvision
HOME=/scratch/$USER \ # on devfair
sudo docker run -it --ipc=host --rm -v $(pwd):/remote pytorch/conda-cuda bash
pushd remote
export CU_VERSION=cu101
export PYTORCH_VERSION=1.5.1
export PYTHON_VERSION=3.9
./packaging/build_conda.sh

# PyTorch 1.4.1
git clone https://github.com/colesbury/vision.git -b v0.5.0-nogil torchvision
cd torchvision
HOME=/scratch/$USER \ # on devfair
sudo docker run -it --ipc=host --rm -v $(pwd):/remote pytorch/conda-cuda bash
pushd remote
export CU_VERSION=cu101
export PYTORCH_VERSION=1.4.1
export PYTHON_VERSION=3.9
./packaging/build_conda.sh
```
