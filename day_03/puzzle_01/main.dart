import './wire.dart';
import 'dart:io';

void main() {
  File input = new File('./input');
  List<String> inputInstructions = input.readAsLinesSync();

  WireBox wireBox = new WireBox();

  inputInstructions.forEach((instruction) => wireBox.addWire(instruction));

  File outputs = new File('./outputs');
  IOSink outputSink = outputs.openWrite();

  int answer;

  wireBox.intersections.forEach((intersection) {
    int manhattanDistance = Coordinate.manhattanDistance(new Coordinate(0,0), intersection);
    if (answer == null || answer == 0) answer = manhattanDistance;
    else if (answer > manhattanDistance && manhattanDistance != 0) answer = manhattanDistance;

    outputSink.write(
      'Intersection at Coordinate ${intersection.x}, ${intersection.y} ' +
      'with Manhattan distance from origin of ${manhattanDistance}\n'
    );
  });

  outputSink.close();

  File answerFile = new File('./answer');
  answerFile.writeAsStringSync(answer.toString());
}