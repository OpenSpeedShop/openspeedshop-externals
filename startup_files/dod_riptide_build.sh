#!/bin/bash

. /usr/share/Modules/init/bash

module unload intel/13.0 impi/4.1
module load gcc/gnu/4.9.3

export BASE_IDIR=/gpfs/pkgs/hpcmp/PTOOLS/pkgs/openss
export TOOL_VERS="_v2.2.3"
export MPICH_IDIR=/gpfs/pkgs/mhpcc/intel/2013/impi/4.1.0.024/intel64
export OPENMPI_IDIR=/gpfs/pkgs/mhpcc/openmpi/tm/gnu/1.8.5
export PYTHON_IDIR=${BASE_IDIR}/python-2.7.3
export PYTHON_VERS="2.7"
export LTDL_IDIR=${BASE_IDIR}/autotools${TOOL_VERS}
export KROOT_IDIR=${BASE_IDIR}/krellroot${TOOL_VERS}
export CBTF_IDIR=${BASE_IDIR}/cbtf${TOOL_VERS}
export OSSCBTF_IDIR=${BASE_IDIR}/osscbtf${TOOL_VERS}
export OSSOFF_IDIR=${BASE_IDIR}/ossoff${TOOL_VERS}

export cc=gcc
export CC=gcc
export CXX=g++

./install-tool --build-autotools --krell-root-prefix ${LTDL_IDIR}
./install-tool --build-python --krell-root-prefix ${PYTHON_IDIR}

# Build root components 
./install-tool --build-krell-root --krell-root-prefix ${KROOT_IDIR} --with-mpich ${MPICH_IDIR} --with-ltdl ${LTDL_IDIR} --force-boost-build --with-openmpi ${OPENMPI_IDIR} --with-python ${PYTHON_IDIR} --with-python-vers ${PYTHON_VERS} 

./install-tool --build-offline --openss-prefix ${OSSOFF_IDIR} --krell-root-prefix  ${KROOT_IDIR} --with-mpich ${MPICH_IDIR} --with-ltdl ${LTDL_IDIR} --with-openmpi ${OPENMPI_IDIR} --with-python ${PYTHON_IDIR} --with-python-vers ${PYTHON_VERS}

./install-tool --build-cbtf-all --cbtf-prefix ${CBTF_IDIR} --krell-root-prefix  ${KROOT_IDIR} --with-mpich ${MPICH_IDIR} --with-ltdl ${LTDL_IDIR} --with-openmpi ${OPENMPI_IDIR} --with-python ${PYTHON_IDIR} --with-python-vers ${PYTHON_VERS}

./install-tool --build-onlyosscbtf --openss-prefix ${OSSCBTF_IDIR} --krell-root-prefix ${KROOT_IDIR} --cbtf-prefix ${CBTF_IDIR} --with-mpich ${MPICH_IDIR} --with-ltdl ${LTDL_IDIR} --with-openmpi ${OPENMPI_IDIR} --with-python ${PYTHON_IDIR} --with-python-vers ${PYTHON_VERS}
 
# Compiling with a module loaded non-default installed compiler requires that the libstc++ library be made available on the compute nodes 
cp /gpfs/pkgs/mhpcc/gcc-4.9.3//lib64/libstdc++.so.6 ${KROOT_IDIR}/lib64/libstdc++.so.6
