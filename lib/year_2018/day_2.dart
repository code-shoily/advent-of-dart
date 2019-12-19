/// Code for the solution of 2018 AoC, day 2.
///
/// Problem description can be seen [here](https://adventofcode.com/2018/day/2)
import 'package:advent_of_dart/helpers.dart';

/// Read the raw [String] content from file and convert it to
/// [List<String>].
List<String> _processInput() =>
    readFromFiles(year: 2018, day: 2, part: 1).split('\n').toList();

List<int> _twiceOrThrice(String s) {
  var chars = Map<int, int>();
  var twice = 0, thrice = 0;

  s.runes.forEach((c) => chars.update(c, (n) => n + 1, ifAbsent: () => 1));

  chars.forEach((_, v) {
    if (v == 2) twice = 1;
    if (v == 3) thrice = 1;
  });

  return [twice, thrice];
}

int day_2_part_1() => _processInput()
    .map(_twiceOrThrice)
    .reduce((a, b) => [a[0] + b[0], a[1] + b[1]])
    .reduce((a, b) => a * b);

/// Finds duplicate strings in a list.
Map<String, int> _findDuplicates(Iterable data) {
  var strings = Map<String, int>();

  for (var s in data) strings.update(s, (n) => n + 1, ifAbsent: () => 1);

  strings.removeWhere((s, i) => i != 2);

  return strings;
}

/// Returns string [s] with removed character at [i]
String _removeFrom(String s, int i) =>
    s.substring(0, i) + s.substring(i + 1, s.length);

day_2_part_2() {
  List<Map<String, int>> frequencies = [];

  var input = _processInput();
  for (var i = 0; i < input[0].length; i++)
    frequencies.add(_findDuplicates(input.map((e) => _removeFrom(e, i))));

  return frequencies
      .where((e) => e.isNotEmpty)
      .map((i) => i.keys)
      .expand((f) => f)
      .first;
}
