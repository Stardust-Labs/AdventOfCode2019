class Coordinate {
  final int x;
  final int y;

  Coordinate(this.x, this.y);

  @override
  bool operator ==(o) => o is Coordinate && o.x == x && o.y == y;

  @override
  int get hashCode => 'x-val${x}'.hashCode ^ 'y-val${y}'.hashCode;

  @override
  String toString() => '(${x}, ${y})';

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
  Set<Coordinate> coordinates;
  List<Coordinate> wirePath;
  Coordinate _latestCoordinate;

  final Set<String> validDirections = {
    'U', 'D', 'R', 'L'
  };

  Wire(String instructions) {
    List<String> instructionList = instructions.split(',');
    _latestCoordinate = new Coordinate(0,0);
    coordinates = {};
    wirePath = [];

    instructionList.forEach((instruction) => runInstruction(instruction));
  }

  void runInstruction(String instruction) {
    String direction = instruction.substring(0, 1);
    int magnitude = int.parse(instruction.substring(1, instruction.length));

    if (!validDirections.contains(direction)) {
      throw Exception('Invalid direction in ${instruction}');
    }
    if (!(magnitude > 0)) {
      throw Exception('Invalid magnitude in ${instruction}');
    }

    switch(direction) {
      case 'U':
        for (int newY = 1; newY <= magnitude; newY++) {
          Coordinate newCoord = new Coordinate(_latestCoordinate.x, _latestCoordinate.y + newY);
          coordinates.add(newCoord);
          wirePath.add(newCoord);
        }
        _latestCoordinate = new Coordinate(_latestCoordinate.x, _latestCoordinate.y + magnitude);
        break;
      case 'D':
        for (int newY = 1; newY <= magnitude; newY++) {
          Coordinate newCoord = new Coordinate(_latestCoordinate.x, _latestCoordinate.y - newY);
          coordinates.add(newCoord);
          wirePath.add(newCoord);
        }
        _latestCoordinate = new Coordinate(_latestCoordinate.x, _latestCoordinate.y - magnitude);
        break;
      case 'R':
        for (int newX = 1; newX <= magnitude; newX++) {
          Coordinate newCoord = new Coordinate(_latestCoordinate.x + newX, _latestCoordinate.y);
          coordinates.add(newCoord);
          wirePath.add(newCoord);
        }
        _latestCoordinate = new Coordinate(_latestCoordinate.x + magnitude, _latestCoordinate.y);
        break;
      case 'L':
        for (int newX = 1; newX <= magnitude; newX++) {
          Coordinate newCoord = new Coordinate(_latestCoordinate.x - newX, _latestCoordinate.y);
          coordinates.add(newCoord);
          wirePath.add(newCoord);
        }
        _latestCoordinate = new Coordinate(_latestCoordinate.x - magnitude, _latestCoordinate.y);
        break;
    }
  }
}

class WireBox {
  Set<Wire> wires;
  Set<Coordinate> coordinates;
  Set<Coordinate> intersections;

  WireBox () {
    wires = new Set<Wire>();
    coordinates = new Set<Coordinate>();
    intersections = new Set<Coordinate>();
  }

  Wire addWire (String instructions) {
    Wire newWire = new Wire(instructions);
    wires.add(newWire);

    newWire.coordinates.forEach((coordinate) {
      if (coordinates.contains(coordinate) && !intersections.contains(coordinate)) {
        intersections.add(coordinate);
      };
      if (!coordinates.contains(coordinate)) {
        coordinates.add(coordinate);
      }
    });

    return newWire;
  }
}