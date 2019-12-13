import 'dart:convert';

class OrbitMap {

  List<String> coordinates;
  Map nodes;

  // Base node should always be COM
  OrbitMap(this.coordinates) {
    nodes = {};
    populateMap('COM', []);
  }

  /**
   * Introspects the node tree and reports the total
   * number of orbits contained therein.
   */
  int countNodes() {
    return 0;
  }

  /**
   * Alias for countNodes
   */
  int checksum() {
    return countNodes();
  }

  List<String> _searchCoords(String parent) {
    return List.from(coordinates.where((el) => el.startsWith(parent)));
  }

  void populateMap(String body, List<String> mapPath) {
    Map cwd = Map.from(nodes);
    for (int ii = 0; ii < mapPath.length; ii++) {
      cwd = cwd[mapPath[ii]];
    }

    print("CWD: ${json.encode(cwd)}");

    cwd[body] = {'children': []};
    _searchCoords(body).forEach((child) {
      print("FOUNDCHILD: ${child}");
      String childBody = child.split(')')[1];
      cwd[body]['children'].add(childBody);
      List<String> nextPath = List.from(mapPath);
      nextPath.add(childBody);
      print("NEXTPATH: ${json.encode(nextPath)}");
      populateMap(childBody, nextPath);
    });
  }

  String toJson() {
    return json.encode(nodes);
  }
}