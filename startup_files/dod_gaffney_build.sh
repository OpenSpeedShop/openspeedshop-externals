#!/bin/bash

#BASE_DIR=/p/home/galarowi
BASE_DIR=/p/app/PET/pkgs/openss
TOOL_VERS="_v2.4.1.release"
ROOT_VERS="_v2.4.1.release"
GRAPHVIZ_VERS="-2.40.1"
QTGRAPH_VERS="-1.0.0"

MPT_IDIR=/p/app/hpe/mpt-2.18
MPICH_IDIR=/p/app/intel/parallel_studio_xe_2019_update4/impi/2019.4.243/intel64
# Can build multiple mpi, mpit, mpip collectors if desired
# Must enable these lines with actual paths 
# and add --with-mpich and/or --with-mvapich2 to the install-tool
# lines that have --with-openmpi below
#MVAPICH2_IDIR=<path to mvapich2 install>
#MPICH_IDIR=<path to mpich install>

KROOT_IDIR=${BASE_DIR}/krellroot${ROOT_VERS}
LTDL_IDIR=${BASE_DIR}/autotools${ROOT_VERS}
CBTF_IDIR=${BASE_DIR}/cbtf${TOOL_VERS}
OSSCBTF_IDIR=${BASE_DIR}/osscbtf${TOOL_VERS}
OSSOFF_IDIR=${BASE_DIR}/ossoff${TOOL_VERS}
CUDA_IDIR=/p/app/cuda/9.1
CUPTI_IDIR=${CUDA_IDIR}/extras/CUPTI
GRAPHVIZ_IDIR=${BASE_DIR}/graphviz${GRAPHVIZ_VERS}
QTGRAPH_IDIR=${BASE_DIR}/QtGraph${QTGRAPH_VERS}

./install-tool --verbose --build-autotools --krell-root-prefix ${LTDL_IDIR}  2>&1 | tee install_tool_build_autotools.log
# Build the externals needed by cbtf and openspeedshop
#./install-tool --verbose --build-krell-root --krell-root-prefix ${KROOT_IDIR} --with-mpich ${MPICH_IDIR} --with-mpt ${MPT_IDIR} 2>&1 | tee install_tool_build_krell_root.log

# Build cbtf (base cbtf support) , cbtf-krell (collectors, runtimes), cbtf-argonavis (gpu support), cbtf-lanl (sys admin tools)
./install-tool --verbose --build-cbtf-all --cbtf-prefix ${CBTF_IDIR} --krell-root-prefix ${KROOT_IDIR} --with-mpich ${MPICH_IDIR} --with-mpt ${MPT_IDIR} --with-ltdl ${LTDL_IDIR}  2>&1 | tee install_tool_build_cbtf.log

# Build openspeedshop using cbtf components and the root external packages
./install-tool --verbose --build-oss --openss-prefix ${OSSCBTF_IDIR} --cbtf-prefix ${CBTF_IDIR} --krell-root-prefix ${KROOT_IDIR} --with-mpich ${MPICH_IDIR} --with-mpt ${MPT_IDIR} --with-ltdl ${LTDL_IDIR} 2>&1 | tee install_tool_build_oss.log

# IF BUILDING THE NEW GUI INTERFACE

# Build graphviz for support of building the new cbtf-argonavis-gui
#./install-tool --build-graphviz --krell-root-prefix ${GRAPHVIZ_IDIR}

# Build QtGraph for support of building the new cbtf-argonavis-gui, uses graphviz
#./install-tool --build-QtGraph --krell-root-prefix ${QTGRAPH_IDIR} --with-graphviz ${GRAPHVIZ_IDIR} --with-qt /usr/lib64/qt5

# Build new cbtf-argonavis-gui, uses graphviz and QtGraph 
#./install-tool --build-cbtfargonavisgui --with-openss ${OSSCBTF_IDIR} --with-cbtf ${CBTF_IDIR} --krell-root-prefix ${KROOT_IDIR} --with-graphviz ${GRAPHVIZ_IDIR} --with-QtGraph ${QTGRAPH_IDIR} --with-boost ${KROOT_IDIR} --with-qt /usr/lib64/qt5 2>&1 | tee install_tool_build_cbtf_gui.log
