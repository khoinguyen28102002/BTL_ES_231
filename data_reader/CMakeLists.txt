# For more information about build system see
# https://docs.espressif.com/projects/esp-idf/en/latest/api-guides/build-system.html
# The following five lines of boilerplate have to be in your project's
# CMakeLists in this exact order for cmake to work correctly
cmake_minimum_required(VERSION 3.16)
# set(SOURCES "C:/Users/admin/Desktop/esp/sample_project/main/main.c"
#             "C:/Users/admin/Desktop/esp/sample_project/libraries/esp-idf-lib/components/dht/dht.c")
# set(COMPONENT_ADD_INCLUDEDIRS "C:/Users/admin/Desktop/esp/sample_project/libraries/esp-idf-lib/components/dht")
include($ENV{IDF_PATH}/tools/cmake/project.cmake)
project(main)
