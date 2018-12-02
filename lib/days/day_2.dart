/// Code for the solution of 2018 AoC, day 1.
///
/// Problem description can be seen [here](https://adventofcode.com/2018/day/1)
import "../helpers.dart";

List<int> twiceOrThrice(String message) {
  var chars = Map<int, int>();
  var twice = 0;
  var thrice = 0;

  message.runes.forEach((int char) {
    if (chars.containsKey(char)) {
      chars[char]++;
    } else {
      chars[char] = 1;
    }
  });

  chars.forEach((k, v) {
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
