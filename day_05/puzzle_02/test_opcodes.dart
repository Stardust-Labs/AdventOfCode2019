import '../resources/intcode_interpreter.dart';

void main() {
  List<Intcode> intcodes = [
    new Intcode('3,9,8,9,10,9,4,9,99,-1,8'),
    new Intcode('3,9,7,9,10,9,4,9,99,-1,8'),
    new Intcode('3,3,1108,-1,8,3,4,3,99'),
    new Intcode('3,3,1107,-1,8,3,4,3,99'),
    new Intcode('3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9'),
    new Intcode('3,3,1105,-1,9,1101,0,0,12,4,12,99,1'),
    new Intcode(
      '3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,' +
      '1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,' +
      '999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99'
    )
  ];

  IntcodeInterpreter computer = new IntcodeInterpreter();

  computer.run(intcodes[0], input: 7);
  print('Intcode 1 false output test: ${computer.stdout == 0}');
  intcodes[0].reset();
  computer.run(intcodes[0], input: 8);
  print('Intcode 1 false output test: ${computer.stdout == 1}');
  computer.run(intcodes[1], input: 7);
  print('Intcode 2 false output test: ${computer.stdout == 1}');
  intcodes[1].reset();
  computer.run(intcodes[1], input: 8);
  print('Intcode 2 false output test: ${computer.stdout == 0}');
  computer.run(intcodes[2], input: 7);
  print('Intcode 3 false output test: ${computer.stdout == 0}');
  intcodes[2].reset();
  computer.run(intcodes[2], input: 8);
  print('Intcode 3 false output test: ${computer.stdout == 1}');
  computer.run(intcodes[3], input: 7);
  print('Intcode 4 false output test: ${computer.stdout == 1}');
  intcodes[3].reset();
  computer.run(intcodes[3], input: 8);
  print('Intcode 4 false output test: ${computer.stdout == 0}');

  computer.run(intcodes[4], input: 0);
  print('Intcode 5 output 0 test: ${computer.stdout == 0}');
  intcodes[4].reset();
  computer.run(intcodes[4], input: 200);
  print('Intcode 5 output 1 test: ${computer.stdout == 1}');
  computer.run(intcodes[5], input: 0);
  print('Intcode 6 output 0 test: ${computer.stdout == 0}');
  intcodes[5].reset();
  computer.run(intcodes[5], input: 200);
  print('Intcode 6 output 1 test: ${computer.stdout == 1}');

  try {
    computer.run(intcodes[6], input: 4);
  } on IntcodePositionInvalidException catch (e, s) {
    print(e.message);
    print(s.toString());
    computer.printDump();
    return;
  }
  print('Intcode 7 less than 8 test: ${computer.stdout == 999}');
  intcodes[6].reset();
  computer.run(intcodes[6], input: 8);
  print('Intcode 7 equal to 8 test: ${computer.stdout == 1000}');
  intcodes[6].reset();
  computer.run(intcodes[6], input: 90);
  print('Intcode 7 greater than 8 test: ${computer.stdout == 1001}');
}