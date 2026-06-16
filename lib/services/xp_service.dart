import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/xp_model.dart';

class XPService extends ChangeNotifier {
  late UserProgress userProgress;
  late SharedPreferences _prefs;
  bool isLoaded = false;

  XPService() {
    _initializeData();
  }

  Future<void> _initializeData() async {
    _prefs = await SharedPreferences.getInstance();
    userProgress = UserProgress();
    
    userProgress.totalXP = _prefs.getInt('totalXP') ?? 0;
    userProgress.streak = _prefs.getInt('streak') ?? 0;
    userProgress.calculateLevel();
    
    isLoaded = true;
    notifyListeners();
  }

  void addXP(int amount) {
    userProgress.addXP(amount);
    _saveData();
    notifyListeners();
  }

  void addPracticeXP() {
    addXP(10);
  }

  void addReactionTestXP() {
    addXP(15);
  }

  void addChallengeXP() {
    addXP(50);
  }

  void addAccuracyXP() {
    addXP(25);
  }

  Future<void> _saveData() async {
    await _prefs.setInt('totalXP', userProgress.totalXP);
    await _prefs.setInt('streak', userProgress.streak);
  }

  String getLevelEmoji() {
    switch (userProgress.level) {
      case 1:
        return "🥉";
      case 2:
        return "🥈";
      case 3:
        return "🥇";
      case 4:
        return "👑";
      default:
        return "🥉";
    }
  }
}
