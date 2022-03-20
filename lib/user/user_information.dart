import 'package:intl/intl.dart';
import 'package:user2/providers/user_database_provider.dart';
import 'package:user2/user/custom_error.dart';
import 'package:user2/user/cycle_notifier.dart';

class UserInformation {
  String userName;
  int weight;
  int hightM;
  CycleNotifier cycleNotifier;

  /// Constructing user's information for the start of using app.
  UserInformation({
    required this.userName,
    required this.weight,
    required this.hightM,
    required this.cycleNotifier,
  });

  /// Construct an information after query from DB.
  factory UserInformation.fromMap(Map<dynamic, dynamic> map) {
    final userInfo = UserInformation(
        userName: map['userName'],
        weight: map['weight'],
        hightM: map['hightM'],
        cycleNotifier: CycleNotifier(
          cycleDay: map['cycleNotifier']['cycleDay'],
          cycleLength: map['cycleNotifier']['cycleLength'],
          currentDate:
              CycleNotifier.fromString(map['cycleNotifier']['currentDate']),
        )
    );
    return userInfo;
  }

  /// Updating information separately.
  Future setName(String myName, String userID) async {
    if (myName == '' || myName.length > 25) {
      CustomErrorMessage('''Please enter your nickname! \n
                            (less than 25 characters allowed)''');
    }
    userName = myName;
    await DatabaseProvider.setInfo(userID, {'userName': myName});
  }

  Future setWeight(int myWeight, String userID) async {
    if (myWeight < 30 || myWeight > 400) {
      CustomErrorMessage('Please set your weight in kilograms!');
    }
    weight = myWeight;
    await DatabaseProvider.setInfo(userID, {'weight': myWeight});
  }

  Future setHight(int myHight, String userID) async {
    if (myHight < 130 || myHight > 400) {
      CustomErrorMessage('Please set your hight in centimeters!');
    }
    hightM = myHight;
    await DatabaseProvider.setInfo(userID, {'hightM': myHight});
  }

  Future setCycleDay(int myCycleDay, String userID) async {
    cycleNotifier.cycleDay = myCycleDay;
    await DatabaseProvider.setInfo(userID, {
      'cycleNotifier': {
        'cycleDay': cycleNotifier.cycleDay,
      }
    });
  }

  Future setCycleLength(int myCycleLength, String userID) async {
    cycleNotifier.cycleLength = myCycleLength;
    await DatabaseProvider.setInfo(userID, {
      'cycleNotifier': {
        'cycleLength': cycleNotifier.cycleLength,
      }
    });
  }

  @override
  String toString() {
    return '''weight : $weight, \n 
              userName : $userName, \n 
              hightM : $hightM, \n 
              cycleNotifier : \n 
                  - 'cycleDay' : ${cycleNotifier.cycleDay}, \n 
                  - 'cycleLength' : ${cycleNotifier.cycleLength}, \n 
                  - 'currentDate' : ${DateFormat('yyyy-MM-dd')
                                      .format(cycleNotifier.currentDate)}
              ''';
  }
}
