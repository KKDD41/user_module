import 'package:intl/intl.dart';
import 'package:user2/providers/user_database_provider.dart';

class CycleNotifier {
  late int cycleLength;
  late int cycleDay;


  /// Stores data like 'YEAR-NUM_MONTH-DAY'.
  DateTime currentDate = DateTime.now();

  CycleNotifier(
      {required this.cycleLength,
      required this.cycleDay,
      DateTime? currentDate}
  );

  /// Updates current 'cycleDay' and 'currentDate' for 'userID'.
  Future updateDay(String userID) async {
    String lastDateStr = await DatabaseProvider.accessSingleValue(
        userID, 'cycleNotifier', 'currentDate');
    DateTime lastDate = fromString(lastDateStr);

    if (lastDate == currentDate) {
      return;
    } else {
      int differenceInDays = currentDate.difference(lastDate).inDays;
      int currentCycleDay =
          (differenceInDays - (cycleLength - cycleDay)) % cycleLength;
      await DatabaseProvider.setInfo(userID, {
        'cycleNotifier': {
          'currentDate': DateFormat('yyyy-MM-dd').format(currentDate),
          'cycleDay': currentCycleDay,
          'cycleLength' : cycleLength,
        }
      });
      cycleDay = currentCycleDay;
    }
  }

  static DateTime fromString(String currentDateStr) {
    return DateTime.parse(currentDateStr);
  }

  /// Can count current cycle phase.
  /// Can be modified for each user.
  CyclePhase returnCyclePhase() {
    if (cycleDay <= 6) {
      return CyclePhase.MENSTRUATION;
    } else if (cycleDay > 6 && cycleDay <= 12) {
      return CyclePhase.FOLLICULAR_PHASE;
    } else if (cycleDay > 12 && cycleDay < 17) {
      return CyclePhase.FERTILE_WINDOW;
    } else {
      return CyclePhase.LUTERAL_PHASE;
    }
  }
}

enum CyclePhase {
  MENSTRUATION,
  FOLLICULAR_PHASE,
  FERTILE_WINDOW,
  LUTERAL_PHASE
}