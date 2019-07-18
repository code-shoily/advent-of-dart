/// Code for the solution of 2015 AoC, day 3.
///
/// Problem description can be seen [here](https://adventofcode.com/2015/day/3)
import 'package:advent_of_dart/helpers.dart';

/// Read the raw [String] content from file and convert it to
/// [List<String>].
List<String> _processInput() => readFromFiles(year: 2015, day: 3, part: 1)
    .split('')
    .where((v) => v == '^' || v == 'v' || v == '<' || v == '>')
    .toList();

/// Splits a list of string into two each having alternating elements
List<List<String>> splitUp(List<String> inputList) {
  var first = <String>[];
  var second = <String>[];
  for (var i = 0; i < inputList.length - 1; i += 2) {
    first.add(inputList[i]);
    second.add(inputList[i + 1]);
  }

  return [first, second];
}

class Location {
  int x, y;
  Location(this.x, this.y);
  Location.origin()
      : x = 0,
        y = 0;

  @override
  String toString() => '${x},${y}';

  north() => this.y++;
  south() => this.y--;
  east() => this.x++;
  west() => this.x--;
}

class LocationManager {
  Set<String> visited;
  Location currentLocation;

  LocationManager()
      : visited = {},
        currentLocation = Location.origin() {
    visited.add(currentLocation.toString());
  }

  int get numberOfLocations => visited.length;

  void move(String direction) {
    switch (direction) {
      case '^':
        currentLocation.north();
        break;
      case 'v':
        currentLocation.south();
        break;
      case '<':
        currentLocation.west();
        break;
      case '>':
        currentLocation.east();
        break;
      default:
        throw Error();
    }

    visited.add(currentLocation.toString());
  }

  void batchMoves(List<String> directions) {
    directions.forEach((direction) => move(direction));
  }
}

day_3_part_1() {
  var locationManager = LocationManager();
  locationManager.batchMoves(_processInput());
  return locationManager.visited.length;
}

day_3_part_2() {
  var directions = splitUp(_processInput());

  var santa = directions[0];
  var santasLocationManager = LocationManager();
  santasLocationManager.batchMoves(santa);

  var robot = directions[1];
  var robotsLocationManager = LocationManager();
  robotsLocationManager.batchMoves(robot);

  return santasLocationManager.visited
      .union(robotsLocationManager.visited)
      .length;
}
