/// Code for the solution of 2019 AoC, day 1.
///
/// Problem description can be seen [here](https://adventofcode.com/2019/day/1)
import 'package:advent_of_dart/helpers.dart';

/// Read the raw [String] content from file and convert it to
/// [List<int>].
List<int> _processInput() => readFromFiles(year: 2019, day: 1, part: 1)
    .split('\n')
    .toList()
    .map((i) => int.parse(i))
    .toList();

int fuelRequired(int mass) => (mass / 3).floor() - 2;

day_1_part_1() => _processInput().map(fuelRequired).reduce((a, b) => a + b);

int continuedFuelInput(int mass) {
  int output = 0;
  while (mass > 0) {
    mass = fuelRequired(mass);
    output += mass >= 0 ? mass : 0;
  }
  return output;
}

day_1_part_2() =>
    _processInput().map(continuedFuelInput).reduce((a, b) => a + b);
