/// Code for the solution of 2015 AoC, day 5.
///
/// Problem description can be seen [here](https://adventofcode.com/2015/day/5)
import 'package:advent_of_dart/helpers.dart';

/// Read the raw [String] content from file and convert it to
/// [List<String>].
List<String> _processInput() => readFromFiles(year: 2015, day: 5, part: 1)
    .split('\n')
    .where((s) => s != '')
    .toList();

bool hasNaughtyPattern(String s) => s.contains(RegExp(r'ab|cd|pq|xy'));
bool hasOverThreeVowels(String s) =>
    RegExp(r'[aeiou]').allMatches(s).length >= 3;
bool hasRepeatingChar(String s) => RegExp(r'(\w)\1+').allMatches(s).length > 0;

bool isNice(String s) =>
    hasRepeatingChar(s) && hasOverThreeVowels(s) && !hasNaughtyPattern(s);

bool hasRepeatingPairs(String s) {
  var _cache = <String, int>{};
  String lastPair;

  for (var i = 0; i < s.length - 1; i++) {
    var currentPair = s[i] + s[i + 1];
    if (lastPair == null || lastPair != currentPair) {
      _cache.update(currentPair, (v) => v + 1, ifAbsent: () => 1);
      lastPair = currentPair;
    } else
      lastPair = null;
  }

  return _cache.values.any((v) => v > 1);
}

bool hasRepeatWithALetter(String s) {
  for (var i = 0; i < s.length - 2; i++) {
    if (s[i] == s[i + 2]) return true;
  }

  return false;
}

bool isNiceV2(String s) => hasRepeatingPairs(s) && hasRepeatWithALetter(s);

day_5_part_1() => _processInput().where((s) => isNice(s)).length;
day_5_part_2() => _processInput().where((s) => isNiceV2(s)).length;
