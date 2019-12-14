import 'dart:convert';
import './orbit_node.dart';

class OrbitMap {

  List<String> coordinates;
  Map<String, List<String>> nodes;
  OrbitNode centerOfMass;

  // Base node should always be COM
  OrbitMap(this.coordinates) {
    nodes = {};
    populateMap('COM');
  }

  /**
   * Alias for countNodes
   */
  int checksum() {
    return centerOfMass.getNodeChecksum();
  }

  List<String> _searchCoords(String parent) {
    return List.from(coordinates.where((el) => el.startsWith("${parent})")));
  }

  void populateMap(String body, [OrbitNode parent=null]) {
    OrbitNode currentNode = new OrbitNode(body, parent);

    if (parent != null) {
      parent.addChild(currentNode);
    } else {
      centerOfMass = currentNode;
    }

    _searchCoords(body).forEach((child) {
      String childBody = child.split(')')[1];
      populateMap(childBody, currentNode);
    });
  }

  OrbitNode search(String query) {
    return centerOfMass.search(query);
  }

  int transferDistance(OrbitNode aa, OrbitNode bb) {
    //
    return 0;
  }
}