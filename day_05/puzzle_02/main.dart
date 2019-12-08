import 'dart:io';
import '../resources/intcode_interpreter.dart';

void main() {
  File input = new File('../resources/input');
  String inputIntcode = input.readAsStringSync();

  IntcodeInterpreter computer = new IntcodeInterpreter();
  Intcode diagnostic = new Intcode(inputIntcode);

  computer.run(diagnostic);
}