/// Code for the solution of 2018 AoC, day 1.
///
/// Problem description can be seen [here](https://adventofcode.com/2018/day/1)
import "../helpers.dart";

List<int> twiceOrThrice(String s) {
  var chars = Map<int, int>();
  var twice = 0, thrice = 0;

  s.runes.forEach((c) => chars.update(c, (n) => n + 1, ifAbsent: () => 1));

  chars.forEach((_, v) {
    if (v == 2) twice = 1;
    if (v == 3) thrice = 1;
  });

  return [twice, thrice];
}

/// Read the raw [String] content from file and convert it to
/// [List<int>].
List<String> processInput() =>
    readFromFiles(day: 2, part: 1).split("\n").toList();

/// 7221 for me!
int day_2_part_1() => processInput()
    .map(twiceOrThrice)
    .reduce((a, b) => [a[0] + b[0], a[1] + b[1]])
    .reduce((a, b) => a * b);

/// Finds duplicate strings in a list.
Map<String, int> findDuplicates(Iterable data) {
  var strings = Map<String, int>();

  for (var s in data) strings.update(s, (n) => n + 1, ifAbsent: () => 1);

  strings.removeWhere((s, i) => i != 2);

  return strings;
}

/// Returns string [s] with removed character at [i]
String removeFrom(String s, int i) =>
    s.substring(0, i) + s.substring(i + 1, s.length);

/// mkcdflathzwsvjxrevymbdpoq for me!
day_2_part_2() {
  List<Map<String, int>> frequencies = [];

  var input = processInput();
  for (var i = 0; i < input[0].length; i++)
    frequencies.add(findDuplicates(input.map((e) => removeFrom(e, i))));

  return frequencies
      .where((e) => e.isNotEmpty)
      .map((i) => i.keys)
      .expand((f) => f)
      .first;
}
