class OrbitMap {

  List<String> coordinates;
  Map nodes;

  // TODO: create structure for node map to follow
  // Base node should always be COM
  OrbitMap(this.coordinates) {
    //
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
}