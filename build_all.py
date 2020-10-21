import argparse
from concurrent.futures import ThreadPoolExecutor
import os
import shutil
import sys
import yaml
import subprocess

packages = [
    "apipkg",
    "av",
    "certifi",
    "cffi",
    "cython",
    "h5py",
    "mkl-service",
    "mkl_fft",
    "mkl_random",
    "mpmath",
    "nose",
    "numpy-1.14",
    "numpy-1.14-openblas",
    "numpy",
    "numpy-metapackage",
    "opencv",
    "pandas",
    "pillow",
    "pip",
    "pkgconfig",
    "pluggy",
    "pybind11",
    "pytest",
    "python",
    "python_abi",
    "pytorch",
    "pyyaml",
    "pyzmq",
    "scikit-learn",
    "scipy",
    "sentencepiece",
    "setuptools",
    "six",
    "tbb",
    "tokenizers",
    "torchvision",
    "wheel",
]

deps = {
    "apipkg": ["python", "pip", "setuptools"],
    "av": ["python", "pip", "cython", "numpy-1.14", "pillow", "mkl_random"],
    "certifi": ["python"],
    "cffi": ["python", "pip"],
    "cython": ["python", "pip"],
    "h5py": ["python", "pip", "numpy-1.14", "cython", "six", "pkgconfig"],
    "mkl-service": ["setuptools", "cython"],
    "mkl_fft": ["numpy-1.14"],
    "mkl_random": ["python", "pip", "numpy-1.14", "numpy-1.14-openblas", "mkl-service"],
    "mpmath": ["python"],
    "nose": ["python", "pip"],
    "numpy-1.14": ["cython", "mkl-service"],
    "numpy-1.14-openblas": ["cython", "mkl-service"],
    "numpy": ["cython", "mkl-service"],
    "numpy-metapackage": ["numpy"],
    "opencv": ["python", "numpy-1.14"],
    "pandas": ["python", "pip", "cython", "numpy-1.14", "numpy-metapackage"],
    "pillow": ["python", "pip"],
    "pip": ["python", "setuptools"],
    "pkgconfig": ["python", "pip", "nose"],
    "pluggy": ["pip"],
    "pybind11": ["python", "setuptools"],
    "pytest": ["python", "pip"],
    "python": [],
    "python_abi": ["python", "pip"],
    "pytorch": ["python", "numpy-1.14", "numpy-metapackage"],
    "pyyaml": ["python", "cython"],
    "pyzmq": ["cython", "pip"],
    "scikit-learn": ["cython", "pip", "scipy"],
    "scipy": ["numpy-1.14", "pybind11", "setuptools", "pip"],
    "sentencepiece": ["python", "setuptools"],
    "setuptools": ["python", "certifi"],
    "six": ["python", "pip"],
    "tbb": ["python"],
    "tokenizers": ["python", "pip", "python_abi"],
    "torchvision": ["python", "pytorch"],
    "wheel": ["python", "setuptools"],
}

extra_channels = {
    "opencv": ["conda-forge"],
    "tokenizers": ["powerai", "conda-forge"],
}

binary_pkgs = [
    "conda-forge/ffmpeg/4.2.3",
    "conda-forge/gmp/6.2.0",
    "conda-forge/jpeg/9d",
    "conda-forge/libblas/3.8.0/linux-64/libblas-3.8.0-14_mkl.tar.bz2",
    "conda-forge/libcblas/3.8.0/linux-64/libcblas-3.8.0-14_mkl.tar.bz2",
    "conda-forge/liblapack/3.8.0/linux-64/liblapack-3.8.0-14_mkl.tar.bz2",
    "conda-forge/liblapacke/3.8.0/linux-64/liblapacke-3.8.0-14_mkl.tar.bz2",
    "conda-forge/openh264/2.1.1",
    "conda-forge/x264/1!152.20180806",
    "pytorch/magma-cuda101/2.5.2",
]

no_test = {
    "python",
    "mkl_fft",
    "mkl_random",
    "numpy-1.14",
    "numpy-1.14-openblas",
    "numpy-metapackage",
    "opencv",
    "scipy", # :-(
    "scikit-learn", # :-(
    "tbb",
}

