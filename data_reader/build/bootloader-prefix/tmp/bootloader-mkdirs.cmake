# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "D:/Embedded_Programming/ESP/esp-idf_extension/esp/esp-idf/components/bootloader/subproject"
  "D:/UniversityProject/embedded_system_subject_assignment/BTL_ES_231/data_reader/build/bootloader"
  "D:/UniversityProject/embedded_system_subject_assignment/BTL_ES_231/data_reader/build/bootloader-prefix"
  "D:/UniversityProject/embedded_system_subject_assignment/BTL_ES_231/data_reader/build/bootloader-prefix/tmp"
  "D:/UniversityProject/embedded_system_subject_assignment/BTL_ES_231/data_reader/build/bootloader-prefix/src/bootloader-stamp"
  "D:/UniversityProject/embedded_system_subject_assignment/BTL_ES_231/data_reader/build/bootloader-prefix/src"
  "D:/UniversityProject/embedded_system_subject_assignment/BTL_ES_231/data_reader/build/bootloader-prefix/src/bootloader-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "D:/UniversityProject/embedded_system_subject_assignment/BTL_ES_231/data_reader/build/bootloader-prefix/src/bootloader-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "D:/UniversityProject/embedded_system_subject_assignment/BTL_ES_231/data_reader/build/bootloader-prefix/src/bootloader-stamp${cfgdir}") # cfgdir has leading slash
endif()
