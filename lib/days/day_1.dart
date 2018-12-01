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
  var visited = Set<int>(), frequency = 0, idx = 0;

  while (true) {
    frequency += data[idx];
    if (visited.contains(frequency)) return frequency;
    visited.add(frequency);
    idx = (idx + 1) % data.length;
  }
}