cpus_needed = {
    "pytorch": 32,
    "torchvision": 32,
}

skip = set()
jobids = {}

parser = argparse.ArgumentParser(description='Build all packages')
parser.add_argument('--package', default=None,
                    help='single package to build')
parser.add_argument('--copy-binaries', action='store_true', default=False,
                    help='copy necessary binary packages')
parser.add_argument('--channel', '-c', default='nogil-staging',
                    help='dst channel')
parser.add_argument('--dir', default='/fsx/sgross/builds/',
                    help='build directory')
# conda search -c nogil-staging --override-channels | tail -n +3 | cut -d ' ' -f 1 > /fsx/sgross/builds/skip.txt
parser.add_argument('--skip', default='/fsx/sgross/builds/skip.txt',
                    help='builds to skip')


def build_package(pkg):
    if pkg == 'pytorch':
        cmd = os.path.join(args.dir, "build_pytorch.sh")
    elif pkg == 'torchvision':
        cmd = os.path.join(args.dir, "build_torchvision.sh")
    else:
        script = os.path.join(args.dir, "build_one_package.sh")
        channels = [args.channel] + extra_channels.get(pkg, [])
        channels = ' '.join(f"-c {channel}" for channel in channels)
        cmd = f"{script} {channels} --user {args.channel}"
        if pkg in no_test:
            cmd += " --no-test"

        if pkg == 'numpy-1.14-openblas':
            # build NumPy 1.14 with openblas as well for mkl_random
            cmd += " -m openblas.yaml numpy-1.14-feedstock"
        else:
            cmd += f" {pkg}-feedstock"

    output = f"{pkg}.log"

    dependencies = []
    idlist = [jobids[dep] for dep in deps[pkg] if dep in jobids]
    if len(idlist) > 0:
        idlist = ':'.join(idlist)
        dependencies = [f"--dependency=afterok:{idlist}"]

    os.environ['CHANNEL'] = args.channel
    cpus = cpus_needed.get(pkg, 4)
    proc = subprocess.run([
        "sbatch", "--output", output, "-e", output,
        *dependencies,
        "--job-name", pkg, "-c", str(cpus), "--wrap", cmd
    ], check=True, capture_output=True)

    jobid = proc.stdout.decode('utf-8').strip().split(' ')[-1]
    jobids[pkg] = jobid
    print(f"building {jobid} {dependencies}", file=sys.stderr)

def build_packages(pkgs):
    launched = set(skip)
    remaining = set(pkgs)
    remaining -= skip
    last_size = -1
    while len(remaining) > 0:
        for pkg in remaining:
            can_launch = all(dep in launched for dep in deps[pkg])
            if can_launch:
                print(f'building {pkg}')
                build_package(pkg)
                launched.add(pkg)
        remaining -= launched
        if len(remaining) == last_size:
            print(f'circular dependency: {remaining}', file=sys.stderr)
            sys.exit(1)
        last_size = len(remaining)

def copy_binaries():
    for pkg in binary_pkgs:
        proc = subprocess.run([
            "anaconda", "copy", pkg, "--to-owner", args.channel,
        ])


def main():
    os.makedirs(args.dir, exist_ok=True)

    shutil.copy("build_one_package.sh", args.dir)
    shutil.copy("pytorch/build_pytorch.sh", args.dir)
    shutil.copy("torchvision/build_torchvision.sh", args.dir)

    os.chdir(args.dir)

    if args.copy_binaries:
        copy_binaries()

    if os.path.exists(args.skip):
        with open(args.skip, 'r') as f:
            for line in f.readlines():
                if not line.startswith("#"):
                    skip.add(line.strip())
        for pkg in skip:
            if pkg not in packages:
                print(f"warning: {pkg} not in list", file=sys.stderr)
            else:
                print(f"skipping: {pkg}", file=sys.stderr)

    if args.package:
        skip.update(set(packages) - set([args.package]))
        build_packages([args.package])
    else:
        build_packages(packages)


if __name__ == '__main__':
    args = parser.parse_args()
    main()
