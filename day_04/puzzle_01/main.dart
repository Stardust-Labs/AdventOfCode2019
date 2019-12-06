import './Code.dart';
import 'dart:io';

void main() {
  File inputFile = new File('../resources/input');
  List<String> inputs = inputFile.readAsLinesSync();

  int min = int.parse(inputs[0]);
  int max = int.parse(inputs[1]);

  print('${min}, ${max}');

  List<Password> passwords = [];

  File outputFile = new File('./output');
  IOSink outputSink = outputFile.openWrite();

  for (int iter = min; iter <= max; iter++) {
    Password possiblePassword = new Password(iter);
    if (possiblePassword.isValid()) {
      passwords.add(possiblePassword);
      outputSink.write('${possiblePassword.toString()}\n');
    }
  }

  outputSink.close();

  File answerFile = new File('./answer');
  answerFile.writeAsStringSync(passwords.length.toString());
}