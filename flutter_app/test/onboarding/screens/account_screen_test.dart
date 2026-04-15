import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vulgus/onboarding/screens/account_screen.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('renders Apple, Google, email options + skip', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(theme: buildAppTheme(), home: const AccountScreen(),),
      ),
    );
    expect(find.textContaining('Apple'), findsOneWidget);
    expect(find.textContaining('Google'), findsOneWidget);
    expect(find.textContaining('email'), findsOneWidget);
    expect(find.text('Skip for now'), findsOneWidget);
  });
}
