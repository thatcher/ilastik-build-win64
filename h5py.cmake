#
# Install h5py library from source
#

if (NOT h5py_NAME)

CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

include (ExternalProject)
include (ExternalSource)

include (python)
include (hdf5)
#include (numpy)

external_source (h5py
    2.2.1
    h5py-2.2.1.tar.gz
    07ac707287b4be7d77b73f1afac6980b
    https://pypi.python.org/packages/source/h/h5py
    FORCE)

# Fix library and path names in setup.py
set (h5py_PATCH ${PYTHON_EXE} ${PROJECT_SOURCE_DIR}/patches/patch_h5py.py ${h5py_SRC_DIR})

message ("Installing ${h5py_NAME} into ilastik build area: ${ILASTIK_DEPENDENCY_DIR} ...")
ExternalProject_Add(${h5py_NAME}
    DEPENDS             ${python_NAME} ${hdf5_NAME} ${numpy_NAME}
    PREFIX              ${ILASTIK_DEPENDENCY_DIR}
    URL                 ${h5py_URL}
    URL_MD5             ${h5py_MD5}
    UPDATE_COMMAND      ""
    PATCH_COMMAND       ${h5py_PATCH}
    CONFIGURE_COMMAND   ""
    BUILD_COMMAND       ${ADD_PATH} "${ILASTIK_DEPENDENCY_DIR}/bin"
                     \n ${PYTHON_EXE} setup.py build_ext 
                            -c msvc
                            -L ${ILASTIK_DEPENDENCY_DIR}/lib
                            -I ${ILASTIK_DEPENDENCY_DIR}/include
    BUILD_IN_SOURCE     1
    TEST_COMMAND        ""
    INSTALL_COMMAND     ${ADD_PATH} "${ILASTIK_DEPENDENCY_DIR}/bin"
                     \n ${PYTHON_EXE} setup.py install
)

set_target_properties(${h5py_NAME} PROPERTIES EXCLUDE_FROM_ALL ON)

endif (NOT h5py_NAME)
