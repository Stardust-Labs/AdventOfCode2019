import 'dart:io';
import './intcode_interpreter.dart';

int desiredOutput = 19690720;

void setInputs(int noun, int verb, IntcodeInterpreter interpreter) {
  interpreter.intcode[1] = noun;
  interpreter.intcode[2] = verb;
}

void main() {
  File input = new File('./input');
  String inputIntcode = input.readAsStringSync();

  IntcodeInterpreter interpreter = new IntcodeInterpreter(inputIntcode);

  File outputs = new File('./outputs');
  IOSink outputsSink = outputs.openWrite();

  bool solutionFound = false;

  tests: for (int i = 0; i <= 99; i++) {
    for (int j = 0; j <= 99; j++) {

      int testNum = (i * 100) + j + 1;
      setInputs(i, j, interpreter);

      try {
        interpreter.run();
      } on OpcodeException catch (e) {
        outputsSink.write(
          'Test ${testNum} failed: Noun ${i}, Verb ${j} ' +
          'result in OpcodeException ${e}.\n'
        );
        continue;
      } on IntcodeInterpretationException catch(e) {
        outputsSink.write(
          'Test ${testNum} failed: Noun ${i}, Verb ${j} ' +
          'result in IntcodeInterpretationException ${e}.\n'
        );
        continue;
      } on IntcodePositionInvalidException catch(e) {
        outputsSink.write(
          'Test ${testNum} failed: Noun ${i}, Verb ${j} ' +
          'result in IntcodePosistionInvalidException ${e}.\n'
        );
        continue;
      }

      outputsSink.write(
        'Test ${testNum}: Noun ${i}, Verb ${j}. ' +
        'Output: ${interpreter.intcode[0]}\n'
      );

      if (interpreter.intcode[0] == desiredOutput) {
        solutionFound = true;
        break tests;
      } else {
        interpreter.reset();
      }
    }
  }

  outputsSink.close();

  if (!solutionFound) {
    throw Exception('No solution found.');
  }

  File answer01 = new File('./answer_01');
  File answer02 = new File('./answer_02');

  answer01.writeAsStringSync(
    'Noun: ${interpreter.intcode[1]}\n' +
    'Verb: ${interpreter.intcode[2]}'
  );

  int answer = (100 * interpreter.intcode[1]) + interpreter.intcode[2];
  answer02.writeAsStringSync(answer.toString());

}