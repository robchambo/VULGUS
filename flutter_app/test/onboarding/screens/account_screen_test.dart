import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vulgus/auth/auth_service.dart';
import 'package:vulgus/onboarding/screens/account_screen.dart';
import 'package:vulgus/theme/app_theme.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  testWidgets('renders Apple, Google options + skip (email removed)',
      (tester) async {
    final mockRepo = MockAuthRepository();
    // Stub isAnonymous so the widget can read it safely.
    when(() => mockRepo.isAnonymous).thenReturn(true);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(mockRepo),
        ],
        child: MaterialApp(
          theme: buildAppTheme(),
          home: const AccountScreen(),
        ),
      ),
    );
    expect(find.textContaining('Apple'), findsOneWidget);
    expect(find.textContaining('Google'), findsOneWidget);
    expect(find.text('Skip for now'), findsOneWidget);
  });
}
