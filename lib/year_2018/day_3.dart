/// Code for the solution of 2018 AoC, day 3.
///
/// Problem description can be seen [here](https://adventofcode.com/2018/day/3)
import 'package:advent_of_dart/helpers.dart';

/// Representing a fabric that has the attributes given
/// in the problem statement with [right] and [bottom]
/// computed.
class _Claim {
  int id, left, top, width, height;
  int get right => left + width;
  int get bottom => top + height;

  _Claim({this.id, this.left, this.top, this.width, this.height});
}

/// Derive the coordinates of a fabric based on the rules
///
/// Example rule: #1255 @ 49,708: 13x25
_Claim _getFabric(String line) {
  var m = RegExp(r'#(\d+) @ (\d+),(\d+): (\d+)x(\d+)').allMatches(line).first;

  return _Claim(
      id: int.parse(m.group(1)),
      left: int.parse(m.group(2)),
      top: int.parse(m.group(3)),
      width: int.parse(m.group(4)),
      height: int.parse(m.group(5)));
}

/// Place the fabric with [position] on the grid. Placement increments the grid
void _claim(List<List<int>> grid, _Claim fabric) {
  for (var i = fabric.top; i < fabric.bottom; i++) {
    for (var j = fabric.left; j < fabric.right; j++) {
      grid[i][j]++;
    }
  }
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

/// Determines if [fabric] was ever overlapped. Must be called after [_claim]
bool _isNeverOverlapped(List<List<int>> grid, _Claim fabric) {
  for (var i = fabric.top; i < fabric.bottom; i++) {
    for (var j = fabric.left; j < fabric.right; j++) {
      if (grid[i][j] > 1) return false;
    }
  }
  return true;
}

/// Read the raw [String] content from file and convert it to [List<Fabric>].
List<_Claim> _processInput() => readFromFiles(year: 2018, day: 3, part: 1)
    .split('\n')
    .map(_getFabric)
    .toList();

day_3_part_1() {
  var grid = List.generate(1000, (i) => List.generate(1000, (_) => 0));
  _processInput().forEach((fabric) => _claim(grid, fabric));

  return _overlaps(grid);
}

day_3_part_2() {
  var fabrics = _processInput();
  var grid = List.generate(1000, (i) => List.generate(1000, (_) => 0));
  fabrics.forEach((fabric) => _claim(grid, fabric));
  return fabrics.firstWhere((fabric) => _isNeverOverlapped(grid, fabric)).id;
}
