import 'package:flutter/foundation.dart';

class UserProgress extends ChangeNotifier {
  int totalXP = 0;
  int level = 1;
  int streak = 0;
  DateTime lastLoginDate = DateTime.now();
  List<String> achievements = [];

  void addXP(int amount) {
    totalXP += amount;
    calculateLevel();
    notifyListeners();
  }

  void calculateLevel() {
    if (totalXP < 100) {
      level = 1;
    } else if (totalXP < 300) {
      level = 2;
    } else if (totalXP < 700) {
      level = 3;
    } else {
      level = 4;
    }
  }

  void updateStreak() {
    DateTime today = DateTime.now();
    Duration difference = today.difference(lastLoginDate);

    if (difference.inDays == 0) {
      return;
    } else if (difference.inDays == 1) {
      streak++;
    } else {
      streak = 1;
    }

    lastLoginDate = today;
    notifyListeners();
  }

  void unlockAchievement(String achievement) {
    if (!achievements.contains(achievement)) {
      achievements.add(achievement);
      notifyListeners();
    }
  }

  String getLevelName() {
    if (totalXP < 100) return "Bronze";
    if (totalXP < 300) return "Silver";
    if (totalXP < 700) return "Gold";
    return "Heroic";
  }

  int getXPForNextLevel() {
    if (totalXP < 100) return 100 - totalXP;
    if (totalXP < 300) return 300 - totalXP;
    if (totalXP < 700) return 700 - totalXP;
    return 999999;
  }
}
