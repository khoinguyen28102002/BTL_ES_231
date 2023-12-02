<<<<<<< HEAD:ESP/build/esp-idf/mbedtls/mbedtls/library/cmake_install.cmake
# Install script for directory: C:/Espressif/esp/esp-idf/esp-idf/components/mbedtls/mbedtls/library
=======
# Install script for directory: D:/Embedded_Programming/ESP/esp-idf_extension/esp/esp-idf/components/mbedtls/mbedtls/library
>>>>>>> 2561197efd2b775a1f31193203379d7ec7822d8f:data_reader/build/esp-idf/mbedtls/mbedtls/library/cmake_install.cmake

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
<<<<<<< HEAD:ESP/build/esp-idf/mbedtls/mbedtls/library/cmake_install.cmake
  set(CMAKE_OBJDUMP "C:/Espressif/.espressif/tools/xtensa-esp32-elf/esp-12.2.0_20230208/xtensa-esp32-elf/bin/xtensa-esp32-elf-objdump.exe")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "D:/HK231/HTN/BTL/Code/Code/sample_project/build/esp-idf/mbedtls/mbedtls/library/libmbedcrypto.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "D:/HK231/HTN/BTL/Code/Code/sample_project/build/esp-idf/mbedtls/mbedtls/library/libmbedx509.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "D:/HK231/HTN/BTL/Code/Code/sample_project/build/esp-idf/mbedtls/mbedtls/library/libmbedtls.a")
=======
  set(CMAKE_OBJDUMP "D:/Embedded_Programming/ESP/esp-idf_extension/.espressif/tools/xtensa-esp32-elf/esp-12.2.0_20230208/xtensa-esp32-elf/bin/xtensa-esp32-elf-objdump.exe")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "D:/UniversityProject/embedded_system_subject_assignment/BTL_ES_231/data_reader/build/esp-idf/mbedtls/mbedtls/library/libmbedcrypto.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "D:/UniversityProject/embedded_system_subject_assignment/BTL_ES_231/data_reader/build/esp-idf/mbedtls/mbedtls/library/libmbedx509.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "D:/UniversityProject/embedded_system_subject_assignment/BTL_ES_231/data_reader/build/esp-idf/mbedtls/mbedtls/library/libmbedtls.a")
>>>>>>> 2561197efd2b775a1f31193203379d7ec7822d8f:data_reader/build/esp-idf/mbedtls/mbedtls/library/cmake_install.cmake
endif()

