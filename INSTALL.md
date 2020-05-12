## Install instructions

```bash
# create an environment called 'nogil' using Python 3.9 from the 'nogil' channel
conda create -n nogil -c nogil python=3.9

# activate the new environment
conda activate nogil

# install conda packages
conda install -c nogil h5py numpy pytorch pyzmq scikit-learn scipy tokenizers torchvision

# install pip packages
pip install -r requirements.txt
```

## Usage

To reduce the risk of issues with Python-based tools like pip and conda, **the GIL is enabled by default**.
To run with the GIL disabled, use the environment variable `PYTHONGIL=0`.
You can check if the GIL is enabled from Python by accessing `sys.flags.nogil`:

```sh
PYTHONGIL=0 python -c "import sys; print(sys.flags.nogil)"
```

## Other packages

Install other packages using `pip`. If you run into trouble, message Sam Gross on workplace chat.
