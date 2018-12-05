/// Code for the solution of 2018 AoC, day 5.
///
/// Problem description can be seen [here](https://adventofcode.com/2018/day/5)
import "package:advent_of_dart/helpers.dart";

/// Read the raw [String].
String _processInput() => readFromFiles(year: 2018, day: 5, part: 1);

/// Checks it [a] and [b] are of different cases
bool isOfDifferentCases(String a, String b) =>
    a != b && (a == b.toLowerCase() || a == b.toUpperCase());

/// Performs a reaction which reduces the sequence
String reaction(String sequence) {
  var newSequence = List<String>();
  for (var i = 0; i < sequence.length; i++) {
    if (newSequence.isNotEmpty &&
        isOfDifferentCases(newSequence.last, sequence[i]))
      newSequence.removeLast();
    else
      newSequence.add(sequence[i]);
  }
  return newSequence.join();
}

day_5_part_1() => reaction(_processInput()).length;

day_5_part_2() {}
