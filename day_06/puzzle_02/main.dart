import 'dart:io';
import '../resources/orbit_map.dart';

void main() {
  File input = new File('./testinput');
  List<String> inputCoordinates = input.readAsLinesSync();

  OrbitMap orbitMap = new OrbitMap(inputCoordinates);

  print(orbitMap.search('L').id == 'L');

  int checksum = orbitMap.checksum();

  File answer = new File('./answer');
  answer.writeAsStringSync(checksum.toString());
}