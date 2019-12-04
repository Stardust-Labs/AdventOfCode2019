import 'dart:io';
import 'dart:convert';
import 'dart:async';

Future<void> main() async {

  // Open inputs file and read to stream, then
  // read lines from the stream into a list of input values
  File inputs = new File('./inputs');
  Stream<List<int>> inputStream = inputs.openRead();

  List<int> inputValues = []; 

  Stream lines = inputStream
    .transform(utf8.decoder)
    .transform(new LineSplitter());
  
  await for (String line in lines) {
    inputValues.add(int.parse(line));
  }
  
  print('Input values read to list');

  // Convert the input values based on the fuel formula
  // Fuel = Mass / 3, rounded down, - 2
  List<int> outputValues = [];

  inputValues.forEach((int value) {
    outputValues.add( ((value / 3).floor()) - 2 );
  });

  // Write all outputs to a file
  File outputs = new File('./outputs');
  IOSink sink = outputs.openWrite();

  outputValues.forEach((int value) {
    sink.write('${value.toString()}\n');
  });

  sink.close();

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