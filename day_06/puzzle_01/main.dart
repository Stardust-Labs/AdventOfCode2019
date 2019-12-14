import 'dart:io';
import '../resources/orbit_map.dart';

void main() {
  File input = new File('../resources/input');
  List<String> inputCoordinates = input.readAsLinesSync();

  OrbitMap orbitMap = new OrbitMap(inputCoordinates);

  int checksum = orbitMap.checksum();

  File answer = new File('./answer');
  answer.writeAsStringSync(checksum.toString());
}