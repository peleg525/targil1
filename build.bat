@echo off
rem Builds workshops-model.jar and workshops-logic.jar into artifacts\ and runs the tester.
setlocal
cd /d "%~dp0"

if exist out rmdir /s /q out
mkdir out\model out\logic
if not exist artifacts mkdir artifacts

javac --release 25 -cp model-1.0.jar -d out\model model\src\patmal\workshops\model\*.java || exit /b 1
jar cf artifacts\workshops-model.jar -C out\model . || exit /b 1

javac --release 25 -cp "model-1.0.jar;logic-1.0.jar;artifacts\workshops-model.jar" -d out\logic logic\src\patmal\workshops\logic\*.java || exit /b 1
jar cf artifacts\workshops-logic.jar -C out\logic . || exit /b 1

java -cp "workshop-tester.jar;logic-1.0.jar;model-1.0.jar;artifacts\workshops-model.jar;artifacts\workshops-logic.jar" patmal.workshops.main.Main
