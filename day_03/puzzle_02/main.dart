import '../puzzle_01/wire.dart';
import 'dart:io';

void main() {
  File input = new File('./input');
  List<String> instructions = input.readAsLinesSync();

  WireBox wireBox = new WireBox();

  instructions.forEach((instruction) => wireBox.addWire(instruction));

  int smallestStepCount;

  File output = new File('./output');
  IOSink outputSink = output.openWrite();

  wireBox.intersections.forEach((intersection) {

    outputSink.write('Steps to reach intersection ${intersection.toString()}:\n');

    List<int> stepsToIntersection = [];
    wireBox.wires.forEach((wire) {
      int steps = wire.wirePath.indexOf(intersection) + 1;
      stepsToIntersection.add(steps);
      outputSink.write('\t${steps} steps for Wire ${wire.hashCode}\n');
    });

    int sumSteps = stepsToIntersection.reduce((a, b) => a + b);
    outputSink.write('\t${sumSteps} total steps for intersection\n');

    if (smallestStepCount == null || smallestStepCount == 0) {
      smallestStepCount = sumSteps;
    } else if (smallestStepCount > sumSteps) {
      smallestStepCount = sumSteps;
    }
  });

  outputSink.close();

  File answer = new File('./answer');
  answer.writeAsStringSync(smallestStepCount.toString());
}