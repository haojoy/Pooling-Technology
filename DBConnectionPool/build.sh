#!/bin/bash

# 启用命令跟踪
set -x

# 定义日志文件
LOGFILE="build.log"

# 清理日志文件
echo "Starting build process..." > "$LOGFILE"

# 定义构建目录
BUILD_DIR="$(pwd)/build"

# 删除构建目录中的所有文件
echo "Cleaning build directory: $BUILD_DIR" >> "$LOGFILE"
rm -rf "$BUILD_DIR"/*
if [ $? -ne 0 ]; then
    echo "Failed to clean build directory" >> "$LOGFILE"
    exit 1
fi

# 切换到构建目录
cd "$BUILD_DIR" || { echo "Failed to change directory to $BUILD_DIR" >> "$LOGFILE"; exit 1; }

# 运行 CMake 配置项目
echo "Running CMake..." >> "$LOGFILE"
cmake .. >> "$LOGFILE" 2>&1
if [ $? -ne 0 ]; then
    echo "CMake configuration failed" >> "$LOGFILE"
    exit 1
fi

# 运行 Make 编译项目
echo "Running make..." >> "$LOGFILE"
make >> "$LOGFILE" 2>&1
if [ $? -ne 0 ]; then
    echo "Build failed" >> "$LOGFILE"
    exit 1
fi

echo "Build completed successfully" >> "$LOGFILE"
