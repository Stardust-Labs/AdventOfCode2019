import '../resources/intcode_interpreter.dart';
import '../resources/intcode.dart';
import '../resources/intcode_errors.dart';
import 'dart:io';

void main() {
  File input = new File('../resources/input');
  String inputIntcode = input.readAsStringSync();

  IntcodeInterpreter computer = new IntcodeInterpreter();
  Intcode diagnostic = new Intcode(inputIntcode);

  try {
    computer.run(diagnostic, input: 1);
  } on IntcodeInterpretationException catch (e, s) {
    handleException(e, s, computer);
    return;
  } on IntcodePositionInvalidException catch (e, s) {
    handleException(e, s, computer);
    return;
  } on IntcodeRuntimeError catch (e, s) {
    handleException(e, s, computer);
    return;
  } on OpcodeException catch (e, s) {
    handleException(e, s, computer);
  } catch (e, s) {
    print(e.toString());
    print(s.toString());
    printDump(computer);
    return;
  }

  File output = new File('./output');
  output.writeAsStringSync(computer.stdoutHistory.join(','));

  File answer = new File('./answer');
  answer.writeAsStringSync(computer.stdout.toString());
}

void handleException(var e, var s, IntcodeInterpreter computer) {
  print(e.message);
  print(s.toString());
  printDump(computer);
}

void printDump(IntcodeInterpreter computer) {
  File crashDump = new File('./crashDump');
  IOSink crashDumpSink = crashDump.openWrite();
  crashDumpSink.write('Crash at pointer ${computer.pointer}:\n');
  List<List<int>> memoryDump = [];
  for (int ii = 0; ii < computer.memory.length; ii++) {
    memoryDump.add([ii, computer.memory[ii]]);
  }
  memoryDump.forEach((pointer) => crashDumpSink.write(
    '${pointer[0]}: ${pointer[1]}\n'
  ));
  crashDumpSink.write('${computer.memory.join(',')}');
  crashDumpSink.close();
}
