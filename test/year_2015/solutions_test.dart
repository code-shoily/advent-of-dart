import 'package:advent_of_dart/year_2015/solutions.dart';
import 'package:test/test.dart';

void main() {
  group('2015', () {
    test('1: 1', () => expect(day_1_part_1(), 232));
    test('1: 2', () => expect(day_1_part_2(), 1783));
    test('2: 1', () => expect(day_2_part_1(), 1606483));
    test('2: 2', () => expect(day_2_part_2(), 3842356));
    test('3: 1', () => expect(day_3_part_1(), 2081));
    test(
        '3: splitUp',
        () => expect(splitUp(['a', '1', 'b', '2', 'c', '3']), [
              ['a', 'b', 'c'],
              ['1', '2', '3']
            ]));
    test('3: 2', () => expect(day_3_part_2(), 2341));
    test('4: 1', () => expect(day_4_part_1(), 254575));
    test('4: 2', () => expect(day_4_part_2(), 1038736));
    test('5: 1', () => expect(day_5_part_1(), 255));
    test('5: 1', () => expect(day_5_part_2(), 55));
  });
}
