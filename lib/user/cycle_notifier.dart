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
      DateTime? currentDate});

  /// Updates current 'cycleDay' and 'currentDate' for 'userID'.
  Future updateDay(String userID) async {
    String lastDateStr = await DatabaseProvider.accessSingleValue(
        userID, 'cycleNotifier', 'currentDate');
    DateTime lastDate = DateTime(lastDateStr.substring(6, 10) as int,
        lastDateStr.substring(3, 5) as int, lastDateStr.substring(0, 2) as int);

    if (lastDate == currentDate) {
      return;
    } else {
      int differenceInDays = currentDate.difference(lastDate).inDays;
      int currentCycleDay =
          (differenceInDays - (cycleLength - cycleDay)) % cycleLength;
      await DatabaseProvider.setInfo(userID, {
        'cycleNotifier': {
          'currentDate': DateFormat('yMd').format(currentDate),
          'cycleDay': currentCycleDay.toString()
        }
      });
    }
  }
}
