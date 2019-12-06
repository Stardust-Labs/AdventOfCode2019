import './wire.dart';
//import 'dart:io';

void main() {
  WireBox wireBox = new WireBox();

  List<String> instructions = [
    'R8,U5,L5,D3',
    'U7,R6,D4,L4'
  ];

  instructions.forEach((instruction) => wireBox.addWire(instruction));

  wireBox.intersections.forEach((intersection) => print('Intersection at coordinate ${intersection.x}, ${intersection.y}'));
}