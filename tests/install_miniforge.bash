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
# path to existing conda installation, or if not already present, where
# conda will be installed using the functions below
#
CONDA_PATH="$HOME/miniforge3"
CONDA_EXE='conda'


function conda_install {
    CONDA_PATH=$1

    hash -r
    wget -nv $(conda_url) -O miniforge.sh
    bash miniforge.sh -b -f -p $CONDA_PATH
    hash -r
    rm miniforge.sh
}


function conda_update {
    CONDA_PATH=$1

    $CONDA_EXE config --set always_yes yes --set changeps1 no 
    $CONDA_EXE update -q conda
    $CONDA_EXE info -a
    $CONDA_EXE config --add channels conda-forge
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
     echo "installation test not supported on OS"
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

# if any test fails, stop immediately
set -e


echo
echo "See mtuq/tests/ for installation logs"
echo
cd $MTUQ_PATH

echo "Installing latest version of conda"
echo
[ -d $CONDA_PATH ] || conda_install $CONDA_PATH > tests/log1
source $CONDA_PATH/etc/profile.d/conda.sh
conda_update $CONDA_PATH >> tests/log1
echo SUCCESS
echo

echo "Testing mtuq installation"
$CONDA_EXE env create -q --name env_default --file env.yaml > tests/log2
echo SUCCESS
echo 

