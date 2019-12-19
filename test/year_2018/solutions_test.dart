import 'package:advent_of_dart/year_2018/solutions.dart';
import 'package:test/test.dart';

void main() {
  group('2018', () {
    test('1: 1', () => expect(day_1_part_1(), 590));
    test('1: 2', () => expect(day_1_part_2(), 83445));
    test('2: 1', () => expect(day_2_part_1(), 7221));
    test('2: 2', () => expect(day_2_part_2(), 'mkcdflathzwsvjxrevymbdpoq'));
    test('3: 1', () => expect(day_3_part_1(), 110389));
    test('3: 2', () => expect(day_3_part_2(), 552));

    test('4: 1', () => expect(day_4_part_1(), 74743));
    test('4: 2', () => expect(day_4_part_2(), 132484));
    test('differentCases', () => expect(isOfDifferentCases('a', 'A'), true));
    test('differentCases', () => expect(isOfDifferentCases('A', 'a'), true));
    test('differentCases', () => expect(isOfDifferentCases('A', 'A'), false));
    test('differentCases', () => expect(isOfDifferentCases('a', 'a'), false));

    test('5: 1', () => expect(day_5_part_1(), 10496));

    test('6: 1', () => expect(day_6_part_1(), 4284));
    test('6: 2', () => expect(day_6_part_2(), 35490));
  });
}
