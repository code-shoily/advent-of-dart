/// Code for the solution of 2018 AoC, day 4.
///
/// Problem description can be seen [here](https://adventofcode.com/2018/day/4)
import 'package:advent_of_dart/helpers.dart';

/// All relevant activities for this puzzle
enum Activity { shiftStarts, sleeps, wakesUp }

/// A guard activity denotes an instance of the activities of guards.
///
/// It is basically the data structure representing a line in the input file.
class GuardActivity {
  int who;
  DateTime when;
  Activity what;

  GuardActivity({this.when, this.what, this.who = null});
}

/// The queue is a timeline of all activities along with summary thereof.
class Queue {
  /// List of [GuardActivity] records
  List<GuardActivity> records;

  /// Summarized data of per guard activities
  Map<int, Map<String, dynamic>> summary;

  Queue()
      : records = [],
        summary = {};

  /// Inserts a new activity (unsorted) to records.
  void enqueue(GuardActivity activity) => records.add(activity);

  /// This is the heart of the operations. It is responsible to sort and
  /// reconstruct the [records].
  ///
  /// When consuming data from the input file, not all information is present.
  /// Some information has to be contained from a previous state, which can be
  /// inferred if the records are sorted in ascending order of time. [rebuild] method
  /// does exactly that, it sorts the underlying [records], inserting stateful data
  /// along the way.
  ///
  /// Most significant operations herein are dependant on the status of the [rebuild] method.
  ///
  /// if it is false.
  void rebuild() {
    int currentGuard;
    records.sort((a, b) => a.when.compareTo(b.when));

    for (var activity in records) {
      if (currentGuard != null && !summary.containsKey(currentGuard)) {
        summary[currentGuard] = {
          'asleepSince': null,
          'sleepTimes': List<List<DateTime>>(),
          'minutesAsleep': 0
        };
      }

      switch (activity.what) {
        case Activity.sleeps:
          activity.who = currentGuard;
          summary[activity.who]['asleepSince'] = activity.when;
          break;
        case Activity.wakesUp:
          activity.who = currentGuard;
          var asleepSince = summary[activity.who]['asleepSince'] as DateTime;
          summary[activity.who]['asleepSince'] = null;
          summary[activity.who]['minutesAsleep'] +=
              (activity.when.difference(asleepSince).inMinutes);
          (summary[activity.who]['sleepTimes'] as List<List<DateTime>>)
              .add([asleepSince, activity.when]);
          break;
        case Activity.shiftStarts:
          currentGuard = activity.who;
          break;
      }
    }
  }

  /// Guard who slept the most
  int get overlySleepyGuard {
    var mostMinutesSlept = 0;
    var overlySleepyGuard = null;
    summary.forEach((k, v) {
      if (v['minutesAsleep'] > mostMinutesSlept) {
        mostMinutesSlept = v['minutesAsleep'];
        overlySleepyGuard = k;
      }
    });

    return overlySleepyGuard;
  }

  /// Returns a profile in the form of {id, minute, weight, point}.
  /// This method is crucial for computing the second part of the puzzle.
  Map<String, int> getSleeperProfile(int id) {
    var sleepiestMinute;
    var frequencies = Map<int, int>();

    sleepTimeFrequency(List<DateTime> list) {
      for (var i = list[0].minute; i < list[1].minute; i++) {
        frequencies.update(i, (i) => i + 1, ifAbsent: () => 1);
      }
    }

    (summary[id]['sleepTimes'] as List<List<DateTime>>).forEach((i) {
      sleepTimeFrequency(i);
    });

    var max = 0;
    frequencies.forEach((k, v) {
      if (v > max) {
        max = v;
        sleepiestMinute = k;
      }
    });
    return {
      'id': id,
      'minute': sleepiestMinute,
      'weight': max,
      'point': overlySleepyGuard * sleepiestMinute
    };
  }

  /// Calculates the output of part 2 of the puzzle by finding
  /// the person who slept most during a particular minute and
  /// computing the result as per the puzzle's stipulation
  get consistentSleeperPoint {
    var profiles = List<Map<String, int>>();
    summary.forEach((k, _) {
      try {
        var profile = getSleeperProfile(k);
        profiles.add(profile);
      } catch (e) {}
    });

    var consistentSleeper;
    var sleepiestMinute;
    var max = 0;

    for (var profile in profiles) {
      if (profile['weight'] > max) {
        max = profile['weight'];
        sleepiestMinute = profile['minute'];
        consistentSleeper = profile['id'];
      }
    }

    return consistentSleeper * sleepiestMinute;
  }
}

/// Parses a line from the input file and converts it into a [GuardActivity]
GuardActivity parseSentence(String sentence) {
  GuardActivity guardActivity;
  var isSleepRegExp = RegExp(r'.(\d{4}-\d{2}-\d{2} \d{2}:\d{2}). falls asleep');
  var isWakingUpRegExp = RegExp(r'.(\d{4}-\d{2}-\d{2} \d{2}:\d{2}). wakes up');
  var isIdentificationRegExp =
      RegExp(r'.(\d{4}-\d{2}-\d{2} \d{2}:\d{2}). Guard #(\d+) begins shift');

  if (isSleepRegExp.hasMatch(sentence)) {
    var m = isSleepRegExp.firstMatch(sentence);
    var time = DateTime.parse(m[1]);
    guardActivity = GuardActivity(when: time, what: Activity.sleeps);
  } else if (isWakingUpRegExp.hasMatch(sentence)) {
    var m = isWakingUpRegExp.firstMatch(sentence);
    var time = DateTime.parse(m[1]);
    guardActivity = GuardActivity(when: time, what: Activity.wakesUp);
  } else {
    var m = isIdentificationRegExp.firstMatch(sentence);
    var time = DateTime.parse(m[1]);
    var id = int.parse(m[2]);
    guardActivity =
        GuardActivity(who: id, when: time, what: Activity.shiftStarts);
  }

  return guardActivity;
}

/// Read the raw [String] content from file and convert it to [List<Fabric>].
_processInput() =>
    readFromFiles(year: 2018, day: 4, part: 1).split("\n").map(parseSentence);

day_4_part_1() {
  var q = Queue();
  _processInput().forEach((a) => q.enqueue(a));
  q.rebuild();
  return q.getSleeperProfile(q.overlySleepyGuard)["point"];
}

day_4_part_2() {
  var q = Queue();
  _processInput().forEach((a) => q.enqueue(a));
  q.rebuild();
  return q.consistentSleeperPoint;
}
