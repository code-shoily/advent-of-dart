import 'dart:convert';

/// Code for the solution of 2015 AoC, day 4.
///
/// Problem description can be seen [here](https://adventofcode.com/2015/day/4)
import 'package:crypto/crypto.dart';

const inputKey = 'bgvyzdsv';

String generateMD5(String input) =>
    md5.convert(Utf8Encoder().convert(input)).toString();

int _run(String input, String prefix, [number = 0]) {
  while (!generateMD5('${input}${number++}').startsWith(prefix));
  return number - 1;
}

day_4_part_1() => _run(inputKey, ''.padLeft(5, '0'));
day_4_part_2() => _run(inputKey, ''.padLeft(6, '0'));
