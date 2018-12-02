/// Code for the solution of 2018 AoC, day 1.
///
/// Problem description can be seen [here](https://adventofcode.com/2018/day/1)
import "../helpers.dart";

/// Read the raw [String] content from file and convert it to
/// [List<int>].
List<int> processInput() => readFromFiles(day: 1, part: 1)
    .split("\n")
    .map((i) => int.parse(i))
    .toList();

/// 590 For me!
int day_1_part_1() => processInput().reduce((a, b) => a + b);

/// 83445 For me!
int day_1_part_2() {
  var data = processInput();
  var visited = Set<int>();
  var frequency = 0;

  for (var idx = 0; visited.add(frequency); idx = (idx + 1) % data.length)
    frequency += data[idx];

  return frequency;
}
