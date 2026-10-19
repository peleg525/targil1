#!/bin/bash
# Builds workshops-model.jar and workshops-logic.jar into artifacts/ and runs the tester.
set -e
cd "$(dirname "$0")"

rm -rf out
mkdir -p out/model out/logic artifacts

javac --release 25 -cp model-1.0.jar -d out/model $(find model/src -name "*.java")
jar cf artifacts/workshops-model.jar -C out/model .

javac --release 25 -cp model-1.0.jar:logic-1.0.jar:artifacts/workshops-model.jar -d out/logic $(find logic/src -name "*.java")
jar cf artifacts/workshops-logic.jar -C out/logic .

java -cp workshop-tester.jar:logic-1.0.jar:model-1.0.jar:artifacts/workshops-model.jar:artifacts/workshops-logic.jar patmal.workshops.main.Main
