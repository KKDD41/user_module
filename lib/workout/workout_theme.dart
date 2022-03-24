import 'package:user2/providers/workout_database_provider.dart';
import 'package:user2/workout/single_workout.dart';

import '../user/custom_error.dart';

class WorkoutTheme {
  String theme;

  /// Constructor.
  WorkoutTheme({required this.theme});

  /// Query to DB that returns a list of available single workouts
  /// for current theme.
  Future<List<SingleWorkout>> returnListOfWorkouts() async {
    return await WorkoutDatabaseProvider.returnWorkouts(theme);
  }

  /// Returns a description about whole workout theme.
  String? getDescription() {
    switch (theme) {
      case 'Cardio' : {
        return '''Cardiovascular exercise, also known as cardio or aerobic exercise, is essential for good health. It gets your heart rate up, making you blood pump faster. This delivers more oxygen throughout your body, which keeps your heart and lungs healthy. Regular cardio exercise can also help you lose weight, get better sleep, and reduce your risk for chronic disease.''';
      }
      case 'Endurance' : {
        return '''Building muscular endurance will enhance your overall health and wellness, says Simeone. But other benefits include good posture from your muscles being able to hold you up in place all day, increased metabolism, improved confidence, and fewer injuries. In terms of helping you work out, Shooter says muscular endurance “exercises train the body’s anaerobic edge and conditions the body to tolerate higher workloads.” In other words, you’ll be able to improve work output at certain intensities and perform for a longer period of time before getting tired. ''';
      }
      case 'IntegratedActivity' : {
        return '''The second benefit of full body workouts is the increased muscular recovery rates. One main reason why some people do not get progress on their workout program is simply because they aren't recovering from session to session. Sixth on the list of advantages of full body workouts is the lower level of central nervous system stress on a week to week basis. Whenever you lift a weight, a stress is placed on the CNS. It doesn't matter if it's a biceps curl or a squat, your CNS will be stimulated. Finally, the last benefit to full body workouts is lower levels of boredom. The more often you repeat the same activity over and over again the greater the chances that you will find boredom settling in.''';
      }
      case 'Pilates' : {
        return '''This set of Pilates exercises is designed to provide you with an at-home Pilates routine and help you build familiarity with Pilates mat exercises, whether you are new or experienced. These exercises develop the core strength, stability, and flexibility for which Pilates is famous. The muscular focus for each exercise is noted so you can target your routine. Please keep in mind that all Pilates exercises engage the core abdominal muscles. Feel free to choose any from the list for an ab workout. There are modification notes in the full instructions for each exercise.''';
      }
      case 'Strength' : {
        return '''Increasing muscle strength can help make everyday movements less of a struggle, whether you're carrying a week’s worth of groceries up the stairs, placing a bulky object on an overhead shelf, or simply getting up off the floor. And building balanced strength—by making sure you’re focusing on all muscle groups—is important because it helps prevent weaker muscles from overcompensating, which can lead to injury. As you get older, maintaining muscle mass and strength becomes even more important for overall health. Resistance training can help older adults improve balance, build bone density, reduce the risk of falls, preserve independence, and even boost cognitive well-being, according to a 2019 position paper from the National Strength and Conditioning Association.''';
      }
      case 'Stretching' : {
        return '''Stretches can be either static, where the person holds a still position, or dynamic, meaning that the person carries out the stretch while moving. A daily stretch routine may incorporate both static and dynamic stretches. Stretching can be mildly uncomfortable at first, but it should not be painful. An individual stretch will typically last 10–30 secondsTrusted Source. It can help to repeat a stretch routine, as it becomes easier to extend the muscles once they have properly loosened up.''';
      }
      case 'Yoga' : {
        return '''Yoga offers physical and mental health benefits for people of all ages. And, if you’re going through an illness, recovering from surgery or living with a chronic condition, yoga can become an integral part of your treatment and potentially hasten healing.  A yoga therapist can work with patients and put together individualized plans that work together with their medical and surgical therapies. That way, yoga can support the healing process and help the person experience symptoms with more centeredness and less distress.''';
      }
      default : CustomErrorMessage('Undefined theme.');
    }
    return null;
  }

}