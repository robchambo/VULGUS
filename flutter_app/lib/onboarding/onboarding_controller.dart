import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_answers.dart';

class OnboardingController extends StateNotifier<OnboardingAnswers> {
  OnboardingController() : super(const OnboardingAnswers());

  static const _key = 'onboarding_answers_v1';

  void setGoal(String goal) => state = state.copyWith(goal: goal);

  void togglePainPoint(String id) {
    final next = {...state.painPoints};
    if (next.contains(id)) {
      next.remove(id);
    } else {
      next.add(id);
    }
    state = state.copyWith(painPoints: next);
  }

  void recordTinder(bool agree) =>
      state = state.copyWith(tinderResponses: [...state.tinderResponses, agree]);

  void toggleCategory(String id) {
    final next = {...state.categoryPreferences};
    if (next.contains(id)) {
      next.remove(id);
    } else {
      next.add(id);
    }
    state = state.copyWith(categoryPreferences: next);
  }

  void setNotificationsRequested(bool v) =>
      state = state.copyWith(notificationsRequested: v);

  void setEmail(String? e) => state = state.copyWith(email: e);

  Future<void> persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, state.encode());
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_key);
    if (s != null) state = OnboardingAnswers.decode(s);
  }
}

final onboardingControllerProvider =
    StateNotifierProvider<OnboardingController, OnboardingAnswers>(
  (ref) => OnboardingController(),
);
