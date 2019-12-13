import 'dart:io';
import '../resources/orbit_map.dart';

void main() {
  File input = new File('../resources/testinput');
  List<String> inputCoordinates = input.readAsLinesSync();

  OrbitMap orbitMap = new OrbitMap(inputCoordinates);

  int checksum = orbitMap.checksum();

  File output = new File('./output');
  output.writeAsStringSync(orbitMap.toJson());

  File answer = new File('./answer');
  answer.writeAsStringSync(checksum.toString());
}