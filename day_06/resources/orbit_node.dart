class OrbitNode {
  String id;
  List<OrbitNode> children;
  OrbitNode parent;
  int orbitCount;

  OrbitNode(this.id, [this.parent=null]) {
    children = [];
    if (parent == null) {
      orbitCount = 0;
    } else {
      orbitCount = parent.orbitCount + 1;
    }
  }

  void addChild(OrbitNode child) {
    children.add(child);
  }

  int getNodeChecksum() {
    int checkSum = 0;
    children.forEach((child) {
        checkSum += child.getNodeChecksum();
        checkSum += child.orbitCount;
    });

    return checkSum;
  }

  OrbitNode search(String query) {
    if (id == query) {
      return this;
    } else if (children.length > 0) {
      List<OrbitNode> searchThis = List.from(children.where((child) => child.id == query));
      if (searchThis.length == 1) {
        return searchThis[0];
      } else {
        for (int ii = 0; ii < children.length; ii++) {
          OrbitNode lookup = children[ii].search(query);
          if (lookup != null) {
            return lookup;
          }
        }
        return null;
      }
    } else {
      return null;
    }

  }
}