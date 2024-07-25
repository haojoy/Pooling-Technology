cmake_minimum_required(VERSION 3.0)
project(mysqlconnpool)

# 设置调试信息以及启动C++14语言标准
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -std=c++14 -fPIC")

# 配置最终的可执行文件和库文件输出的路径
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)
#set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/lib)

find_package(PkgConfig REQUIRED)
pkg_check_modules(MYSQL REQUIRED mysqlclient)

if (MYSQL_FOUND)
    include_directories(${MYSQL_INCLUDE_DIRS})
    link_directories(${MYSQL_LIBRARY_DIRS})
else()
    message(FATAL_ERROR "MySQL not found")
endif()
include_directories(${PROJECT_SOURCE_DIR}/include)
aux_source_directory(./src SRC_LIST)
add_executable(mysqlconnpool ${SRC_LIST})

# 链接库
target_link_libraries(mysqlconnpool pthread ${MYSQL_LIBRARIES})