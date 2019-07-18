/// Code for the solution of 2015 AoC, day 6.
///
/// Problem description can be seen [here](https://adventofcode.com/2015/day/6)
import 'package:advent_of_dart/helpers.dart';

/// Read the raw [String] content from file and convert it to
/// [List<String>].
List<String> _processInput() => readFromFiles(year: 2015, day: 6, part: 1)
    .split('\n')
    .where((line) => line != '')
    .toList();

class Instruction {
  String instruction;
  List<int> start;
  List<int> end;
  Instruction.fromString(String line) {
    var regex = r'(turn on|turn off|toggle) (\d+,\d+) through (\d+,\d+)';
    RegExp(regex).allMatches(line).forEach((match) {
      instruction = match.group(1);
      start = match.group(2).split(',').map(int.parse).toList();
      end = match.group(3).split(',').map(int.parse).toList();
    });
  }
}

class Grid {
  List<List<int>> matrix;
  List<List<int>> brightness;

  Grid() {
    matrix = List.generate(1000, (_) => List.generate(1000, (_) => 0));
    brightness = List.generate(1000, (_) => List.generate(1000, (_) => 0));
  }

  change(Instruction instruction) {
    for (var i = instruction.start[0]; i <= instruction.end[0]; i++) {
      for (var j = instruction.start[1]; j <= instruction.end[1]; j++) {
        switch (instruction.instruction) {
          case 'turn on':
            matrix[i][j] = 1;
            brightness[i][j]++;
            break;
          case 'turn off':
            matrix[i][j] = 0;
            brightness[i][j] = (brightness[i][j] - 1) >= 0
                ? brightness[i][j] - 1
                : brightness[i][j];
            break;
          default:
            brightness[i][j] += 2;
            matrix[i][j] = matrix[i][j] == 0 ? 1 : 0;
        }
      }
    }
  }

  processFromString(List<String> instructions) =>
      instructions.forEach((line) => change(Instruction.fromString(line)));

  int get litLights {
    var result = 0;
    for (var row in matrix) for (var col in row) if (col == 1) result++;
    return result;
  }

  int get totalBrightness {
    var result = 0;
    for (var row in brightness) for (var col in row) result += col;
    return result;
  }
}

int day_6_part_1() => (Grid()..processFromString(_processInput())).litLights;

int day_6_part_2() =>
    (Grid()..processFromString(_processInput())).totalBrightness;
