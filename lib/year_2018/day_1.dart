/// Code for the solution of 2018 AoC, day 1.
///
/// Problem description can be seen [here](https://adventofcode.com/2018/day/1)
import 'package:advent_of_dart/helpers.dart';

/// Read the raw [String] content from file and convert it to
/// [List<int>].
List<int> _processInput() => readFromFiles(year: 2018, day: 1, part: 1)
    .split('\n')
    .map((i) => int.parse(i))
    .toList();

int day_1_part_1() => _processInput().reduce((a, b) => a + b);

int day_1_part_2() {
  var data = _processInput();
  var visited = Set<int>();
  var frequency = 0;

  for (var idx = 0; visited.add(frequency); idx = (idx + 1) % data.length)
    frequency += data[idx];

  return frequency;
}
