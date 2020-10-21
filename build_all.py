import argparse
from concurrent.futures import ThreadPoolExecutor
import os
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
    # "mkl_random",
    "mpmath",
    "nose",
    "numpy-1.14",
    "numpy",
    "numpy-metapackage",
    # "opencv",
    # "pandas",
    "pillow",
    "pip",
    "pkgconfig",
    "pluggy",
    "pybind11",
    "pytest",
    "python",
    "pyyaml",
    "pyzmq",
    "scikit-learn",
    "scipy",
    "sentencepiece",
    "setuptools",
    "six",
    "tbb",
    "tokenizers",
    "wheel",
]

deps = {
    "apipkg": ["python", "pip", "setuptools"],
    "av": ["python", "pip", "cython", "numpy", "pillow"],
    "certifi": ["python"],
    "cffi": ["python", "pip"],
    "cython": ["python"],
    "h5py": ["python", "pip", "numpy", "cython"],
    "mkl-service": ["setuptools", "cython"],
    "mkl_fft": ["numpy"],
    "mpmath": ["python"],
    "nose": ["python", "pip"],
    "numpy-1.14": ["numpy"],
    "numpy": ["cython", "mkl-service"],
    "numpy-metapackage": ["numpy"],
    "pillow": ["python", "pip"],
    "pip": ["python"],
    "pkgconfig": ["python", "setuptools"],
    "pluggy": ["pip"],
    "pybind11": ["python", "setuptools"],
    "pytest": ["python", "pip"],
    "python": [],
    "pyyaml": ["python", "cython"],
    "pyzmq": ["cython", "pip"],
    "scikit-learn": ["cython", "pip", "mkl-service", "numpy", "scipy"],
    "scipy": ["numpy", "pybind11", "setuptools", "pip"],
    "sentencepiece": ["python"],
    "setuptools": ["python", "certifi"],
    "six": ["python", "pip"],
    "tbb": ["python"],
    "tokenizers": ["python", "pip"],
    "wheel": ["python", "setuptools"],
}

jobids = {
}

no_test = {
    "python",
    "numpy-1.14",
    "mkl_fft",
}

include_conda_forge = [

]

parser = argparse.ArgumentParser(description='Build all packages')
parser.add_argument('--render-all', action='store_true', default=False,
                    help='render all recipes')
parser.add_argument('--channel', '-c', default='nogil-staging',
                    help='dst channel')
parser.add_argument('--dir', default='/fsx/sgross/builds',
                    help='build directory')

def rendered_meta(pkg):
    return os.path.join("rendered", f"{pkg}.yaml")

def render(pkg):
    meta = os.path.join(f"{pkg}-feedstock", "recipe", "meta.yaml")
    subprocess.run(["conda", "render", "-c", args.channel, meta, "-f", rendered_meta(pkg)], check=True)

def render_all():
    with ThreadPoolExecutor(max_workers=16) as e:
        for pkg in packages:
            print(f"rendering {pkg}", file=sys.stderr)
            e.submit(render, pkg)

def render_missing():
    with ThreadPoolExecutor(max_workers=16) as e:
        for pkg in packages:
            if not os.path.exists(rendered_meta(pkg)):
                print(pkg)
                e.submit(render, pkg)

def build_package(pkg):
    cmd = f"/fsx/sgross/build_one_package.sh -c {args.channel} --user {args.channel}"
    if pkg in no_test:
        cmd += " --no-test"
    cmd += f" {pkg}-feedstock"

    output = f"{pkg}.txt"

    dependencies = []
    idlist = [jobids[dep] for dep in deps[pkg] if dep in jobids]
    if len(idlist) > 0:
        idlist = ':'.join(idlist)
        dependencies = [f"--dependency=afterok:{idlist}"]

    proc = subprocess.run([
        "sbatch", "--output", output, "-e", output,
        *dependencies
        "--job-name", pkg, "-c", "4", "--wrap", cmd
    ], check=True, capture_output=True)

    jobid = proc.stdout.decode('utf-8').strip().split(' ')[-1]
    jobids[pkg] = jobid

def build_packages(pkgs):
    launched = set()
    remaining = set(pkgs)
    last_size = -1
    while len(remaining) > 0:
        for pkg in remaining:
            can_launch = all(dep in launched for dep in deps[pkg])
            if can_launch:
                print(f'building {pkg}')
                launched.add(pkg)
        remaining -= launched
        if len(remaining) == last_size:
            print(f'circular dependency: {remaining}', file=sys.stderr)
            sys.exit(1)
        last_size = len(remaining)

def main():
    os.chdir(args.dir)
    build_package('pip')
    # build_packages(packages)
    # for pkg in packages:
    # parse_deps('numpy')


if __name__ == '__main__':
    args = parser.parse_args()
    main()
