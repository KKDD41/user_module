import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user2/providers/google_sign_in_provider.dart';
import 'package:user2/providers/user_database_provider.dart';
import 'package:user2/user/custom_error.dart';
import 'package:user2/user/cycle_notifier.dart';
import 'package:user2/user/user_information.dart';

import '../workout/workout_theme.dart';

class AppUser {
  /// User information variables
  String? userID;
  late UserInformation? userInformation;

  AppUser(String? currentUser) {
    userID = currentUser;
  }

  /// Login / Logout logic. But for beauty later there
  /// will appear catching errors.
  /// Use it in 'async' functions for the field 'appUser' with 'await'.
  Future signInWithGoogle() async {
    userID = await GoogleSignInProvider().logInUser();
    if (userID == null) {
      throw const CircularProgressIndicator();
    } else {
      userInformation = await DatabaseProvider.accessProfile(userID!);
      if (userInformation == null) {
        userInformation = UserInformation.fromMap({
          'weight': 0,
          'hightM': 0,
          'userName': '',
          'cycleNotifier': {
            'cycleDay': 0,
            'cycleLength': 0,
            'currentDate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
          },
        });
        await DatabaseProvider.setInfo(userID!, {
          'weight': 0,
          'hightM': 0,
          'userName': '',
          'cycleNotifier': {
            'cycleDay': 0,
            'cycleLength': 0,
            'currentDate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
          },
        });
      } else {
        userInformation!.cycleNotifier.updateDay(userID!);
      }
    }
  }

  Future signOutWithGoogle() async {
    await GoogleSignInProvider().logOutUser();
    userID = null;
  }

  /// Filling information after first authorization separately.
  Future updateInfo(Map<String, dynamic> infoLine) async {
    await DatabaseProvider.setInfo(userID!, infoLine);
    infoLine.forEach((key, value) {
      switch (key) {
        case 'userName':
          {
            userInformation!.setName(value, userID!);
            break;
          }
        case 'weight':
          {
            userInformation!.setWeight(value, userID!);
            break;
          }
        case 'hightM':
          {
            userInformation!.setHight(value, userID!);
            break;
          }
        case 'cycleNotifier':
          {
            if (value.containsKey('cycleLength')) {
              userInformation!.setCycleLength(value['cycleLength'], userID!);
            } else if (value.containsKey('cycleDay')) {
              userInformation!.setCycleDay(value['cycleDay'], userID!);
            } else {
              CustomErrorMessage('Incorrect data to update!');
            }
            break;
          }
        default:
          {
            CustomErrorMessage('Incorrect data to update!');
          }
      }
    });
  }

  /// Method that returns appropriate themes based on current cycle day
  List<WorkoutTheme> returnAppropriateThemes() {
    final cyclePhase = userInformation!.cycleNotifier.returnCyclePhase();
    switch (cyclePhase) {
      case CyclePhase.MENSTRUATION: {
        return List<WorkoutTheme>.from(['Yoga', 'Integrated', 'Stretching']);
      }
      case CyclePhase.FOLLICULAR_PHASE: {
        return List<WorkoutTheme>.from(['Strength', 'Speed-Strength', 'Endurance']);
      }
      case CyclePhase.FERTILE_WINDOW: {
        return List<WorkoutTheme>.from(['Cardio', 'Stretching', 'Pilates']);
      }
      case CyclePhase.LUTERAL_PHASE: {
        return List<WorkoutTheme>.from(['Cardio', 'Yoga', 'Integrated']);
      }
    }
    }

    /// Returns a description of the current cycle phase.
    // TODO: finish it
    String returnDescription() {
      final cyclePhase = userInformation!.cycleNotifier.returnCyclePhase();
      switch (cyclePhase) {
        case CyclePhase.MENSTRUATION: {
          return '';
        }
        case CyclePhase.FOLLICULAR_PHASE: {
          return '';
        }
        case CyclePhase.FERTILE_WINDOW: {
          return '';
        }
        case CyclePhase.LUTERAL_PHASE: {
          return '';
        }
      }
    }

}
