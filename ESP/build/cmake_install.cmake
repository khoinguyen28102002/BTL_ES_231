<<<<<<< HEAD:ESP/build/cmake_install.cmake
# Install script for directory: D:/HK231/HTN/BTL/Code/Code/sample_project
=======
# Install script for directory: D:/UniversityProject/embedded_system_subject_assignment/BTL_ES_231/data_reader
>>>>>>> 2561197efd2b775a1f31193203379d7ec7822d8f:data_reader/build/cmake_install.cmake

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "C:/Program Files (x86)/main")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "TRUE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
<<<<<<< HEAD:ESP/build/cmake_install.cmake
  set(CMAKE_OBJDUMP "C:/Espressif/.espressif/tools/xtensa-esp32-elf/esp-12.2.0_20230208/xtensa-esp32-elf/bin/xtensa-esp32-elf-objdump.exe")
=======
  set(CMAKE_OBJDUMP "D:/Embedded_Programming/ESP/esp-idf_extension/.espressif/tools/xtensa-esp32-elf/esp-12.2.0_20230208/xtensa-esp32-elf/bin/xtensa-esp32-elf-objdump.exe")
>>>>>>> 2561197efd2b775a1f31193203379d7ec7822d8f:data_reader/build/cmake_install.cmake
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
<<<<<<< HEAD:ESP/build/cmake_install.cmake
  include("D:/HK231/HTN/BTL/Code/Code/sample_project/build/esp-idf/cmake_install.cmake")
=======
  include("D:/UniversityProject/embedded_system_subject_assignment/BTL_ES_231/data_reader/build/esp-idf/cmake_install.cmake")
>>>>>>> 2561197efd2b775a1f31193203379d7ec7822d8f:data_reader/build/cmake_install.cmake
endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
<<<<<<< HEAD:ESP/build/cmake_install.cmake
file(WRITE "D:/HK231/HTN/BTL/Code/Code/sample_project/build/${CMAKE_INSTALL_MANIFEST}"
=======
file(WRITE "D:/UniversityProject/embedded_system_subject_assignment/BTL_ES_231/data_reader/build/${CMAKE_INSTALL_MANIFEST}"
>>>>>>> 2561197efd2b775a1f31193203379d7ec7822d8f:data_reader/build/cmake_install.cmake
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
