# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "C:/Espressif/esp/esp-idf/esp-idf/components/bootloader/subproject"
  "D:/HK231/HTN/BTL/Code/Code/sample_project/build/bootloader"
  "D:/HK231/HTN/BTL/Code/Code/sample_project/build/bootloader-prefix"
  "D:/HK231/HTN/BTL/Code/Code/sample_project/build/bootloader-prefix/tmp"
  "D:/HK231/HTN/BTL/Code/Code/sample_project/build/bootloader-prefix/src/bootloader-stamp"
  "D:/HK231/HTN/BTL/Code/Code/sample_project/build/bootloader-prefix/src"
  "D:/HK231/HTN/BTL/Code/Code/sample_project/build/bootloader-prefix/src/bootloader-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "D:/HK231/HTN/BTL/Code/Code/sample_project/build/bootloader-prefix/src/bootloader-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "D:/HK231/HTN/BTL/Code/Code/sample_project/build/bootloader-prefix/src/bootloader-stamp${cfgdir}") # cfgdir has leading slash
endif()
