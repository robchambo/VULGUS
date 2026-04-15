import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vulgus/onboarding/onboarding_answers.dart';
import 'package:vulgus/onboarding/onboarding_controller.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('starts empty', () {
    final container = ProviderContainer();
    expect(container.read(onboardingControllerProvider), const OnboardingAnswers());
  });

  test('setGoal updates state', () {
    final container = ProviderContainer();
    container.read(onboardingControllerProvider.notifier).setGoal('language_nerd');
    expect(container.read(onboardingControllerProvider).goal, 'language_nerd');
  });

  test('togglePainPoint adds and removes', () {
    final container = ProviderContainer();
    final c = container.read(onboardingControllerProvider.notifier);
    c.togglePainPoint('too_sanitised');
    c.togglePainPoint('too_easy');
    expect(
      container.read(onboardingControllerProvider).painPoints,
      {'too_sanitised', 'too_easy'},
    );
    c.togglePainPoint('too_easy');
    expect(container.read(onboardingControllerProvider).painPoints, {'too_sanitised'});
  });

  test('persist writes to shared_preferences and load restores', () async {
    final container = ProviderContainer();
    final c = container.read(onboardingControllerProvider.notifier);
    c.setGoal('refugee');
    c.togglePainPoint('too_easy');
    await c.persist();

    final container2 = ProviderContainer();
    await container2.read(onboardingControllerProvider.notifier).load();
    final loaded = container2.read(onboardingControllerProvider);
    expect(loaded.goal, 'refugee');
    expect(loaded.painPoints, {'too_easy'});
  });
}
