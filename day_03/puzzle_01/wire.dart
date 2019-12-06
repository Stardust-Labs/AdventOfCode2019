class Coordinate {
  final int x;
  final int y;

  Coordinate(this.x, this.y);

  static int manhattanDistance(Coordinate a, Coordinate b) {
    int lat, lon;

    // calculate latitudinal distance
    if (a.x > b.x) {
      lat = a.x - b.x;
    } else if (b.x > a.x) {
      lat = b.x - a.x;
    } else {
      lat = 0;
    }

    // calculate longitudinal distance
    if (a.y > b.y) {
      lon = a.y - b.y;
    } else if (b.y > a.y) {
      lon = b.y - a.y;
    } else {
      lon = 0;
    }

    return lat + lon;
  }
}

class Wire {
  List<Coordinate> coordinates;
  Coordinate _latestCoordinate;

  Wire(String instructions) {
    //
  }
}