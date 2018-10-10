#!/bin/bash

# 第$1个参数 要编译的 target 名 必选 all-target 则是全部
# 第$2个参数 要编译的 project 名 可选
# 第$3个参数 要编译的 project 路径 可选

ScriptSelf=$(cd "$(dirname "$0")"; pwd)
cd $ScriptSelf
echo "当前目录:"
pwd

sh ./buildLibs.sh PGSwiftExtensions Pods.xcodeproj ./test/PGSwiftExtensionsDemo/Pods
