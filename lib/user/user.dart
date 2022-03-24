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
          'levelOfFitness': '',
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
          'levelOfFitness': '',
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
        case 'levelOfFitness':
          {
            userInformation!.setLevelOfFitness(value, userID!);
            break;
          }
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
        return List<WorkoutTheme>.from(['Strength', 'Endurance']);
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
    String returnDescription() {
      final cyclePhase = userInformation!.cycleNotifier.returnCyclePhase();
      switch (cyclePhase) {
        case CyclePhase.MENSTRUATION: {
          return '''Stage 1 is the menstrual phase, it starts on day 1 of the cycle and can last anywhere up to around 8 days. This is when the lining of the uterus is shed through the vagina. Around the time of your period, day 1 of the menstrual cycle, lower intensity exercise is supported as oestrogen levels are at their lowest. Doing forms of light cardio such as jogging, cycling and swimming could be favourable around this time as well as activities like yoga. ''';
        }
        case CyclePhase.FOLLICULAR_PHASE: {
          return '''Stage 2 also starts on day 1 of the cycle and occurs in the background until about day 14. A hormone is released which signals one of the eggs in the ovary to grow into a sac-like follicle. Once the follicle has grown big enough, it signals to the uterus to start growing its lining again. After day 1 of the menstrual cycle, the follicular phase brings rise to the hormone levels again in anticipation for ovulation. Throughout this time, strength training has been shown to result in its greater increase in muscle strength. This makes it a great time of the month to be hitting the gym with some strength and high-intensity training sessions. Throughout this stage, there are also lower rates of tendon collagen synthesis which means the risk of musculoskeletal tissue injuries becomes higher. In fact, women have been found to be 3-6 times more likely than men to suffer musculoskeletal injuries when their oestrogen levels are elevated. The increasing levels of oestrogen also increase joint elasticity throughout this time and risks of ACL injuries have been noted as higher. With this in mind, longer warm-ups and less stretching may be favoured.''';
        }
        case CyclePhase.FERTILE_WINDOW: {
          return '''On day 14, the egg is released from the ovary and swept into the fallopian tubes which connect the ovary to the uterus. Around the time of ovulation, oestrogen levels are peaking which may favour the delayed onset of muscle soreness (DOMS) meaning women recover quicker and can return to exercise with less muscle damage. At day 14, Oestrogen peaks and rise of a hormone called luteinizing hormone causes the release of the egg. At this time, energy levels are at the highest and it’s a great time to push yourself to gain some additional endurance. This could make for a great time to shoot for some personal records. Additionally, as levels of the progesterone hormone are low your pain tolerance may come up a level.''';
        }
        case CyclePhase.LUTERAL_PHASE: {
          return '''The egg stays in the fallopian tubes for 24 hours, it will either be impregnated by a sperm cell or disintegrate. The Luteal phase goes from day 15-18 to day 28-35 by which time the lining will shed again. In the final weeks of the menstrual cycle as progesterone levels increase the core body temperature will also rise. This can make working out in the heat feel slightly harder and a reduction in the sweat response is often observed. Throughout the luteal phase you may find it harder to reach goals you were hitting earlier in the month, for some there is an increase in breathing rate and depth as well as heart rates. Some individuals may also find their weight increases slightly as the body holds onto water and energy is stored. That run around the block might just end up feeling a whole lot harder than it normally would.''';
        }
      }
    }

}
