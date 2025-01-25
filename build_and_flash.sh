#!/usr/bin/zsh

# 设置项目路径
PROJECT_PATH="/home/wjj/esp/esp-idf/examples/get-started/hello_world"
BUILD_DIR="${PROJECT_PATH}/build"
PORT="/dev/ttyUSB0"  # 根据你的实际串口设备修改

# 清理构建目录
echo "Cleaning build directory..."
rm -rf "${BUILD_DIR}/CMakeCache.txt"
rm -rf "${BUILD_DIR}/CMakeFiles"

# 进入项目目录
cd "${PROJECT_PATH}" || exit 1

# 编译项目
echo "Building project..."
idf.py -G Ninja build
if [ $? -ne 0 ]; then
    echo "Build failed!"
    exit 1
fi

# 烧录固件
echo "Flashing firmware to device..."
idf.py -p "${PORT}" flash
if [ $? -ne 0 ]; then
    echo "Flashing failed!"
    exit 1
fi

# 监视串口输出
echo "Monitoring serial output..."
idf.py -p "${PORT}" monitor
