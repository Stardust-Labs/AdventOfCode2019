import 'dart:io';
import 'dart:convert';
import 'dart:async';

/**
 * Reads a file containing newline-separated inputs
 * and adds them to a given list of integers.
 */
Future<void> readInputs(List<int> inputList) async {
  File inputs = new File('./inputs');
  Stream<List<int>> inputStream = inputs.openRead();

  Stream lines = inputStream
    .transform(utf8.decoder)
    .transform(new LineSplitter());
  
  await for (String line in lines) {
    inputList.add(int.parse(line));
  }
}

/**
 * Writes outputs as newline-separated values synchronously
 */
void writeOutputs(List<int> outputList) {
  File outputs = new File('./outputs');
  IOSink sink = outputs.openWrite();

  outputList.forEach((int value) {
    sink.write('${value.toString()}\n');
  });

  sink.close();
}

/**
 * Calculate the amount of fuel needed for the given [mass],
 * using the formula
 * Fuel = Mass / 3, rounded down, - 2
 */
int calculateFuelRequirement(int mass) => ((mass / 3).floor()) - 2;

/**
 * Generate answer
 */
Future<void> main() async {

  // Open inputs file and read to stream, then
  // read lines from the stream into a list of input values
  List<int> inputValues = []; 
  await readInputs(inputValues);
  
  print('Input values read to list');

  
  List<int> outputValues = [];

  inputValues.forEach((int value) {
    int requiredFuel = calculateFuelRequirement(value);
    int extraFuelRequired = requiredFuel;
    while (calculateFuelRequirement(extraFuelRequired) > 0) {
      extraFuelRequired = calculateFuelRequirement(extraFuelRequired);
      requiredFuel += extraFuelRequired;
    }
    outputValues.add(requiredFuel);
  });

  // Write all outputs to a file
  writeOutputs(outputValues);
  print('Output values written to file');

  // Sum output values and write to `answer`
  int answer = 0;

  outputValues.forEach((int value) => answer += value);

  new File('./answer')
    .writeAsString(answer.toString())
    .then((File file) {
      print('The answer is ${answer}.  Answer written to file.');
    });
}