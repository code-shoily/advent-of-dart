import 'dart:io';


int _getLatestYear() {
  DateTime d = DateTime.now();
  return d.month == 12 ? d.year : d.year - 1;
}

final int latestYear = _getLatestYear();

/// Generate code stub for main code for AoC [year] [day]
generateCode(int year, int day) => '''
/// Code for the solution of $year AoC, day $day.
///
/// Problem description can be seen [here](https://adventofcode.com/$year/day/$day)
import 'package:advent_of_dart/helpers.dart';

/// Read the raw [String] content from file and convert it to
/// [List<String>].
List<String> _processInput() =>
    readFromFiles(year: $year, day: $day, part: 1).split('\\n').toList();

day_${day}_part_1() => _processInput();
day_${day}_part_2() => _processInput();
''';

/// Parse the argument and get year and day values. year should
/// be between `2015` and [latestYear] and days within 1 to 25.
List<int> parseArgument(List<String> argumentList) {
  final int year = int.parse(argumentList[0]);
  final int day = int.parse(argumentList[1]);
  if (year > latestYear || year < 2015) throw ArgumentError();
  if (day < 1 || day > 25) throw ArgumentError();
  return [year, day];
}

main(List<String> arguments) {
  try {
    var parsedData = parseArgument(arguments);
    int year = parsedData[0];
    int day = parsedData[1];

    var dataFile = File('lib/data/$year/day_${day}_1.txt');
    var codeFile = File('lib/year_$year/day_${day}.dart');

    if (!dataFile.existsSync()) dataFile.create(recursive: true);
    if (!codeFile.existsSync()) {
      codeFile.create(recursive: true);
      codeFile.writeAsStringSync(generateCode(year, day));
    }
  } on FormatException catch (_) {
    print('Please enter valid number for <year> <day>');
  } on ArgumentError catch (_) {
    print('Invalid values for year (2015-$latestYear) or day (1-25)');
  } catch (_) {
    print('Usage: `pub run bin/generate.dart year day`');
  }
}
