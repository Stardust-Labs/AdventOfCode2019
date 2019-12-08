import 'dart:io';
import '../resources/intcode_interpreter.dart';

void main() {
  File input = new File('../resources/input');
  String inputIntcode = input.readAsStringSync();

  IntcodeInterpreter computer = new IntcodeInterpreter();
  Intcode diagnostic = new Intcode(inputIntcode);

  computer.run(diagnostic, input: 5);

  File output = new File('./output');
  output.writeAsStringSync(diagnostic.code.join(','));

  File answer = new File('./answer');
  answer.writeAsStringSync(computer.stdout.toString());
}