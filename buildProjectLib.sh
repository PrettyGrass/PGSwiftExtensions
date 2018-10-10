#!/bin/sh

ScriptSelf=$(cd "$(dirname "$0")"; pwd)
cd $ScriptSelf
echo "当前目录:"
pwd

sh ./buildLibs.sh PGSwiftExtensions
