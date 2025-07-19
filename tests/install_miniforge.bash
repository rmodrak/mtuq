#!/bin/bash


#
# TESTS MTUQ INSTALLATION UNDER CONDA
#


#
# mtuq root directory
#
MTUQ_PATH=$(dirname ${BASH_SOURCE[0]})/..


#
# check that the following versions and dependencies match 
# mtuq/docs/install/env_conda.rst
#
PYTHON_VERSION=3


#
# path where conda will be installed
#
_CONDA_PATH_="$HOME/miniforge3"

#
# it appears that conda and mamba differ subtly in their input arguments,
# and are not completely interchangeable
# 
_CONDA_EXE_='conda'


# note that CONDA_EXE and CONDA_PATH are reserved by the conda distribution
# itself, so we used _CONDA_EXE_ and _CONDA_PATH_



function conda_install {
    _CONDA_INSTALL_PATH_=$1

    hash -r
    wget -nv $(conda_url) -O miniforge.sh
    bash miniforge.sh -b -f -p $_CONDA_INSTALL_PATH_
    hash -r
    rm miniforge.sh
}


function conda_update {
    _CONDA_PATH_=$1

    $_CONDA_EXE_ config --set always_yes yes --set changeps1 no 
    $_CONDA_EXE_ update -q conda
    $_CONDA_EXE_ info -a
    $_CONDA_EXE_ config --add channels conda-forge
}


function os_string {
    echo "$(uname -s)"
}


function conda_url {
case "$(os_string)" in
   Darwin)
     URL="https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-arm64.sh"
     ;;
   Linux)
     URL="https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh"
     ;;
   *)
     exit -1
     ;;
esac
echo $URL
}

CONDA_URL=$(conda_url)
if [[ -z $CONDA_URL ]]
then
    echo "uname -s: $(os_string)"
    echo "installation not supported"
    exit -1
fi


#
# installation tests begin now
#

# if any test fails from now on, stop immediately
set -e

# verbose mode from now on
set -x


echo
echo "See mtuq/tests/ for installation logs"
echo
cd $MTUQ_PATH

echo "Installing latest version of conda"
echo
[ -d $_CONDA_PATH_ ] || conda_install $_CONDA_PATH_ > tests/log0
source $_CONDA_PATH_/etc/profile.d/conda.sh
conda_update $_CONDA_PATH_ >> tests/log0
echo SUCCESS
echo

echo "Testing mtuq installation"
$_CONDA_EXE_ env create -q --name env1 --file env.yaml > tests/log1
$_CONDA_EXE_ activate env1
$_CONDA_EXE_ deactivate
echo SUCCESS
echo 

