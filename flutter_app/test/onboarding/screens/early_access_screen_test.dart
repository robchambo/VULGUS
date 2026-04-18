import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vulgus/auth/user_repository.dart';
import 'package:vulgus/onboarding/onboarding_controller.dart';
import 'package:vulgus/onboarding/screens/early_access_screen.dart';
import 'package:vulgus/theme/app_theme.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockUserRepository extends Mock implements UserRepository {}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('captures email and stores it on submit', (tester) async {
    final mockUserRepo = MockUserRepository();
    when(() => mockUserRepo.saveEarlyAccessEmail(any()))
        .thenAnswer((_) async {});

    final container = ProviderContainer(
      overrides: [
        userRepositoryProvider.overrideWithValue(mockUserRepo),
      ],
    );
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
    verify(() => mockUserRepo.saveEarlyAccessEmail('test@vulgus.app')).called(1);
  });
}
