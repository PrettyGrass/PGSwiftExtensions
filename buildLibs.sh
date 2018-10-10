#!/bin/bash

# 第$1个参数 要编译的 target 名 必选 all-target 则是全部
# 第$2个参数 要编译的 project 名 可选
# 第$3个参数 要编译的 project 路径 可选

ScriptSelf=$(cd "$(dirname "$0")"; pwd)
cd $ScriptSelf
echo "当前目录:"
pwd

# 配置
BUILD_DIR=build
BUILD_ROOT=build
TARGET_LIB_FOLDER=$ScriptSelf/libs
CONFIGURATION=Release
VALID_ARCHS="armv7 i386 x86_64 arm64"

PROJECT_PATH=$3
if  [ ! -n "$PROJECT_PATH" ] ;then
	PROJECT_PATH=./
fi
cd $PROJECT_PATH
echo "工作目录:"
pwd

# 清理
if [ ! -d "${TARGET_LIB_FOLDER}" ]; then  
	mkdir ${TARGET_LIB_FOLDER};
fi

if [[ -d "$BUILD_ROOT" ]]; then
	rm -rf "$BUILD_ROOT"
fi

# 检查
BASE_PROJECT_NAME=$2
if  [ ! -n "$BASE_PROJECT_NAME" ] ;then
	BASE_PROJECT_NAME=$(ls -d *.xcodeproj)
fi
LIB_NAME=$1
if  [ ! -n "$LIB_NAME" ] ;then
	echo "LIB_NAME 为空!"
fi

echo '开始编译'
# iOS真机
xcodebuild -project ${BASE_PROJECT_NAME} OTHER_CFLAGS="-fembed-bitcode" -target ${LIB_NAME} ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphoneos  BUILD_DIR=$BUILD_DIR BUILD_ROOT=$BUILD_ROOT IPHONEOS_DEPLOYMENT_TARGET=8.0 VALID_ARCHS="$VALID_ARCHS"
RET=$?
if [[ ! $RET = 0 ]]; then
	echo "真机平台编译失败:$RET"
	exit $RET
fi
# iOS模拟器 -arch x86_64
xcodebuild -project ${BASE_PROJECT_NAME} OTHER_CFLAGS="-fembed-bitcode" -target ${LIB_NAME} ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphonesimulator BUILD_DIR=$BUILD_DIR BUILD_ROOT=$BUILD_ROOT IPHONEOS_DEPLOYMENT_TARGET=8.0 VALID_ARCHS="$VALID_ARCHS"
RET=$?
if [[ ! $RET = 0 ]]; then
	echo "模拟器平台编译失败:$RET" 
	exit $RET
fi

# 合并
echo '编译完成,合并'
pwd

# 兼容cocoapods 的target输出的.a 移动到统一目录
cp ${BUILD_DIR}/${CONFIGURATION}-iphoneos/**/*.a ${BUILD_DIR}/${CONFIGURATION}-iphoneos
cp ${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/**/*.a ${BUILD_DIR}/${CONFIGURATION}-iphonesimulator

for LIB_PATH in `ls ${BUILD_DIR}/${CONFIGURATION}-iphoneos/*.a`; do
	LIB_NAME=${LIB_PATH##*\/}
	LIB_NAME=${LIB_NAME%\.*}
	# 对应的模拟器库路径
	SIM_LIB_PATH=${LIB_PATH//iphoneos/iphonesimulator}
	echo "库名:$LIB_NAME 真机库路径: $LIB_PATH 模拟器库路径: $SIM_LIB_PATH "
	
	LINE="lipo -create ${LIB_PATH} ${SIM_LIB_PATH} -output ${TARGET_LIB_FOLDER}/${LIB_NAME}-universal.a"
	echo "合并库:" $LINE
	$LINE
    INFO=$(lipo -info ${TARGET_LIB_FOLDER}/${LIB_NAME}-universal.a)
	
    echo $INFO
	if [[ ! ${INFO} =~ ${VALID_ARCHS} ]]
	then
	  	echo '支持CPU平台检查不通过, 需要支持:' $VALID_ARCHS
	  	exit -1
	else
		echo '支持CPU平台检查通过, 支持:' ${VALID_ARCHS}
	fi

	echo 'bitcode 检查,对于静态库来说,下面的值不为 0 则说明支持bitcode'
	otool -arch armv7 -l ${TARGET_LIB_FOLDER}/${LIB_NAME}-universal.a | grep __bitcode | wc -l
done
open ${TARGET_LIB_FOLDER}
echo '通用静态库制作完成'
