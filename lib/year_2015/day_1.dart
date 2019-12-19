/// Code for the solution of 2015 AoC, day 1.
///
/// Problem description can be seen [here](https://adventofcode.com/2015/day/1)
import 'package:advent_of_dart/helpers.dart';

/// Read the raw [String] content from file and split out the list of commands
List<String> _processInput() =>
    readFromFiles(year: 2015, day: 1, part: 1).trim().split('').toList();

int totalSteps(List<String> data) =>
    data.fold(0, (floor, cmd) => cmd == '(' ? floor + 1 : floor - 1);

int stepsToReach(List<String> data, destination) {
  int i = 0;
  int currentFloor = 0;

  for (; i < data.length; i++) {
    if (currentFloor == destination) break;
    currentFloor = data[i] == '(' ? currentFloor + 1 : currentFloor - 1;
  }

  return i;
}

day_1_part_1() => totalSteps(_processInput());
day_1_part_2() => stepsToReach(_processInput(), -1);
