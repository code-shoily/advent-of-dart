/// Code for the solution of 2018 AoC, day 6.
///
/// Problem description can be seen [here](https://adventofcode.com/2018/day/6)
import 'package:advent_of_dart/helpers.dart';

class Point {
  int x, y;

  Point({this.x, this.y});
  Point.fromList(List<int> input) {
    x = input[0];
    y = input[1];
  }

  int operator -(Point other) =>
      (this.x - other.x).abs() + (this.y - other.y).abs();
}

/// Read the raw [String].
List<Point> _processInput() => readFromFiles(year: 2018, day: 6, part: 1)
    .split('\n')
    .map((line) => line.split(',').map((coord) => int.parse(coord)).toList())
    .map((coord) => Point.fromList(coord))
    .toList();

/// Finds minimum and maximum x and y
Map<String, int> _findExtremes(List<Point> points) {
  var minX = points.first.x,
      maxX = points.first.x,
      minY = points.first.y,
      maxY = points.first.y;
  for (var point in points) {
    if (point.x < minX) minX = point.x;
    if (point.x > maxX) maxX = point.x;
    if (point.y < minY) minY = point.y;
    if (point.y > maxY) maxY = point.y;
  }

  return {'minX': minX, 'maxX': maxX, 'minY': minY, 'maxY': maxY};
}

Map<String, dynamic> compute(List<Point> points, [threshold = 32]) {
  var result = Map<Point, int>();
  var edges = Set<Point>();
  var distances = Map<Point, int>();
  var extremes = _findExtremes(points);

  for (var x = extremes['minX']; x <= extremes['maxX']; x++) {
    for (var y = extremes['minX']; y <= extremes['maxY']; y++) {
      var current = Point(x: x, y: y);
      var minDistance;
      var cache = List<List<Point>>.generate(
          extremes['maxX'] + extremes['maxY'], (i) => []);

      for (var point in points) {
        var distance = point - current;
        distances.update(current, (i) => i + distance,
            ifAbsent: () => distance);
        cache[distance].add(point);
        if (minDistance == null || distance < minDistance) {
          minDistance = distance;
        }
      }
      if (cache[minDistance].length == 1) {
        result.update(cache[minDistance].first, (i) => i + 1,
            ifAbsent: () => 1);
      }

      if (x == extremes['minX'] ||
          x == extremes['maxX'] ||
          y == extremes['minY'] ||
          y == extremes['maxY']) {
        if (cache[minDistance].length == 1)
          for (var i in cache[minDistance]) {
            edges.add(i);
          }
      }
    }
  }

  var maxArea = 0, proximalArea = 0;

  result.forEach((k, v) {
    if (!edges.contains(k) && v > maxArea) maxArea = v;
  });

  distances.forEach((k, v) {
    if (v < threshold) proximalArea++;
  });

  return {'max': maxArea, 'proximalArea': proximalArea};
}

day_6_part_1() => compute(_processInput())['max'];

day_6_part_2() => compute(_processInput(), 10000)['proximalArea'];
