import 'package:advent_of_dart/year_2015/solutions.dart';
import 'package:test/test.dart';

void main() {
  group("2015", () {
    test('1: 1', () => expect(day_1_part_1(), 232));
    test('1: 2', () => expect(day_1_part_2(), 1783));
  });
}
