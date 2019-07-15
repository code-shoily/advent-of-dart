/// Code for the solution of 2015 AoC, day 2.
///
/// Problem description can be seen [here](https://adventofcode.com/2015/day/2)
import 'package:advent_of_dart/helpers.dart';
import 'dart:math';

class Box {
  int length;
  int width;
  int height;

  Box(this.length, this.width, this.height);
  factory Box.fromDims(List<int> dims) => Box(dims[0], dims[1], dims[2]);

  int get smallestSideArea {
    var side_1 = this.length * this.width;
    var side_2 = this.width * this.height;
    var side_3 = this.length * this.height;

    return min(min(side_1, side_2), side_3);
  }

  int get smallestSidePerimeter {
    var side_1 = 2 * (this.length + this.width);
    var side_2 = 2 * (this.width + this.height);
    var side_3 = 2 * (this.length + this.height);

    return min(min(side_1, side_2), side_3);
  }

  int get volume => this.length * this.width * this.height;

  int requiredWrappingPaper() =>
      2 *
          (this.length * this.width +
              this.width * this.height +
              this.height * this.length) +
      this.smallestSideArea;

  int requiredRibbonPaper() => this.smallestSidePerimeter + this.volume;
}

List<Box> processInput() => readFromFiles(year: 2015, day: 2, part: 1)
    .trim()
    .split('\n')
    .map((e) => e.split('x').map((v) => int.parse(v)).toList())
    .map((dims) => Box.fromDims(dims))
    .toList();

int day_2_part_1() => processInput()
    .map((box) => box.requiredWrappingPaper())
    .reduce((x, y) => x + y);

int day_2_part_2() => processInput()
    .map((box) => box.requiredRibbonPaper())
    .reduce((x, y) => x + y);
