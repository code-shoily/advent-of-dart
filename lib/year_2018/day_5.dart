/// Code for the solution of 2018 AoC, day 5.
///
/// Problem description can be seen [here](https://adventofcode.com/2018/day/5)
import 'package:advent_of_dart/helpers.dart';

/// Read the raw [String].
String _processInput() => readFromFiles(year: 2018, day: 5, part: 1);

/// Checks it [a] and [b] are of different cases
bool isOfDifferentCases(String a, String b) =>
    a != b && (a == b.toLowerCase() || a == b.toUpperCase());

/// Performs a reaction which reduces the sequence
String reaction(String sequence) {
  var newSequence = List<String>();
  sequence.runes.forEach((rune) {
    var char = String.fromCharCode(rune);
    if (newSequence.isNotEmpty && isOfDifferentCases(newSequence.last, char))
      newSequence.removeLast();
    else
      newSequence.add(char);
  });

  return newSequence.join();
}

day_5_part_1() => reaction(_processInput()).length;

day_5_part_2() {
  var sequence = _processInput();
  var minLength = sequence.length + 1;
  var letters = <String>[];
  for (var i = 65; i <= 90; i++) letters.add(String.fromCharCode(i));

  letters.forEach((letter) {
    var newSequence = reaction(
        sequence.replaceAll(letter, '').replaceAll(letter.toLowerCase(), ''));
    minLength = newSequence.length < minLength ? newSequence.length : minLength;
  });

  return minLength;
}
