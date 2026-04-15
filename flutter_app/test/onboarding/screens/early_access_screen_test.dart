import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vulgus/onboarding/onboarding_controller.dart';
import 'package:vulgus/onboarding/screens/early_access_screen.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('captures email and stores it on submit', (tester) async {
    final container = ProviderContainer();
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) => const EarlyAccessScreen(),
        ),
        GoRoute(
          path: '/home',
          builder: (_, __) => const Scaffold(body: Text('Home')),
        ),
      ],
    );
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          theme: buildAppTheme(),
          routerConfig: router,
        ),
      ),
    );
    await tester.pump();

    expect(find.textContaining('VULGUS+'), findsOneWidget);
    expect(find.textContaining('£19.99'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'test@vulgus.app');
    await tester.ensureVisible(find.text('NOTIFY ME'));
    await tester.tap(find.text('NOTIFY ME'));
    await tester.pump();

    expect(container.read(onboardingControllerProvider).email, 'test@vulgus.app');
  });
}
