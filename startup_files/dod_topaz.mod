#%Module1.0#####################################################################
##
## openss modulefile
##
proc ModulesHelp { } {
        global version osscbtf

        puts stderr "\topenss - loads the OpenSpeedShop software & application environment"
        puts stderr "\n\tThis adds $oss/* to several of the"
        puts stderr "\tenvironment variables."
        puts stderr "\n\tVersion $version\n"
}

module-whatis   "loads the OpenSpeedShop runtime environment"

# for Tcl script use only
set     version         2.4.1.release
set     root_native        /app/unsupported/PETtools/CE/pkgs/openss/krellroot_v2.4.1.release
set     oss_native         /app/unsupported/PETtools/CE/pkgs/openss/osscbtf_v2.4.1.release.mpich
set     cbtf_native        /app/unsupported/PETtools/CE/pkgs/openss/cbtf_v2.4.1.release.mpich
set     boost_root         /app/unsupported/PETtools/CE/pkgs/openss/krellroot_v2.4.1.release
set     qt3_root         /app/unsupported/PETtools/CE/pkgs/openss/krellroot_v2.4.1.release/qt3
set      gcc_env           /apps/gnu_compiler/4.8.5
#set     cuda_root	   /p/home/apps/cuda/7.5
#set     cupti_root	   /p/home/apps/cuda/7.5/extras/CUPTI

setenv          CBTF_MPI_IMPLEMENTATION	mpt
setenv          OPENSS_MPI_IMPLEMENTATION	mpt
setenv          OPENSS_DOC_DIR		$oss_native/share/doc/packages/OpenSpeedShop
setenv		XPLAT_RSH	ssh
setenv		OPENSS_RAWDATA_DIR	.

prepend-path    PATH			$root_native/bin
prepend-path    PATH			$cbtf_native/bin
prepend-path    PATH			$cbtf_native/sbin
prepend-path    PATH			$oss_native/bin
prepend-path    MANPATH			$oss_native/share/man

eval set  [ array get env HOME ]
set     ownmoddir       $HOME/privatemodules

setenv  OPENSS_PLUGIN_PATH   $oss_native/lib64/openspeedshop
setenv  MRNET_COMM_PATH $cbtf_native/sbin/cbtf_mrnet_commnode
setenv  CBTF_MRNET_BACKEND_PATH $cbtf_native/sbin/cbtf_libcbtf_mrnet_backend

setenv DYNINSTAPI_RT_LIB $root_native/lib64/libdyninstAPI_RT.so
prepend-path LD_LIBRARY_PATH $root_native/lib64
prepend-path LD_LIBRARY_PATH $cbtf_native/lib64
prepend-path LD_LIBRARY_PATH $boost_root/lib
prepend-path LD_LIBRARY_PATH $oss_native/lib64
prepend-path LD_LIBRARY_PATH $qt3_root/lib64
prepend-path LD_LIBRARY_PATH $qt3_root/lib
#prepend-path LD_LIBRARY_PATH $cuda_root/lib64
prepend-path LD_LIBRARY_PATH $gcc_env/lib64

