import 'dart:io';

import './intcode_interpreter.dart';

void main() {
  File input = new File('./input');
  String inputIntcode = input.readAsStringSync();

  IntcodeInterpreter interpreter = new IntcodeInterpreter(inputIntcode);

  interpreter.intcode[1] = 12;
  interpreter.intcode[2] = 2;

  print(interpreter.intcode);

  interpreter.run();

  File output = new File('./output');
  output.writeAsStringSync(interpreter.intcode.join(','));

  File answer = new File('./answer');
  answer.writeAsStringSync(interpreter.intcode[0].toString());
}