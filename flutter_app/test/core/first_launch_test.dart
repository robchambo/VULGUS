import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vulgus/core/first_launch.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('returns true on first launch', () async {
    final repo = FirstLaunchRepository();
    expect(await repo.isFirstLaunch(), isTrue);
  });

  test('returns false after markCompleted()', () async {
    final repo = FirstLaunchRepository();
    await repo.markCompleted();
    expect(await repo.isFirstLaunch(), isFalse);
  });
}
