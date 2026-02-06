

cmake_minimum_required(VERSION 3.5)

project(KCOMBU_BSS C)

set(CMAKE_C_STANDARD 17)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS_RELEASE} -Wno-deprecated-non-prototype -Wno-implicit-int")

add_definitions("-D_USE_MATH_DEFINES")

set(COMMON_SOURCES
    match.c
    io_match.c
    buildup.c
    clique.c
    c_clique.c
    MrgSrtMATCH.c
    ioLib.c
    ioLINE.c
    2DMAP.c
    ioSDF.c
    ioKCF.c
    ioMOL2.c
    ioSMILES.c
    kcombu_io_CIF.c
    MOLECULE_from_CCD_CIF.c
    gen2D.c
    disgeo2D.c
    qRMS.c
    2dRMS.c
    PCAfit.c
    molprop.c
    molring.c
    moltopodis.c
    molpermu.c
    options.c
    ringblock.c
    RingDesc.c
    vector3.c
    outPS.c
    energies.c
    stereo_check.c
    ReadOpt.c
    ioPDB.c
)

set(CKCOMBU_SOURCES
    ckcombu.c
    ${COMMON_SOURCES}
)

set(DKCOMBU_SOURCES
    dkcombu.c
    AtmPairDesc.c
    DualAtmPair.c
    MrgSrtLIBMOL.c
    stereo_check.c
    ${COMMON_SOURCES}
)

set(FKCOMBU_SOURCES
    fkcombu.c
    transform.c
    energies.c
    steep_descen.c
    tpdisrest.c
    stamp_transf.c
    stereo_adjust.c
    ${COMMON_SOURCES}
)

set(LKCOMBU_SOURCES
    lkcombu.c
    MrgSrtLIBMOL.c
    ${COMMON_SOURCES}
)

set(PKCOMBU_SOURCES
    pkcombu.c
    ${COMMON_SOURCES}
)

set(SMICOMP_SOURCES
    SmiComp.c
)

set(TREEUN_SOURCES
    TreeUN.c
)

set(PROPSEARCH_SOURCES
    propsearch.c
)

add_executable(ckcombu ${CKCOMBU_SOURCES})
add_executable(dkcombu ${DKCOMBU_SOURCES})
add_executable(fkcombu ${FKCOMBU_SOURCES})
add_executable(lkcombu ${LKCOMBU_SOURCES})
add_executable(pkcombu ${PKCOMBU_SOURCES})
add_executable(smicomp ${SMICOMP_SOURCES})
add_executable(treeun ${TREEUN_SOURCES})
add_executable(propsearch ${PROPSEARCH_SOURCES})

if (WIN32)
  message(STATUS "Not linking to the math library")
else()
  target_link_libraries(ckcombu m)
  target_link_libraries(dkcombu m)
  target_link_libraries(fkcombu m)
  target_link_libraries(lkcombu m)
  target_link_libraries(pkcombu m)
  target_link_libraries(smicomp m)
  target_link_libraries(treeun m)
  target_link_libraries(propsearch m)
endif()

# Set the installation path automatically if this is a conda build
if ("$ENV{CONDA_BUILD}" STREQUAL "1")
  set(KCOMBU_PREFIX "$ENV{PREFIX}")

  message(STATUS "Performing a conda build installing to ${KCOMBU_PREFIX}")

  if (WIN32)
    string(REPLACE "\\" "/" KCOMBU_PREFIX ${KCOMBU_PREFIX})
    set(CMAKE_INSTALL_PREFIX "${KCOMBU_PREFIX}")
    set(KCOMBU_BINDIR "Scripts")
  else()
    set(CMAKE_INSTALL_PREFIX "${KCOMBU_PREFIX}")
    set(KCOMBU_BINDIR "bin")
  endif()

else()
  message(STATUS "Installing using prefix ${CMAKE_INSTALL_PREFIX}")
  set(KCOMBU_BINDIR "bin")
endif()

# installation
install(TARGETS ckcombu dkcombu fkcombu
                lkcombu pkcombu
                smicomp treeun propsearch
        RUNTIME DESTINATION "${KCOMBU_BINDIR}")
