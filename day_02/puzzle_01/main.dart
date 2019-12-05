import './intcode_interpreter.dart';

void main() {
  String testIntcode = '1,9,10,3,2,3,11,0,99,30,40,50';

  IntcodeInterpreter interpreter = new IntcodeInterpreter(testIntcode);

  interpreter.run();

  print(interpreter.intcode);
}