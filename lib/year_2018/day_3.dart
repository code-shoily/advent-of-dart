/// Code for the solution of 2018 AoC, day 2.
///
/// Problem description can be seen [here](https://adventofcode.com/2018/day/2)
import "package:advent_of_dart/helpers.dart";

/// Read the raw [String] content from file and convert it to
/// [List<Fabric>].
List<Fabric> _processInput() => readFromFiles(year: 2018, day: 3, part: 1)
    .split("\n")
    .map(_getFabric)
    .toList();

class Fabric {
  String id;
  int left;
  int top;
  int width;
  int height;

  int get right => left + width;
  int get bottom => top + height;

  Fabric({this.id, this.left, this.top, this.width, this.height});

  @override
  String toString() {
    return "#${id} @ ${left},${top} ${width}x${height}";
  }
}

/// Derive the coordinates of a fabric based on the rules
///
/// Example rule: #1255 @ 49,708: 13x25
Fabric _getFabric(String line) {
  var m = RegExp(r"#(\d+) @ (\d+),(\d+): (\d+)x(\d+)").allMatches(line).first;

  return Fabric(
      id: m.group(1),
      left: int.parse(m.group(2)),
      top: int.parse(m.group(3)),
      width: int.parse(m.group(4)),
      height: int.parse(m.group(5)));
}

/// Place the fabric with [position] on the grid. Placement increments the grid
void _apply(List<List<int>> grid, Fabric fabric) {
  for (var i = fabric.top; i < fabric.bottom; i++)
    for (var j = fabric.left; j < fabric.right; j++) grid[i][j]++;
}

/// Find overlaps
int _overlaps(List<List<int>> grid) {
  var overlaps = 0;
  for (var row in grid) {
    for (var column in row) {
      if (column > 1) overlaps++;
    }
  }

  return overlaps;
}

/// Draw an sizexsize grid with unvisited nodes marked with `0`
List<List<int>> _drawGrid(int size) =>
    List<List<int>>.generate(size, (i) => List<int>.generate(size, (_) => 0));

day_3_part_1() {
  var fabrics = _processInput();
  var grid = _drawGrid(1000);

  for (var fabric in fabrics) {
    _apply(grid, fabric);
  }

  return _overlaps(grid);
}
