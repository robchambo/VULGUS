# VULGUS Onboarding Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Scaffold a fresh Flutter app for VULGUS and build an 11-screen onboarding flow that ends with a soft VULGUS+ early-access email capture (no hard paywall — see `docs/superpowers/plans/notes/pricing.md` rationale or `vulgus_pricingstrategy.txt`).

**Architecture:** New Flutter app at `flutter_app/` in the repo root, sibling to `prototype/`. Riverpod for state, go_router for navigation, shared_preferences for first-launch + onboarding answers. Bauhaus design system mirrors the HTML prototype (colours, Space Grotesk + Manrope, 0px border radius, hard 2px borders). Mini-puzzle demo uses real-but-trimmed game logic (8 tiles → 2 categories) and produces a Bauhaus shape share grid as the viral moment. Account creation and Plus capture are stubs — no Firebase or RevenueCat in this plan.

**Tech Stack:** Flutter (stable), Dart, flutter_riverpod, go_router, shared_preferences, permission_handler, google_fonts, flutter_test, mocktail.

**Out of scope (separate plans):** full 16-tile game port, Firebase auth, RevenueCat paywall, notification scheduling, archive feature, mild mode toggle, real testimonials.

---

## File Structure

```
flutter_app/
├── pubspec.yaml
├── analysis_options.yaml
├── lib/
│   ├── main.dart                                ← app entry
│   ├── app.dart                                 ← MaterialApp.router + theme
│   ├── theme/
│   │   ├── app_colors.dart                      ← Bauhaus palette tokens
│   │   └── app_theme.dart                       ← ThemeData with typography
│   ├── core/
│   │   ├── first_launch.dart                    ← shared_prefs first-launch flag
│   │   └── router.dart                          ← go_router config
│   ├── onboarding/
│   │   ├── onboarding_answers.dart              ← immutable answers model
│   │   ├── onboarding_controller.dart           ← Riverpod state + persistence
│   │   ├── widgets/
│   │   │   ├── progress_bar.dart                ← thin black bar at top
│   │   │   ├── primary_button.dart              ← red rectangular CTA
│   │   │   ├── option_tile.dart                 ← single/multi select row
│   │   │   └── tinder_card.dart                 ← swipeable card
│   │   └── screens/
│   │       ├── welcome_screen.dart              ← #1
│   │       ├── goal_screen.dart                 ← #2 single-select
│   │       ├── pain_points_screen.dart          ← #3 multi-select
│   │       ├── tinder_screen.dart               ← #4 swipe deck
│   │       ├── preference_screen.dart           ← #5 category vibe grid
│   │       ├── notification_priming_screen.dart ← #6
│   │       ├── processing_screen.dart           ← #7 1.6s auto-advance
│   │       ├── demo_puzzle_screen.dart          ← #8 mini-puzzle
│   │       ├── share_grid_screen.dart           ← #9 viral share
│   │       ├── account_screen.dart              ← #10 stub auth
│   │       └── early_access_screen.dart         ← #11 soft Plus capture
│   ├── game/
│   │   ├── models/
│   │   │   ├── puzzle_category.dart
│   │   │   └── puzzle_tile.dart
│   │   ├── mini_puzzle_data.dart                ← 8-tile demo content
│   │   ├── mini_puzzle_controller.dart          ← selection/solve/lives
│   │   └── widgets/
│   │       ├── tile_grid.dart
│   │       ├── etymology_strip.dart
│   │       └── share_grid.dart                  ← Bauhaus shape grid
│   ├── notifications/
│   │   └── notification_service.dart            ← request permission only
│   ├── auth/
│   │   └── auth_service.dart                    ← stub
│   └── home/
│       └── home_placeholder.dart                ← post-onboarding stub
└── test/
    ├── theme/app_theme_test.dart
    ├── core/first_launch_test.dart
    ├── core/router_test.dart
    ├── onboarding/onboarding_controller_test.dart
    ├── onboarding/screens/welcome_screen_test.dart
    ├── onboarding/screens/goal_screen_test.dart
    ├── onboarding/screens/pain_points_screen_test.dart
    ├── onboarding/screens/tinder_screen_test.dart
    ├── onboarding/screens/preference_screen_test.dart
    ├── onboarding/screens/notification_priming_screen_test.dart
    ├── onboarding/screens/processing_screen_test.dart
    ├── onboarding/screens/share_grid_screen_test.dart
    ├── onboarding/screens/account_screen_test.dart
    ├── onboarding/screens/early_access_screen_test.dart
    └── game/
        ├── mini_puzzle_controller_test.dart
        └── widgets/tile_grid_test.dart
```

**Decomposition rationale:** Each screen file owns layout + interaction; shared widgets (button, option tile, tinder card) live under `onboarding/widgets/`. Game logic (`mini_puzzle_controller.dart`) is separated from UI so it's pure-Dart testable. Theme is split into colour tokens vs. `ThemeData` so palette tweaks don't churn the typography file.

---

## Bauhaus Design Reference (from `prototype/index.html`)

```dart
// Colours (Material 3 token names from prototype)
const background        = Color(0xFFF9F9F9);
const onSurface         = Color(0xFF1B1B1B);
const surfaceContainer  = Color(0xFFEEEEEE);
const primary           = Color(0xFFB7102A);  // red
const primaryContainer  = Color(0xFFDB313F);
const secondaryContainer= Color(0xFFFFD167);  // mustard
const tertiary          = Color(0xFF006482);  // blue
const tertiaryContainer = Color(0xFF007EA4);
const outline           = Color(0xFF8F6F6E);
const error             = Color(0xFFBA1A1A);
```

- Fonts: **Space Grotesk** (headlines/labels), **Manrope** (body)
- Border radius: **0** everywhere except full-pill icons
- Borders: hard 2px black on most containers
- App-level: 12px primary-red border around the body
- Tap feedback: 2px translate (no ripple)

---

## Task Index

1. Initialise Flutter project + dependencies
2. Configure analysis options + lints
3. Define colour tokens + theme
4. First-launch detection
5. Router with first-launch gating
6. Onboarding answers model + controller
7. Shared widget: `PrimaryButton`
8. Shared widget: `OnboardingProgressBar`
9. Shared widget: `OptionTile`
10. Shared widget: `TinderCard`
11. Screen 1 — Welcome
12. Screen 2 — Goal (single-select)
13. Screen 3 — Pain points (multi-select)
14. Screen 4 — Tinder cards
15. Screen 5 — Category preference grid
16. Screen 6 — Notification priming + permission request
17. Screen 7 — Processing
18. Mini-puzzle data + models
19. Mini-puzzle controller (logic only, TDD)
20. Mini-puzzle widgets: TileGrid + EtymologyStrip
21. Screen 8 — Demo puzzle
22. Share grid widget
23. Screen 9 — Share + viral moment
24. Stub `AuthService` + Screen 10 Account
25. Screen 11 — VULGUS+ early-access capture
26. Wire up first-launch + run-through smoke test

---

## Task 1: Initialise Flutter project + dependencies

**Files:**
- Create: `flutter_app/` (via `flutter create`)
- Modify: `flutter_app/pubspec.yaml`

- [ ] **Step 1: Verify Flutter installed**

Run from `C:/Users/robth/VULGUS`:
```bash
flutter --version
```
Expected: prints Flutter 3.x or newer. If not installed, stop and ask the user.

- [ ] **Step 2: Create the project**

Run from `C:/Users/robth/VULGUS`:
```bash
flutter create --org com.vulgus --project-name vulgus --platforms=ios,android flutter_app
```
Expected: `flutter_app/` directory with default counter app.

- [ ] **Step 3: Replace pubspec.yaml dependencies**

Overwrite `flutter_app/pubspec.yaml` with:

```yaml
name: vulgus
description: VULGUS — a daily word game for the common people.
publish_to: 'none'
version: 0.1.0+1

environment:
  sdk: '>=3.4.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.5.1
  go_router: ^14.2.0
  shared_preferences: ^2.2.3
  permission_handler: ^11.3.1
  google_fonts: ^6.2.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0
  mocktail: ^1.0.4

flutter:
  uses-material-design: true
```

- [ ] **Step 4: Install packages**

Run from `flutter_app/`:
```bash
flutter pub get
```
Expected: "Got dependencies!" with no errors.

- [ ] **Step 5: Commit**

```bash
git add flutter_app/
git commit -m "feat(flutter_app): scaffold project with riverpod + go_router"
```

---

## Task 2: Configure analysis options

**Files:**
- Modify: `flutter_app/analysis_options.yaml`

- [ ] **Step 1: Replace analysis_options.yaml**

Overwrite `flutter_app/analysis_options.yaml`:

```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    prefer_const_constructors: true
    prefer_const_literals_to_create_immutables: true
    require_trailing_commas: true
    use_key_in_widget_constructors: true
    avoid_print: true
```

- [ ] **Step 2: Run analyzer**

```bash
flutter analyze
```
Expected: no errors (default counter app may have warnings — fine for now, removed in Task 5).

- [ ] **Step 3: Commit**

```bash
git add flutter_app/analysis_options.yaml
git commit -m "chore(flutter_app): tighten lints"
```

---

## Task 3: Define colour tokens + theme

**Files:**
- Create: `flutter_app/lib/theme/app_colors.dart`
- Create: `flutter_app/lib/theme/app_theme.dart`
- Test: `flutter_app/test/theme/app_theme_test.dart`

- [ ] **Step 1: Write the failing test**

Create `flutter_app/test/theme/app_theme_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vulgus/theme/app_colors.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  test('palette matches Bauhaus prototype', () {
    expect(AppColors.background, const Color(0xFFF9F9F9));
    expect(AppColors.onSurface, const Color(0xFF1B1B1B));
    expect(AppColors.primary, const Color(0xFFB7102A));
    expect(AppColors.secondaryContainer, const Color(0xFFFFD167));
    expect(AppColors.tertiary, const Color(0xFF006482));
  });

  test('theme uses Space Grotesk for headlines and Manrope for body', () {
    final theme = buildAppTheme();
    expect(theme.textTheme.displayLarge?.fontFamily, contains('Space Grotesk'));
    expect(theme.textTheme.bodyMedium?.fontFamily, contains('Manrope'));
  });

  test('theme has zero border radius default', () {
    final theme = buildAppTheme();
    final shape = theme.cardTheme.shape as RoundedRectangleBorder;
    expect(shape.borderRadius, BorderRadius.zero);
  });
}
```

- [ ] **Step 2: Run test, expect failure**

```bash
flutter test test/theme/app_theme_test.dart
```
Expected: FAIL — `app_colors.dart` and `app_theme.dart` not found.

- [ ] **Step 3: Create app_colors.dart**

Create `flutter_app/lib/theme/app_colors.dart`:

```dart
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const background = Color(0xFFF9F9F9);
  static const surface = Color(0xFFF9F9F9);
  static const surfaceContainer = Color(0xFFEEEEEE);
  static const surfaceContainerHigh = Color(0xFFE8E8E8);
  static const surfaceContainerLowest = Color(0xFFFFFFFF);
  static const onSurface = Color(0xFF1B1B1B);
  static const onSurfaceVariant = Color(0xFF5B403F);
  static const primary = Color(0xFFB7102A);
  static const primaryContainer = Color(0xFFDB313F);
  static const onPrimary = Color(0xFFFFFFFF);
  static const secondary = Color(0xFF785A00);
  static const secondaryContainer = Color(0xFFFFD167);
  static const onSecondaryContainer = Color(0xFF765900);
  static const tertiary = Color(0xFF006482);
  static const tertiaryContainer = Color(0xFF007EA4);
  static const onTertiary = Color(0xFFFFFFFF);
  static const outline = Color(0xFF8F6F6E);
  static const error = Color(0xFFBA1A1A);
}
```

- [ ] **Step 4: Create app_theme.dart**

Create `flutter_app/lib/theme/app_theme.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

ThemeData buildAppTheme() {
  final base = ThemeData.light(useMaterial3: true);
  final headline = GoogleFonts.spaceGroteskTextTheme(base.textTheme);
  final body = GoogleFonts.manropeTextTheme(base.textTheme);

  final textTheme = base.textTheme.copyWith(
    displayLarge: headline.displayLarge?.copyWith(
      fontWeight: FontWeight.w900, color: AppColors.onSurface,
      letterSpacing: -2,
    ),
    displayMedium: headline.displayMedium?.copyWith(
      fontWeight: FontWeight.w900, color: AppColors.onSurface,
    ),
    headlineLarge: headline.headlineLarge?.copyWith(
      fontWeight: FontWeight.w800, color: AppColors.onSurface,
    ),
    headlineMedium: headline.headlineMedium?.copyWith(
      fontWeight: FontWeight.w700, color: AppColors.onSurface,
    ),
    titleLarge: headline.titleLarge?.copyWith(
      fontWeight: FontWeight.w700, color: AppColors.onSurface,
    ),
    bodyLarge: body.bodyLarge?.copyWith(color: AppColors.onSurface),
    bodyMedium: body.bodyMedium?.copyWith(color: AppColors.onSurface),
    labelLarge: GoogleFonts.spaceGrotesk(
      fontWeight: FontWeight.w700,
      letterSpacing: 1.2,
      color: AppColors.onSurface,
    ),
  );

  return base.copyWith(
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondaryContainer,
      onSecondary: AppColors.onSecondaryContainer,
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.onTertiary,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      error: AppColors.error,
      onError: Colors.white,
    ),
    textTheme: textTheme,
    cardTheme: const CardTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      color: AppColors.surfaceContainerLowest,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        textStyle: GoogleFonts.spaceGrotesk(
          fontWeight: FontWeight.w800, fontSize: 16, letterSpacing: 1.2,
        ),
      ),
    ),
  );
}
```

- [ ] **Step 5: Run test, expect pass**

```bash
flutter test test/theme/app_theme_test.dart
```
Expected: PASS (3 tests).

- [ ] **Step 6: Commit**

```bash
git add lib/theme/ test/theme/
git commit -m "feat(theme): Bauhaus colour tokens and Material 3 theme"
```

---

## Task 4: First-launch detection

**Files:**
- Create: `flutter_app/lib/core/first_launch.dart`
- Test: `flutter_app/test/core/first_launch_test.dart`

- [ ] **Step 1: Write the failing test**

Create `flutter_app/test/core/first_launch_test.dart`:

```dart
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
```

- [ ] **Step 2: Run test, expect failure**

```bash
flutter test test/core/first_launch_test.dart
```
Expected: FAIL — file not found.

- [ ] **Step 3: Implement**

Create `flutter_app/lib/core/first_launch.dart`:

```dart
import 'package:shared_preferences/shared_preferences.dart';

class FirstLaunchRepository {
  static const _key = 'onboarding_completed_v1';

  Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return !(prefs.getBool(_key) ?? false);
  }

  Future<void> markCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, true);
  }
}
```

- [ ] **Step 4: Run test, expect pass**

```bash
flutter test test/core/first_launch_test.dart
```
Expected: PASS (2 tests).

- [ ] **Step 5: Commit**

```bash
git add lib/core/first_launch.dart test/core/first_launch_test.dart
git commit -m "feat(core): first-launch repository backed by shared_preferences"
```

---

## Task 5: Router with first-launch gating + main entry

**Files:**
- Create: `flutter_app/lib/core/router.dart`
- Create: `flutter_app/lib/app.dart`
- Create: `flutter_app/lib/home/home_placeholder.dart`
- Modify: `flutter_app/lib/main.dart`
- Test: `flutter_app/test/core/router_test.dart`

- [ ] **Step 1: Write the failing test**

Create `flutter_app/test/core/router_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vulgus/app.dart';
import 'package:vulgus/core/first_launch.dart';

void main() {
  testWidgets('routes to /onboarding/welcome when first launch', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const ProviderScope(child: VulgusApp()));
    await tester.pumpAndSettle();
    expect(find.text('A daily word game for the common people'), findsOneWidget);
  });

  testWidgets('routes to /home when onboarding complete', (tester) async {
    SharedPreferences.setMockInitialValues({'onboarding_completed_v1': true});
    await tester.pumpWidget(const ProviderScope(child: VulgusApp()));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('home_placeholder')), findsOneWidget);
  });
}
```

- [ ] **Step 2: Run test, expect failure**

```bash
flutter test test/core/router_test.dart
```
Expected: FAIL — files don't exist.

- [ ] **Step 3: Create home_placeholder.dart**

Create `flutter_app/lib/home/home_placeholder.dart`:

```dart
import 'package:flutter/material.dart';

class HomePlaceholder extends StatelessWidget {
  const HomePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('home_placeholder'),
      body: Center(
        child: Text(
          'VULGUS\n001',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
```

- [ ] **Step 4: Create router.dart with all 11 onboarding routes**

Create `flutter_app/lib/core/router.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/first_launch.dart';
import '../home/home_placeholder.dart';
import '../onboarding/screens/welcome_screen.dart';
import '../onboarding/screens/goal_screen.dart';
import '../onboarding/screens/pain_points_screen.dart';
import '../onboarding/screens/tinder_screen.dart';
import '../onboarding/screens/preference_screen.dart';
import '../onboarding/screens/notification_priming_screen.dart';
import '../onboarding/screens/processing_screen.dart';
import '../onboarding/screens/demo_puzzle_screen.dart';
import '../onboarding/screens/share_grid_screen.dart';
import '../onboarding/screens/account_screen.dart';
import '../onboarding/screens/early_access_screen.dart';

final firstLaunchProvider = FutureProvider<bool>((ref) async {
  return FirstLaunchRepository().isFirstLaunch();
});

GoRouter buildRouter(bool isFirstLaunch) {
  return GoRouter(
    initialLocation: isFirstLaunch ? '/onboarding/welcome' : '/home',
    routes: [
      GoRoute(path: '/home', builder: (_, __) => const HomePlaceholder()),
      GoRoute(path: '/onboarding/welcome', builder: (_, __) => const WelcomeScreen()),
      GoRoute(path: '/onboarding/goal', builder: (_, __) => const GoalScreen()),
      GoRoute(path: '/onboarding/pain', builder: (_, __) => const PainPointsScreen()),
      GoRoute(path: '/onboarding/tinder', builder: (_, __) => const TinderScreen()),
      GoRoute(path: '/onboarding/preference', builder: (_, __) => const PreferenceScreen()),
      GoRoute(path: '/onboarding/notify', builder: (_, __) => const NotificationPrimingScreen()),
      GoRoute(path: '/onboarding/processing', builder: (_, __) => const ProcessingScreen()),
      GoRoute(path: '/onboarding/demo', builder: (_, __) => const DemoPuzzleScreen()),
      GoRoute(path: '/onboarding/share', builder: (_, __) => const ShareGridScreen()),
      GoRoute(path: '/onboarding/account', builder: (_, __) => const AccountScreen()),
      GoRoute(path: '/onboarding/early-access', builder: (_, __) => const EarlyAccessScreen()),
    ],
  );
}
```

- [ ] **Step 5: Create app.dart**

Create `flutter_app/lib/app.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router.dart';
import 'theme/app_theme.dart';

class VulgusApp extends ConsumerWidget {
  const VulgusApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstLaunch = ref.watch(firstLaunchProvider);
    return firstLaunch.when(
      data: (isFirst) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'VULGUS',
        theme: buildAppTheme(),
        routerConfig: buildRouter(isFirst),
      ),
      loading: () => const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      error: (e, _) => MaterialApp(
        home: Scaffold(body: Center(child: Text('Error: $e'))),
      ),
    );
  }
}
```

- [ ] **Step 6: Replace main.dart**

Overwrite `flutter_app/lib/main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: VulgusApp()));
}
```

- [ ] **Step 7: Create empty stub screens so router compiles**

For each of these 11 files, create a placeholder so the router imports resolve (they will be filled in later tasks). Use this template, replacing `WelcomeScreen` and the route name as appropriate:

```dart
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('A daily word game for the common people')));
}
```

Files to create (with matching class name):
- `lib/onboarding/screens/welcome_screen.dart` → `WelcomeScreen`, body text `A daily word game for the common people`
- `lib/onboarding/screens/goal_screen.dart` → `GoalScreen`, body text `Goal`
- `lib/onboarding/screens/pain_points_screen.dart` → `PainPointsScreen`, body text `Pain`
- `lib/onboarding/screens/tinder_screen.dart` → `TinderScreen`, body text `Tinder`
- `lib/onboarding/screens/preference_screen.dart` → `PreferenceScreen`, body text `Preference`
- `lib/onboarding/screens/notification_priming_screen.dart` → `NotificationPrimingScreen`, body text `Notify`
- `lib/onboarding/screens/processing_screen.dart` → `ProcessingScreen`, body text `Processing`
- `lib/onboarding/screens/demo_puzzle_screen.dart` → `DemoPuzzleScreen`, body text `Demo`
- `lib/onboarding/screens/share_grid_screen.dart` → `ShareGridScreen`, body text `Share`
- `lib/onboarding/screens/account_screen.dart` → `AccountScreen`, body text `Account`
- `lib/onboarding/screens/early_access_screen.dart` → `EarlyAccessScreen`, body text `Early access`

- [ ] **Step 8: Run router test, expect pass**

```bash
flutter test test/core/router_test.dart
```
Expected: PASS (2 tests).

- [ ] **Step 9: Commit**

```bash
git add lib/ test/core/router_test.dart
git commit -m "feat(core): go_router config gated on first-launch state"
```

---

## Task 6: Onboarding answers model + controller

**Files:**
- Create: `flutter_app/lib/onboarding/onboarding_answers.dart`
- Create: `flutter_app/lib/onboarding/onboarding_controller.dart`
- Test: `flutter_app/test/onboarding/onboarding_controller_test.dart`

- [ ] **Step 1: Write the failing test**

Create `flutter_app/test/onboarding/onboarding_controller_test.dart`:

```dart
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
    expect(container.read(onboardingControllerProvider).painPoints,
        {'too_sanitised', 'too_easy'});
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
```

- [ ] **Step 2: Run test, expect failure**

```bash
flutter test test/onboarding/onboarding_controller_test.dart
```
Expected: FAIL — files not found.

- [ ] **Step 3: Implement answers model**

Create `flutter_app/lib/onboarding/onboarding_answers.dart`:

```dart
import 'dart:convert';

class OnboardingAnswers {
  final String? goal;
  final Set<String> painPoints;
  final List<bool> tinderResponses; // true=agree, false=dismiss
  final Set<String> categoryPreferences;
  final bool notificationsRequested;
  final String? email;

  const OnboardingAnswers({
    this.goal,
    this.painPoints = const {},
    this.tinderResponses = const [],
    this.categoryPreferences = const {},
    this.notificationsRequested = false,
    this.email,
  });

  OnboardingAnswers copyWith({
    String? goal,
    Set<String>? painPoints,
    List<bool>? tinderResponses,
    Set<String>? categoryPreferences,
    bool? notificationsRequested,
    String? email,
  }) =>
      OnboardingAnswers(
        goal: goal ?? this.goal,
        painPoints: painPoints ?? this.painPoints,
        tinderResponses: tinderResponses ?? this.tinderResponses,
        categoryPreferences: categoryPreferences ?? this.categoryPreferences,
        notificationsRequested: notificationsRequested ?? this.notificationsRequested,
        email: email ?? this.email,
      );

  Map<String, dynamic> toJson() => {
        'goal': goal,
        'painPoints': painPoints.toList(),
        'tinderResponses': tinderResponses,
        'categoryPreferences': categoryPreferences.toList(),
        'notificationsRequested': notificationsRequested,
        'email': email,
      };

  factory OnboardingAnswers.fromJson(Map<String, dynamic> j) => OnboardingAnswers(
        goal: j['goal'] as String?,
        painPoints: (j['painPoints'] as List).cast<String>().toSet(),
        tinderResponses: (j['tinderResponses'] as List).cast<bool>(),
        categoryPreferences: (j['categoryPreferences'] as List).cast<String>().toSet(),
        notificationsRequested: j['notificationsRequested'] as bool? ?? false,
        email: j['email'] as String?,
      );

  String encode() => jsonEncode(toJson());
  factory OnboardingAnswers.decode(String s) =>
      OnboardingAnswers.fromJson(jsonDecode(s) as Map<String, dynamic>);

  @override
  bool operator ==(Object other) =>
      other is OnboardingAnswers &&
      other.goal == goal &&
      _setEq(other.painPoints, painPoints) &&
      _listEq(other.tinderResponses, tinderResponses) &&
      _setEq(other.categoryPreferences, categoryPreferences) &&
      other.notificationsRequested == notificationsRequested &&
      other.email == email;

  @override
  int get hashCode => Object.hash(
        goal, painPoints.length, tinderResponses.length,
        categoryPreferences.length, notificationsRequested, email,
      );
}

bool _setEq<T>(Set<T> a, Set<T> b) =>
    a.length == b.length && a.containsAll(b);
bool _listEq<T>(List<T> a, List<T> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
```

- [ ] **Step 4: Implement controller**

Create `flutter_app/lib/onboarding/onboarding_controller.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_answers.dart';

class OnboardingController extends StateNotifier<OnboardingAnswers> {
  OnboardingController() : super(const OnboardingAnswers());

  static const _key = 'onboarding_answers_v1';

  void setGoal(String goal) => state = state.copyWith(goal: goal);

  void togglePainPoint(String id) {
    final next = {...state.painPoints};
    next.contains(id) ? next.remove(id) : next.add(id);
    state = state.copyWith(painPoints: next);
  }

  void recordTinder(bool agree) =>
      state = state.copyWith(tinderResponses: [...state.tinderResponses, agree]);

  void toggleCategory(String id) {
    final next = {...state.categoryPreferences};
    next.contains(id) ? next.remove(id) : next.add(id);
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
```

- [ ] **Step 5: Run test, expect pass**

```bash
flutter test test/onboarding/onboarding_controller_test.dart
```
Expected: PASS (4 tests).

- [ ] **Step 6: Commit**

```bash
git add lib/onboarding/ test/onboarding/onboarding_controller_test.dart
git commit -m "feat(onboarding): answers model + Riverpod controller with persistence"
```

---

## Task 7: Shared widget — PrimaryButton

**Files:**
- Create: `flutter_app/lib/onboarding/widgets/primary_button.dart`

- [ ] **Step 1: Implement** (no separate test — exercised by screen tests)

Create `flutter_app/lib/onboarding/widgets/primary_button.dart`:

```dart
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool fullWidth;
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.fullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    final btn = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: onPressed == null
            ? AppColors.surfaceContainerHigh
            : AppColors.primary,
        foregroundColor: onPressed == null
            ? AppColors.onSurfaceVariant
            : AppColors.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: AppColors.onSurface, width: 2),
        ),
        minimumSize: const Size.fromHeight(56),
      ),
      child: Text(label.toUpperCase()),
    );
    return fullWidth ? SizedBox(width: double.infinity, child: btn) : btn;
  }
}
```

- [ ] **Step 2: Compile check**

```bash
flutter analyze lib/onboarding/widgets/primary_button.dart
```
Expected: no issues.

- [ ] **Step 3: Commit**

```bash
git add lib/onboarding/widgets/primary_button.dart
git commit -m "feat(onboarding): PrimaryButton with Bauhaus styling"
```

---

## Task 8: Shared widget — OnboardingProgressBar

**Files:**
- Create: `flutter_app/lib/onboarding/widgets/progress_bar.dart`

- [ ] **Step 1: Implement**

Create `flutter_app/lib/onboarding/widgets/progress_bar.dart`:

```dart
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class OnboardingProgressBar extends StatelessWidget {
  final int step;
  final int total;
  const OnboardingProgressBar({super.key, required this.step, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6,
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        border: Border(bottom: BorderSide(color: AppColors.onSurface, width: 2)),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: (step / total).clamp(0.0, 1.0),
          child: Container(color: AppColors.primary),
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Compile check**

```bash
flutter analyze lib/onboarding/widgets/progress_bar.dart
```
Expected: no issues.

- [ ] **Step 3: Commit**

```bash
git add lib/onboarding/widgets/progress_bar.dart
git commit -m "feat(onboarding): progress bar widget"
```

---

## Task 9: Shared widget — OptionTile

**Files:**
- Create: `flutter_app/lib/onboarding/widgets/option_tile.dart`

- [ ] **Step 1: Implement**

Create `flutter_app/lib/onboarding/widgets/option_tile.dart`:

```dart
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class OptionTile extends StatelessWidget {
  final String emoji;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const OptionTile({
    super.key,
    required this.emoji,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 90),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.onSurface : AppColors.surfaceContainerLowest,
          border: Border.all(color: AppColors.onSurface, width: 2),
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: selected ? AppColors.onPrimary : AppColors.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            if (selected)
              const Icon(Icons.check, color: AppColors.onPrimary, size: 24),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add lib/onboarding/widgets/option_tile.dart
git commit -m "feat(onboarding): OptionTile for single/multi-select lists"
```

---

## Task 10: Shared widget — TinderCard

**Files:**
- Create: `flutter_app/lib/onboarding/widgets/tinder_card.dart`

- [ ] **Step 1: Implement**

Create `flutter_app/lib/onboarding/widgets/tinder_card.dart`:

```dart
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class TinderCard extends StatefulWidget {
  final String statement;
  final void Function(bool agree) onSwiped;
  const TinderCard({super.key, required this.statement, required this.onSwiped});

  @override
  State<TinderCard> createState() => _TinderCardState();
}

class _TinderCardState extends State<TinderCard> {
  double _dx = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onPanUpdate: (d) => setState(() => _dx += d.delta.dx),
      onPanEnd: (_) {
        if (_dx.abs() > 120) {
          widget.onSwiped(_dx > 0);
        } else {
          setState(() => _dx = 0);
        }
      },
      child: Transform.translate(
        offset: Offset(_dx, 0),
        child: Transform.rotate(
          angle: _dx / width * 0.4,
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              border: Border.all(color: AppColors.onSurface, width: 2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.format_quote, size: 40, color: AppColors.primary),
                const SizedBox(height: 16),
                Text(
                  '"${widget.statement}"',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ActionButton(
                      icon: Icons.close,
                      color: AppColors.onSurface,
                      onTap: () => widget.onSwiped(false),
                    ),
                    _ActionButton(
                      icon: Icons.check,
                      color: AppColors.primary,
                      onTap: () => widget.onSwiped(true),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _ActionButton({required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(border: Border.all(color: color, width: 2)),
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add lib/onboarding/widgets/tinder_card.dart
git commit -m "feat(onboarding): TinderCard swipeable widget"
```

---

## Task 11: Screen 1 — Welcome

**Files:**
- Modify: `flutter_app/lib/onboarding/screens/welcome_screen.dart`
- Test: `flutter_app/test/onboarding/screens/welcome_screen_test.dart`

- [ ] **Step 1: Write the failing test**

Create `flutter_app/test/onboarding/screens/welcome_screen_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vulgus/onboarding/screens/welcome_screen.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('renders headline, VULGUS wordmark, and CTA', (tester) async {
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(theme: buildAppTheme(), home: const WelcomeScreen()),
    ));
    expect(find.text('VULGUS'), findsOneWidget);
    expect(find.textContaining('common people'), findsOneWidget);
    expect(find.text('GET STARTED'), findsOneWidget);
  });
}
```

- [ ] **Step 2: Run test, expect failure**

```bash
flutter test test/onboarding/screens/welcome_screen_test.dart
```
Expected: FAIL — no `GET STARTED`.

- [ ] **Step 3: Implement**

Overwrite `flutter_app/lib/onboarding/screens/welcome_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../widgets/primary_button.dart';
import '../widgets/progress_bar.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          border: Border.fromBorderSide(BorderSide(color: AppColors.primary, width: 12)),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const OnboardingProgressBar(step: 1, total: 11),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      Text('VULGUS',
                          style: t.displayLarge?.copyWith(color: AppColors.primary)),
                      const SizedBox(height: 12),
                      Text(
                        'A daily word game for the common people.',
                        style: t.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sort the sweary. Skip the slurs.',
                        style: t.bodyLarge?.copyWith(color: AppColors.onSurfaceVariant),
                      ),
                      const Spacer(),
                      Center(
                        child: Container(
                          height: 220,
                          decoration: BoxDecoration(
                            color: AppColors.secondaryContainer,
                            border: Border.all(color: AppColors.onSurface, width: 2),
                          ),
                          child: const Center(
                            child: Icon(Icons.grid_view,
                                size: 96, color: AppColors.onSurface),
                          ),
                        ),
                      ),
                      const Spacer(),
                      PrimaryButton(
                        label: 'Get started',
                        onPressed: () => context.go('/onboarding/goal'),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: TextButton(
                          onPressed: () => context.go('/onboarding/account'),
                          child: const Text('I already have an account'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 4: Run test, expect pass**

```bash
flutter test test/onboarding/screens/welcome_screen_test.dart
```
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add lib/onboarding/screens/welcome_screen.dart test/onboarding/screens/welcome_screen_test.dart
git commit -m "feat(onboarding): screen 1 welcome"
```

---

## Task 12: Screen 2 — Goal (single-select)

**Files:**
- Modify: `flutter_app/lib/onboarding/screens/goal_screen.dart`
- Test: `flutter_app/test/onboarding/screens/goal_screen_test.dart`

- [ ] **Step 1: Write the failing test**

Create `flutter_app/test/onboarding/screens/goal_screen_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vulgus/onboarding/onboarding_controller.dart';
import 'package:vulgus/onboarding/screens/goal_screen.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('selecting an option enables Continue and stores answer',
      (tester) async {
    final container = ProviderContainer();
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(theme: buildAppTheme(), home: const GoalScreen()),
    ));
    expect(find.text('CONTINUE'), findsOneWidget);

    await tester.tap(find.textContaining('Connections refugee'));
    await tester.pump();

    expect(container.read(onboardingControllerProvider).goal, isNotNull);
  });
}
```

- [ ] **Step 2: Run test, expect failure**

```bash
flutter test test/onboarding/screens/goal_screen_test.dart
```
Expected: FAIL.

- [ ] **Step 3: Implement**

Overwrite `flutter_app/lib/onboarding/screens/goal_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../onboarding_controller.dart';
import '../widgets/option_tile.dart';
import '../widgets/primary_button.dart';
import '../widgets/progress_bar.dart';

class GoalScreen extends ConsumerWidget {
  const GoalScreen({super.key});

  static const _options = [
    ('connections_refugee', '🧩', "I'm a Connections refugee"),
    ('language_nerd', '📖', 'I love a good etymology'),
    ('love_a_swear', '🤬', 'I love a good swear'),
    ('daily_ritual', '☕', 'I want a 5-minute daily habit'),
    ('just_curious', '👀', 'Just having a look'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answers = ref.watch(onboardingControllerProvider);
    final ctrl = ref.read(onboardingControllerProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingProgressBar(step: 2, total: 11),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Text('What brings you to VULGUS?',
                        style: Theme.of(context).textTheme.headlineLarge),
                    const SizedBox(height: 24),
                    Expanded(
                      child: ListView(
                        children: [
                          for (final (id, emoji, label) in _options)
                            OptionTile(
                              emoji: emoji,
                              label: label,
                              selected: answers.goal == id,
                              onTap: () => ctrl.setGoal(id),
                            ),
                        ],
                      ),
                    ),
                    PrimaryButton(
                      label: 'Continue',
                      onPressed: answers.goal == null
                          ? null
                          : () => context.go('/onboarding/pain'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 4: Run test, expect pass**

```bash
flutter test test/onboarding/screens/goal_screen_test.dart
```
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add lib/onboarding/screens/goal_screen.dart test/onboarding/screens/goal_screen_test.dart
git commit -m "feat(onboarding): screen 2 goal selection"
```

---

## Task 13: Screen 3 — Pain points (multi-select)

**Files:**
- Modify: `flutter_app/lib/onboarding/screens/pain_points_screen.dart`
- Test: `flutter_app/test/onboarding/screens/pain_points_screen_test.dart`

- [ ] **Step 1: Write the failing test**

Create `flutter_app/test/onboarding/screens/pain_points_screen_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vulgus/onboarding/onboarding_controller.dart';
import 'package:vulgus/onboarding/screens/pain_points_screen.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('multi-select toggles pain points', (tester) async {
    final container = ProviderContainer();
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(theme: buildAppTheme(), home: const PainPointsScreen()),
    ));

    await tester.tap(find.textContaining('too sanitised'));
    await tester.tap(find.textContaining('too easy'));
    await tester.pump();

    expect(container.read(onboardingControllerProvider).painPoints.length, 2);
  });
}
```

- [ ] **Step 2: Run test, expect failure**

```bash
flutter test test/onboarding/screens/pain_points_screen_test.dart
```
Expected: FAIL.

- [ ] **Step 3: Implement**

Overwrite `flutter_app/lib/onboarding/screens/pain_points_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../onboarding_controller.dart';
import '../widgets/option_tile.dart';
import '../widgets/primary_button.dart';
import '../widgets/progress_bar.dart';

class PainPointsScreen extends ConsumerWidget {
  const PainPointsScreen({super.key});

  static const _options = [
    ('too_sanitised', '🥱', 'Other word games are too sanitised'),
    ('too_easy', '😴', 'Wordle/Connections feel too easy'),
    ('repetitive', '🔁', 'They get repetitive fast'),
    ('no_learning', '🧠', "I don't learn anything from them"),
    ('no_ritual', '⏰', 'No proper daily ritual'),
    ('ugly_design', '🎨', 'Ugly, generic design'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answers = ref.watch(onboardingControllerProvider);
    final ctrl = ref.read(onboardingControllerProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingProgressBar(step: 3, total: 11),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Text('What annoys you about other word games?',
                        style: Theme.of(context).textTheme.headlineLarge),
                    const SizedBox(height: 8),
                    Text('Pick as many as you like.',
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 24),
                    Expanded(
                      child: ListView(
                        children: [
                          for (final (id, emoji, label) in _options)
                            OptionTile(
                              emoji: emoji,
                              label: label,
                              selected: answers.painPoints.contains(id),
                              onTap: () => ctrl.togglePainPoint(id),
                            ),
                        ],
                      ),
                    ),
                    PrimaryButton(
                      label: 'Continue',
                      onPressed: answers.painPoints.isEmpty
                          ? null
                          : () => context.go('/onboarding/tinder'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 4: Run test, expect pass**

```bash
flutter test test/onboarding/screens/pain_points_screen_test.dart
```
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add lib/onboarding/screens/pain_points_screen.dart test/onboarding/screens/pain_points_screen_test.dart
git commit -m "feat(onboarding): screen 3 pain points"
```

---

## Task 14: Screen 4 — Tinder cards

**Files:**
- Modify: `flutter_app/lib/onboarding/screens/tinder_screen.dart`
- Test: `flutter_app/test/onboarding/screens/tinder_screen_test.dart`

- [ ] **Step 1: Write the failing test**

Create `flutter_app/test/onboarding/screens/tinder_screen_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vulgus/onboarding/onboarding_controller.dart';
import 'package:vulgus/onboarding/screens/tinder_screen.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('tapping check records agree', (tester) async {
    final container = ProviderContainer();
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(theme: buildAppTheme(), home: const TinderScreen()),
    ));
    await tester.tap(find.byIcon(Icons.check));
    await tester.pump();
    expect(container.read(onboardingControllerProvider).tinderResponses,
        contains(true));
  });
}
```

- [ ] **Step 2: Run test, expect failure**

```bash
flutter test test/onboarding/screens/tinder_screen_test.dart
```
Expected: FAIL.

- [ ] **Step 3: Implement**

Overwrite `flutter_app/lib/onboarding/screens/tinder_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../onboarding_controller.dart';
import '../widgets/progress_bar.dart';
import '../widgets/tinder_card.dart';

class TinderScreen extends ConsumerStatefulWidget {
  const TinderScreen({super.key});
  @override
  ConsumerState<TinderScreen> createState() => _TinderScreenState();
}

class _TinderScreenState extends ConsumerState<TinderScreen> {
  static const _statements = [
    "I've definitely Googled where a swear word comes from.",
    "Connections is too tame for me.",
    "I want a word game I can do over my morning coffee.",
    "I'd rather be sweary than safe.",
  ];
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final ctrl = ref.read(onboardingControllerProvider.notifier);
    if (_index >= _statements.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.go('/onboarding/preference');
      });
      return const SizedBox.shrink();
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingProgressBar(step: 4, total: 11),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Which of these sounds like you?',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TinderCard(
                    key: ValueKey(_index),
                    statement: _statements[_index],
                    onSwiped: (agree) {
                      ctrl.recordTinder(agree);
                      setState(() => _index++);
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Card ${_index + 1} of ${_statements.length}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 4: Run test, expect pass**

```bash
flutter test test/onboarding/screens/tinder_screen_test.dart
```
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add lib/onboarding/screens/tinder_screen.dart test/onboarding/screens/tinder_screen_test.dart
git commit -m "feat(onboarding): screen 4 tinder statement deck"
```

---

## Task 15: Screen 5 — Category preference grid

**Files:**
- Modify: `flutter_app/lib/onboarding/screens/preference_screen.dart`
- Test: `flutter_app/test/onboarding/screens/preference_screen_test.dart`

- [ ] **Step 1: Write the failing test**

Create `flutter_app/test/onboarding/screens/preference_screen_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vulgus/onboarding/onboarding_controller.dart';
import 'package:vulgus/onboarding/screens/preference_screen.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('tapping a category card toggles selection', (tester) async {
    final container = ProviderContainer();
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(theme: buildAppTheme(), home: const PreferenceScreen()),
    ));
    await tester.tap(find.textContaining('British'));
    await tester.pump();
    expect(container.read(onboardingControllerProvider).categoryPreferences,
        contains('british'));
  });
}
```

- [ ] **Step 2: Run test, expect failure**

```bash
flutter test test/onboarding/screens/preference_screen_test.dart
```
Expected: FAIL.

- [ ] **Step 3: Implement**

Overwrite `flutter_app/lib/onboarding/screens/preference_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../onboarding_controller.dart';
import '../widgets/primary_button.dart';
import '../widgets/progress_bar.dart';

class PreferenceScreen extends ConsumerWidget {
  const PreferenceScreen({super.key});

  static const _categories = [
    ('british', '🇬🇧', 'British classics'),
    ('soft', '☁️', 'Soft swears'),
    ('minced', '🥧', 'Minced oaths'),
    ('scifi', '🚀', 'Sci-fi fictional'),
    ('eponymous', '👤', 'Eponymous'),
    ('shakespeare', '🎭', 'Shakespearean'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answers = ref.watch(onboardingControllerProvider);
    final ctrl = ref.read(onboardingControllerProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingProgressBar(step: 5, total: 11),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Text('Pick your favourite vibes',
                        style: Theme.of(context).textTheme.headlineLarge),
                    const SizedBox(height: 8),
                    Text("We'll lean into these in your puzzles.",
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 24),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        children: [
                          for (final (id, emoji, label) in _categories)
                            _CategoryCard(
                              emoji: emoji,
                              label: label,
                              selected: answers.categoryPreferences.contains(id),
                              onTap: () => ctrl.toggleCategory(id),
                            ),
                        ],
                      ),
                    ),
                    PrimaryButton(
                      label: 'Continue',
                      onPressed: answers.categoryPreferences.isEmpty
                          ? null
                          : () => context.go('/onboarding/notify'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String emoji;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _CategoryCard({
    required this.emoji,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: selected ? AppColors.secondaryContainer : AppColors.surfaceContainerLowest,
          border: Border.all(color: AppColors.onSurface, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 4: Run test, expect pass**

```bash
flutter test test/onboarding/screens/preference_screen_test.dart
```
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add lib/onboarding/screens/preference_screen.dart test/onboarding/screens/preference_screen_test.dart
git commit -m "feat(onboarding): screen 5 category preference grid"
```

---

## Task 16: Screen 6 — Notification priming

**Files:**
- Create: `flutter_app/lib/notifications/notification_service.dart`
- Modify: `flutter_app/lib/onboarding/screens/notification_priming_screen.dart`
- Test: `flutter_app/test/onboarding/screens/notification_priming_screen_test.dart`

- [ ] **Step 1: Implement notification_service.dart**

Create `flutter_app/lib/notifications/notification_service.dart`:

```dart
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  Future<bool> requestPermission() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }
}
```

- [ ] **Step 2: Write the failing test**

Create `flutter_app/test/onboarding/screens/notification_priming_screen_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vulgus/onboarding/screens/notification_priming_screen.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('renders headline and both CTAs', (tester) async {
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(theme: buildAppTheme(), home: const NotificationPrimingScreen()),
    ));
    expect(find.textContaining('Never miss'), findsOneWidget);
    expect(find.text('ENABLE NOTIFICATIONS'), findsOneWidget);
    expect(find.text('Not now'), findsOneWidget);
  });
}
```

- [ ] **Step 3: Run test, expect failure**

```bash
flutter test test/onboarding/screens/notification_priming_screen_test.dart
```
Expected: FAIL.

- [ ] **Step 4: Implement screen**

Overwrite `flutter_app/lib/onboarding/screens/notification_priming_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../notifications/notification_service.dart';
import '../../theme/app_colors.dart';
import '../onboarding_controller.dart';
import '../widgets/primary_button.dart';
import '../widgets/progress_bar.dart';

class NotificationPrimingScreen extends ConsumerWidget {
  const NotificationPrimingScreen({super.key});

  Future<void> _enable(BuildContext context, WidgetRef ref) async {
    final granted = await NotificationService().requestPermission();
    ref.read(onboardingControllerProvider.notifier)
        .setNotificationsRequested(granted);
    if (context.mounted) context.go('/onboarding/processing');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingProgressBar(step: 6, total: 11),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Text('Never miss the daily drop',
                        style: Theme.of(context).textTheme.headlineLarge),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryContainer,
                        border: Border.all(color: AppColors.onSurface, width: 2),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _Bullet('A new puzzle every morning at 9am'),
                          SizedBox(height: 12),
                          _Bullet('A nudge if you forget — keep your streak alive'),
                          SizedBox(height: 12),
                          _Bullet('No spam. Ever. Just the one ping.'),
                        ],
                      ),
                    ),
                    const Spacer(),
                    PrimaryButton(
                      label: 'Enable notifications',
                      onPressed: () => _enable(context, ref),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: TextButton(
                        onPressed: () => context.go('/onboarding/processing'),
                        child: const Text('Not now'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;
  const _Bullet(this.text);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('▪️ ', style: TextStyle(fontSize: 16)),
        Expanded(
          child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
        ),
      ],
    );
  }
}
```

- [ ] **Step 5: Run test, expect pass**

```bash
flutter test test/onboarding/screens/notification_priming_screen_test.dart
```
Expected: PASS.

- [ ] **Step 6: Commit**

```bash
git add lib/notifications/ lib/onboarding/screens/notification_priming_screen.dart test/onboarding/screens/notification_priming_screen_test.dart
git commit -m "feat(onboarding): screen 6 notification priming"
```

---

## Task 17: Screen 7 — Processing

**Files:**
- Modify: `flutter_app/lib/onboarding/screens/processing_screen.dart`
- Test: `flutter_app/test/onboarding/screens/processing_screen_test.dart`

- [ ] **Step 1: Write the failing test**

Create `flutter_app/test/onboarding/screens/processing_screen_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vulgus/onboarding/screens/processing_screen.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('shows building copy and progress indicator', (tester) async {
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(theme: buildAppTheme(), home: const ProcessingScreen()),
    ));
    expect(find.textContaining('Building'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
```

- [ ] **Step 2: Run test, expect failure**

```bash
flutter test test/onboarding/screens/processing_screen_test.dart
```
Expected: FAIL.

- [ ] **Step 3: Implement**

Overwrite `flutter_app/lib/onboarding/screens/processing_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../widgets/progress_bar.dart';

class ProcessingScreen extends ConsumerStatefulWidget {
  const ProcessingScreen({super.key});
  @override
  ConsumerState<ProcessingScreen> createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends ConsumerState<ProcessingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1600), () {
      if (mounted) context.go('/onboarding/demo');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingProgressBar(step: 7, total: 11),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 64, height: 64,
                      child: CircularProgressIndicator(
                        color: AppColors.primary, strokeWidth: 6,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text('Building puzzle 001…',
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 8),
                    Text('Hand-picked from your favourite vibes.',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 4: Run test, expect pass**

```bash
flutter test test/onboarding/screens/processing_screen_test.dart
```
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add lib/onboarding/screens/processing_screen.dart test/onboarding/screens/processing_screen_test.dart
git commit -m "feat(onboarding): screen 7 processing pause"
```

---

## Task 18: Mini-puzzle data + models

**Files:**
- Create: `flutter_app/lib/game/models/puzzle_category.dart`
- Create: `flutter_app/lib/game/models/puzzle_tile.dart`
- Create: `flutter_app/lib/game/mini_puzzle_data.dart`

- [ ] **Step 1: Implement models**

Create `flutter_app/lib/game/models/puzzle_category.dart`:

```dart
import 'package:flutter/material.dart';

class PuzzleCategory {
  final String id;
  final String label;
  final String etymology;
  final Color color;
  final List<String> tiles;

  const PuzzleCategory({
    required this.id,
    required this.label,
    required this.etymology,
    required this.color,
    required this.tiles,
  });
}
```

Create `flutter_app/lib/game/models/puzzle_tile.dart`:

```dart
class PuzzleTile {
  final String word;
  final String categoryId;
  const PuzzleTile({required this.word, required this.categoryId});
}
```

- [ ] **Step 2: Implement mini-puzzle data**

Create `flutter_app/lib/game/mini_puzzle_data.dart`:

```dart
import '../theme/app_colors.dart' show AppColors;
import 'models/puzzle_category.dart';
import 'models/puzzle_tile.dart';

final miniCategories = <PuzzleCategory>[
  PuzzleCategory(
    id: 'minced',
    label: 'Minced oaths',
    etymology:
        'Substitutes that dodged the swear-jar. "Gosh", "blimey", "crikey" — '
        'softened versions invented to dance around taboo words.',
    color: AppColors.secondaryContainer,
    tiles: ['Gosh', 'Blimey', 'Crikey', 'Heck'],
  ),
  PuzzleCategory(
    id: 'british',
    label: 'British classics',
    etymology:
        'Pub-tested, council-estate-approved British staples. From Old English '
        'rooted vulgarities to 19th-century slang that stuck.',
    color: AppColors.primary,
    tiles: ['Bollocks', 'Knackered', 'Naff', 'Gobsmacked'],
  ),
];

List<PuzzleTile> miniTiles() => [
      for (final c in miniCategories)
        for (final w in c.tiles) PuzzleTile(word: w, categoryId: c.id),
    ];
```

- [ ] **Step 3: Compile check**

```bash
flutter analyze lib/game/
```
Expected: no issues.

- [ ] **Step 4: Commit**

```bash
git add lib/game/models/ lib/game/mini_puzzle_data.dart
git commit -m "feat(game): mini-puzzle data — 8 tiles, 2 categories"
```

---

## Task 19: Mini-puzzle controller (logic only, TDD)

**Files:**
- Create: `flutter_app/lib/game/mini_puzzle_controller.dart`
- Test: `flutter_app/test/game/mini_puzzle_controller_test.dart`

- [ ] **Step 1: Write the failing test**

Create `flutter_app/test/game/mini_puzzle_controller_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vulgus/game/mini_puzzle_controller.dart';
import 'package:vulgus/game/mini_puzzle_data.dart';

void main() {
  test('starts with all tiles unsolved, 4 lives, 0 selected', () {
    final container = ProviderContainer();
    final s = container.read(miniPuzzleProvider);
    expect(s.tiles.length, 8);
    expect(s.lives, 4);
    expect(s.selected, isEmpty);
    expect(s.solvedCategories, isEmpty);
  });

  test('selecting up to 4 tiles works; 5th tap is ignored', () {
    final container = ProviderContainer();
    final c = container.read(miniPuzzleProvider.notifier);
    final tiles = container.read(miniPuzzleProvider).tiles;
    for (var i = 0; i < 5; i++) c.toggle(tiles[i].word);
    expect(container.read(miniPuzzleProvider).selected.length, 4);
  });

  test('submitting a correct group solves the category and clears selection', () {
    final container = ProviderContainer();
    final c = container.read(miniPuzzleProvider.notifier);
    for (final w in miniCategories[0].tiles) {
      c.toggle(w);
    }
    c.submit();
    final s = container.read(miniPuzzleProvider);
    expect(s.solvedCategories, contains(miniCategories[0].id));
    expect(s.selected, isEmpty);
    expect(s.lives, 4);
  });

  test('submitting an incorrect group costs a life and clears selection', () {
    final container = ProviderContainer();
    final c = container.read(miniPuzzleProvider.notifier);
    final tiles = container.read(miniPuzzleProvider).tiles;
    final mixed = [
      tiles.firstWhere((t) => t.categoryId == miniCategories[0].id).word,
      tiles.firstWhere((t) => t.categoryId == miniCategories[1].id).word,
      tiles
          .where((t) => t.categoryId == miniCategories[0].id)
          .elementAt(1)
          .word,
      tiles
          .where((t) => t.categoryId == miniCategories[1].id)
          .elementAt(1)
          .word,
    ];
    for (final w in mixed) c.toggle(w);
    c.submit();
    final s = container.read(miniPuzzleProvider);
    expect(s.lives, 3);
    expect(s.selected, isEmpty);
    expect(s.solvedCategories, isEmpty);
    expect(s.lastWasCorrect, false);
  });

  test('isComplete true when both categories solved', () {
    final container = ProviderContainer();
    final c = container.read(miniPuzzleProvider.notifier);
    for (final cat in miniCategories) {
      for (final w in cat.tiles) c.toggle(w);
      c.submit();
    }
    expect(container.read(miniPuzzleProvider).isComplete, isTrue);
  });
}
```

- [ ] **Step 2: Run test, expect failure**

```bash
flutter test test/game/mini_puzzle_controller_test.dart
```
Expected: FAIL — controller not found.

- [ ] **Step 3: Implement**

Create `flutter_app/lib/game/mini_puzzle_controller.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'mini_puzzle_data.dart';
import 'models/puzzle_tile.dart';

class MiniPuzzleState {
  final List<PuzzleTile> tiles;
  final Set<String> selected;
  final Set<String> solvedCategories;
  final int lives;
  final bool? lastWasCorrect;

  const MiniPuzzleState({
    required this.tiles,
    this.selected = const {},
    this.solvedCategories = const {},
    this.lives = 4,
    this.lastWasCorrect,
  });

  MiniPuzzleState copyWith({
    Set<String>? selected,
    Set<String>? solvedCategories,
    int? lives,
    bool? lastWasCorrect,
  }) =>
      MiniPuzzleState(
        tiles: tiles,
        selected: selected ?? this.selected,
        solvedCategories: solvedCategories ?? this.solvedCategories,
        lives: lives ?? this.lives,
        lastWasCorrect: lastWasCorrect,
      );

  bool get isComplete => solvedCategories.length == miniCategories.length;
  bool get isFailed => lives <= 0;
}

class MiniPuzzleController extends StateNotifier<MiniPuzzleState> {
  MiniPuzzleController() : super(MiniPuzzleState(tiles: miniTiles()));

  void toggle(String word) {
    final next = {...state.selected};
    if (next.contains(word)) {
      next.remove(word);
    } else if (next.length < 4) {
      next.add(word);
    }
    state = state.copyWith(selected: next);
  }

  void submit() {
    if (state.selected.length != 4) return;
    final picked = state.tiles.where((t) => state.selected.contains(t.word));
    final ids = picked.map((t) => t.categoryId).toSet();
    if (ids.length == 1) {
      state = state.copyWith(
        solvedCategories: {...state.solvedCategories, ids.first},
        selected: {},
        lastWasCorrect: true,
      );
    } else {
      state = state.copyWith(
        lives: state.lives - 1,
        selected: {},
        lastWasCorrect: false,
      );
    }
  }
}

final miniPuzzleProvider =
    StateNotifierProvider<MiniPuzzleController, MiniPuzzleState>(
  (ref) => MiniPuzzleController(),
);
```

- [ ] **Step 4: Run test, expect pass**

```bash
flutter test test/game/mini_puzzle_controller_test.dart
```
Expected: PASS (5 tests).

- [ ] **Step 5: Commit**

```bash
git add lib/game/mini_puzzle_controller.dart test/game/mini_puzzle_controller_test.dart
git commit -m "feat(game): mini-puzzle controller with selection, submit, lives"
```

---

## Task 20: Mini-puzzle widgets — TileGrid + EtymologyStrip

**Files:**
- Create: `flutter_app/lib/game/widgets/tile_grid.dart`
- Create: `flutter_app/lib/game/widgets/etymology_strip.dart`
- Test: `flutter_app/test/game/widgets/tile_grid_test.dart`

- [ ] **Step 1: Write the failing test**

Create `flutter_app/test/game/widgets/tile_grid_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vulgus/game/mini_puzzle_controller.dart';
import 'package:vulgus/game/widgets/tile_grid.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('renders 8 tile widgets', (tester) async {
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(
        theme: buildAppTheme(),
        home: const Scaffold(body: TileGrid()),
      ),
    ));
    expect(find.byType(InkWell), findsNWidgets(8));
  });

  testWidgets('tapping a tile selects it (visual change)', (tester) async {
    final container = ProviderContainer();
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: buildAppTheme(),
        home: const Scaffold(body: TileGrid()),
      ),
    ));
    final firstWord = container.read(miniPuzzleProvider).tiles.first.word;
    await tester.tap(find.text(firstWord));
    await tester.pump();
    expect(container.read(miniPuzzleProvider).selected, contains(firstWord));
  });
}
```

- [ ] **Step 2: Run test, expect failure**

```bash
flutter test test/game/widgets/tile_grid_test.dart
```
Expected: FAIL.

- [ ] **Step 3: Implement TileGrid**

Create `flutter_app/lib/game/widgets/tile_grid.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../mini_puzzle_controller.dart';
import '../mini_puzzle_data.dart';

class TileGrid extends ConsumerWidget {
  const TileGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(miniPuzzleProvider);
    final ctrl = ref.read(miniPuzzleProvider.notifier);
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 6,
      mainAxisSpacing: 6,
      children: [
        for (final tile in s.tiles)
          _Tile(
            word: tile.word,
            selected: s.selected.contains(tile.word),
            solved: s.solvedCategories.contains(tile.categoryId),
            color: miniCategories
                .firstWhere((c) => c.id == tile.categoryId)
                .color,
            onTap: () => ctrl.toggle(tile.word),
          ),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  final String word;
  final bool selected;
  final bool solved;
  final Color color;
  final VoidCallback onTap;
  const _Tile({
    required this.word,
    required this.selected,
    required this.solved,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = solved
        ? color
        : selected
            ? AppColors.onSurface
            : AppColors.surfaceContainerLowest;
    final fg = solved || selected ? AppColors.onPrimary : AppColors.onSurface;
    return Material(
      color: bg,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: AppColors.onSurface, width: 2),
      ),
      child: InkWell(
        onTap: solved ? null : onTap,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: FittedBox(
              child: Text(
                word.toUpperCase(),
                style: TextStyle(
                  color: fg, fontWeight: FontWeight.w800, fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 4: Implement EtymologyStrip**

Create `flutter_app/lib/game/widgets/etymology_strip.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../mini_puzzle_controller.dart';
import '../mini_puzzle_data.dart';

class EtymologyStrip extends ConsumerWidget {
  const EtymologyStrip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(miniPuzzleProvider);
    if (s.solvedCategories.isEmpty) {
      return Container(
        constraints: const BoxConstraints(minHeight: 96),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          border: Border.all(color: AppColors.onSurface, width: 2),
        ),
        child: Center(
          child: Text(
            'Solve a category to reveal its etymology.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    final last = miniCategories.firstWhere((c) => c.id == s.solvedCategories.last);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: last.color,
        border: Border.all(color: AppColors.onSurface, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(last.label.toUpperCase(),
              style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 8),
          Text(last.etymology,
              style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
```

- [ ] **Step 5: Run test, expect pass**

```bash
flutter test test/game/widgets/tile_grid_test.dart
```
Expected: PASS.

- [ ] **Step 6: Commit**

```bash
git add lib/game/widgets/ test/game/widgets/
git commit -m "feat(game): tile grid + etymology strip widgets"
```

---

## Task 21: Screen 8 — Demo puzzle

**Files:**
- Modify: `flutter_app/lib/onboarding/screens/demo_puzzle_screen.dart`

- [ ] **Step 1: Implement** (no separate test — game logic already covered by Task 19)

Overwrite `flutter_app/lib/onboarding/screens/demo_puzzle_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../game/mini_puzzle_controller.dart';
import '../../game/widgets/etymology_strip.dart';
import '../../game/widgets/tile_grid.dart';
import '../../theme/app_colors.dart';
import '../widgets/primary_button.dart';
import '../widgets/progress_bar.dart';

class DemoPuzzleScreen extends ConsumerWidget {
  const DemoPuzzleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(miniPuzzleProvider);
    final ctrl = ref.read(miniPuzzleProvider.notifier);

    if (s.isComplete || s.isFailed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.go('/onboarding/share');
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingProgressBar(step: 8, total: 11),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Try a mini-puzzle.\nSort 8 words into 2 groups of 4.',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('LIVES',
                          style: Theme.of(context).textTheme.labelLarge),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          for (var i = 0; i < 4; i++)
                            Container(
                              width: 14, height: 14,
                              margin: const EdgeInsets.only(left: 4),
                              color: i < s.lives
                                  ? AppColors.onSurface
                                  : AppColors.surfaceContainerHigh,
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: TileGrid(),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: EtymologyStrip(),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(24),
              child: PrimaryButton(
                label: 'Submit',
                onPressed: s.selected.length == 4 ? ctrl.submit : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Compile check**

```bash
flutter analyze lib/onboarding/screens/demo_puzzle_screen.dart
```
Expected: no issues.

- [ ] **Step 3: Commit**

```bash
git add lib/onboarding/screens/demo_puzzle_screen.dart
git commit -m "feat(onboarding): screen 8 demo mini-puzzle"
```

---

## Task 22: Share grid widget

**Files:**
- Create: `flutter_app/lib/game/widgets/share_grid.dart`

- [ ] **Step 1: Implement**

Create `flutter_app/lib/game/widgets/share_grid.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../mini_puzzle_controller.dart';
import '../mini_puzzle_data.dart';

/// 2x4 Bauhaus shape grid summarising the player's solve.
/// Each row = one category. Filled square = correct, hollow = lost a life on it.
class ShareGrid extends ConsumerWidget {
  const ShareGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(miniPuzzleProvider);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border.all(color: AppColors.onSurface, width: 2),
      ),
      child: Column(
        children: [
          Text(
            'VULGUS · WARM-UP',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 12),
          for (final cat in miniCategories)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < 4; i++)
                    Container(
                      width: 28, height: 28,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: s.solvedCategories.contains(cat.id)
                            ? cat.color
                            : Colors.transparent,
                        border: Border.all(color: AppColors.onSurface, width: 2),
                      ),
                    ),
                ],
              ),
            ),
          const SizedBox(height: 8),
          Text(
            'Lives left: ${s.lives}/4',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add lib/game/widgets/share_grid.dart
git commit -m "feat(game): Bauhaus share grid widget"
```

---

## Task 23: Screen 9 — Share + viral moment

**Files:**
- Modify: `flutter_app/lib/onboarding/screens/share_grid_screen.dart`
- Test: `flutter_app/test/onboarding/screens/share_grid_screen_test.dart`

- [ ] **Step 1: Write the failing test**

Create `flutter_app/test/onboarding/screens/share_grid_screen_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vulgus/onboarding/screens/share_grid_screen.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('renders share grid + share + continue CTAs', (tester) async {
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(theme: buildAppTheme(), home: const ShareGridScreen()),
    ));
    expect(find.text('SHARE'), findsOneWidget);
    expect(find.text('CONTINUE'), findsOneWidget);
  });
}
```

- [ ] **Step 2: Run test, expect failure**

```bash
flutter test test/onboarding/screens/share_grid_screen_test.dart
```
Expected: FAIL.

- [ ] **Step 3: Implement**

Overwrite `flutter_app/lib/onboarding/screens/share_grid_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../game/mini_puzzle_controller.dart';
import '../../game/mini_puzzle_data.dart';
import '../../game/widgets/share_grid.dart';
import '../widgets/primary_button.dart';
import '../widgets/progress_bar.dart';

class ShareGridScreen extends ConsumerWidget {
  const ShareGridScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(miniPuzzleProvider);
    final shareText = _buildShareText(s.solvedCategories.length, s.lives);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingProgressBar(step: 9, total: 11),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      s.solvedCategories.length == miniCategories.length
                          ? 'Nice. You sorted them all.'
                          : 'Close — the real puzzles are tougher.',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    const ShareGrid(),
                    const Spacer(),
                    PrimaryButton(
                      label: 'Share',
                      onPressed: () => Clipboard.setData(
                        ClipboardData(text: shareText),
                      ),
                    ),
                    const SizedBox(height: 12),
                    PrimaryButton(
                      label: 'Continue',
                      onPressed: () => context.go('/onboarding/account'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _buildShareText(int solved, int lives) =>
      'VULGUS warm-up: $solved/${miniCategories.length} · $lives lives left\n'
      'A daily word game for the common people.\n'
      'https://vulgus.app';
}
```

- [ ] **Step 4: Run test, expect pass**

```bash
flutter test test/onboarding/screens/share_grid_screen_test.dart
```
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add lib/onboarding/screens/share_grid_screen.dart test/onboarding/screens/share_grid_screen_test.dart
git commit -m "feat(onboarding): screen 9 share grid + viral moment"
```

---

## Task 24: Stub AuthService + Screen 10 Account

**Files:**
- Create: `flutter_app/lib/auth/auth_service.dart`
- Modify: `flutter_app/lib/onboarding/screens/account_screen.dart`
- Test: `flutter_app/test/onboarding/screens/account_screen_test.dart`

- [ ] **Step 1: Implement stub auth_service.dart**

Create `flutter_app/lib/auth/auth_service.dart`:

```dart
class AuthService {
  Future<void> signInWithApple() async {
    // TODO: integrate sign_in_with_apple in follow-up plan.
    await Future<void>.delayed(const Duration(milliseconds: 400));
  }

  Future<void> signInWithGoogle() async {
    // TODO: integrate google_sign_in in follow-up plan.
    await Future<void>.delayed(const Duration(milliseconds: 400));
  }

  Future<void> signInWithEmail(String email) async {
    // TODO: integrate email magic-link in follow-up plan.
    await Future<void>.delayed(const Duration(milliseconds: 400));
  }
}
```

- [ ] **Step 2: Write the failing test**

Create `flutter_app/test/onboarding/screens/account_screen_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vulgus/onboarding/screens/account_screen.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('renders Apple, Google, email options + skip', (tester) async {
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(theme: buildAppTheme(), home: const AccountScreen()),
    ));
    expect(find.textContaining('Apple'), findsOneWidget);
    expect(find.textContaining('Google'), findsOneWidget);
    expect(find.textContaining('email'), findsOneWidget);
    expect(find.text('Skip for now'), findsOneWidget);
  });
}
```

- [ ] **Step 3: Run test, expect failure**

```bash
flutter test test/onboarding/screens/account_screen_test.dart
```
Expected: FAIL.

- [ ] **Step 4: Implement**

Overwrite `flutter_app/lib/onboarding/screens/account_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../auth/auth_service.dart';
import '../../theme/app_colors.dart';
import '../widgets/primary_button.dart';
import '../widgets/progress_bar.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = AuthService();
    Future<void> next() async => context.go('/onboarding/early-access');
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingProgressBar(step: 10, total: 11),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 24),
                    Text('Save your streak',
                        style: Theme.of(context).textTheme.headlineLarge),
                    const SizedBox(height: 8),
                    Text(
                      'Free account. Keeps your streak across devices and unlocks VULGUS+ when it launches.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Spacer(),
                    _AuthButton(
                      icon: Icons.apple,
                      label: 'Continue with Apple',
                      bg: AppColors.onSurface,
                      fg: AppColors.onPrimary,
                      onPressed: () async {
                        await auth.signInWithApple();
                        if (context.mounted) await next();
                      },
                    ),
                    const SizedBox(height: 12),
                    _AuthButton(
                      icon: Icons.g_mobiledata,
                      label: 'Continue with Google',
                      bg: AppColors.surfaceContainerLowest,
                      fg: AppColors.onSurface,
                      onPressed: () async {
                        await auth.signInWithGoogle();
                        if (context.mounted) await next();
                      },
                    ),
                    const SizedBox(height: 12),
                    _AuthButton(
                      icon: Icons.mail_outline,
                      label: 'Continue with email',
                      bg: AppColors.surfaceContainerLowest,
                      fg: AppColors.onSurface,
                      onPressed: () async {
                        await auth.signInWithEmail('placeholder@example.com');
                        if (context.mounted) await next();
                      },
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: TextButton(
                        onPressed: next,
                        child: const Text('Skip for now'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color bg;
  final Color fg;
  final VoidCallback onPressed;
  const _AuthButton({
    required this.icon,
    required this.label,
    required this.bg,
    required this.fg,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: fg),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          minimumSize: const Size.fromHeight(56),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(color: AppColors.onSurface, width: 2),
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 5: Run test, expect pass**

```bash
flutter test test/onboarding/screens/account_screen_test.dart
```
Expected: PASS.

- [ ] **Step 6: Commit**

```bash
git add lib/auth/ lib/onboarding/screens/account_screen.dart test/onboarding/screens/account_screen_test.dart
git commit -m "feat(onboarding): screen 10 account creation with stub auth"
```

---

## Task 25: Screen 11 — VULGUS+ early-access capture

**Files:**
- Modify: `flutter_app/lib/onboarding/screens/early_access_screen.dart`
- Test: `flutter_app/test/onboarding/screens/early_access_screen_test.dart`

- [ ] **Step 1: Write the failing test**

Create `flutter_app/test/onboarding/screens/early_access_screen_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vulgus/onboarding/onboarding_controller.dart';
import 'package:vulgus/onboarding/screens/early_access_screen.dart';
import 'package:vulgus/theme/app_theme.dart';

void main() {
  testWidgets('captures email and stores it on submit', (tester) async {
    final container = ProviderContainer();
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(theme: buildAppTheme(), home: const EarlyAccessScreen()),
    ));
    expect(find.textContaining('VULGUS+'), findsOneWidget);
    expect(find.textContaining('£19.99'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'test@vulgus.app');
    await tester.tap(find.text('NOTIFY ME'));
    await tester.pump();

    expect(container.read(onboardingControllerProvider).email, 'test@vulgus.app');
  });
}
```

- [ ] **Step 2: Run test, expect failure**

```bash
flutter test test/onboarding/screens/early_access_screen_test.dart
```
Expected: FAIL.

- [ ] **Step 3: Implement**

Overwrite `flutter_app/lib/onboarding/screens/early_access_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/first_launch.dart';
import '../../theme/app_colors.dart';
import '../onboarding_controller.dart';
import '../widgets/primary_button.dart';
import '../widgets/progress_bar.dart';

class EarlyAccessScreen extends ConsumerStatefulWidget {
  const EarlyAccessScreen({super.key});
  @override
  ConsumerState<EarlyAccessScreen> createState() => _EarlyAccessScreenState();
}

class _EarlyAccessScreenState extends ConsumerState<EarlyAccessScreen> {
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _finish({bool capture = true}) async {
    final ctrl = ref.read(onboardingControllerProvider.notifier);
    if (capture && _email.text.trim().isNotEmpty) {
      ctrl.setEmail(_email.text.trim());
    }
    await ctrl.persist();
    await FirstLaunchRepository().markCompleted();
    if (mounted) context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingProgressBar(step: 11, total: 11),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    Text('VULGUS+', style: t.displayMedium?.copyWith(color: AppColors.primary)),
                    const SizedBox(height: 8),
                    Text('Coming soon. Want first dibs?', style: t.headlineSmall),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryContainer,
                        border: Border.all(color: AppColors.onSurface, width: 2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _Bullet('Full archive of every past puzzle'),
                          SizedBox(height: 8),
                          _Bullet('Themed packs (Shakespearean Week, Minced Oaths…)'),
                          SizedBox(height: 8),
                          _Bullet('Stats, streak protection, deeper etymologies'),
                          SizedBox(height: 8),
                          _Bullet('Mild Mode for the family/office crowd'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLowest,
                        border: Border.all(color: AppColors.onSurface, width: 2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('PLANNED PRICING', style: t.labelLarge),
                          const SizedBox(height: 8),
                          Text('£2.99 / mo  ·  £19.99 / yr  ·  £49.99 lifetime',
                              style: t.titleLarge),
                          const SizedBox(height: 4),
                          Text('Free daily puzzle, forever. No card now.',
                              style: t.bodyMedium),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email (optional)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(color: AppColors.onSurface, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(color: AppColors.primary, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    PrimaryButton(label: 'Notify me', onPressed: () => _finish()),
                    const SizedBox(height: 12),
                    Center(
                      child: TextButton(
                        onPressed: () => _finish(capture: false),
                        child: const Text('Just take me to the puzzle'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;
  const _Bullet(this.text);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('▪️ ', style: TextStyle(fontSize: 16)),
        Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyLarge)),
      ],
    );
  }
}
```

- [ ] **Step 4: Run test, expect pass**

```bash
flutter test test/onboarding/screens/early_access_screen_test.dart
```
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add lib/onboarding/screens/early_access_screen.dart test/onboarding/screens/early_access_screen_test.dart
git commit -m "feat(onboarding): screen 11 VULGUS+ early-access capture; marks first-launch complete"
```

---

## Task 26: Full-suite verification + run-through

**Files:** none (verification + manual smoke test)

- [ ] **Step 1: Run analyzer on the whole project**

```bash
flutter analyze
```
Expected: no errors.

- [ ] **Step 2: Run all tests**

```bash
flutter test
```
Expected: all tests pass. If any fail, fix and re-run before continuing.

- [ ] **Step 3: Run the app on a device/simulator**

```bash
flutter run
```
Expected: app boots into Welcome screen on cold install.

- [ ] **Step 4: Manual smoke test — full happy path**

Walk through every screen 1 → 11. At each:
- Confirm progress bar advances
- Confirm CTA enables only when valid
- On Screen 8, solve both categories
- On Screen 9, tap Share — should copy text to clipboard (verify by pasting elsewhere)
- On Screen 11, enter an email and tap Notify me
- App lands on the Home placeholder

- [ ] **Step 5: Manual smoke test — relaunch**

Kill the app and relaunch.
Expected: app boots **straight to Home**, skipping onboarding.

- [ ] **Step 6: Manual smoke test — failure path**

Uninstall + reinstall (or clear app data). Walk through onboarding again, but on Screen 8 deliberately submit wrong groups until lives = 0. Should still advance to Screen 9 with the share grid showing 0 lives, both categories unsolved, and the "Close — the real puzzles are tougher" copy.

- [ ] **Step 7: Commit (only if any fixes were made above)**

```bash
git add -A
git commit -m "fix(onboarding): smoke-test fixes"
```

- [ ] **Step 8: Push**

```bash
git push origin HEAD
```

---

## Self-Review

**Spec coverage:**
- ✅ Welcome (#1) — Task 11
- ✅ Goal (#2) — Task 12
- ✅ Pain points (#3) — Task 13
- ✅ Tinder cards (#4) — Task 14
- ✅ Category preference (#5) — Task 15
- ✅ Notification priming (#6) — Task 16
- ✅ Processing (#7) — Task 17
- ✅ Demo mini-puzzle (#8) — Tasks 18-21
- ✅ Share + viral (#9) — Tasks 22-23
- ✅ Account (#10) — Task 24
- ✅ Early-access soft capture (#11, replaces hard paywall per pricing strategy) — Task 25
- ✅ First-launch detection — Task 4, integrated in Task 25
- ✅ Bauhaus theme — Task 3
- ✅ Persisted answers — Task 6, written in Task 25

**Type/name consistency:** `OnboardingAnswers`, `OnboardingController`, `MiniPuzzleController`, `MiniPuzzleState`, `PuzzleCategory`, `PuzzleTile`, `FirstLaunchRepository`, `NotificationService`, `AuthService`, `PrimaryButton`, `OnboardingProgressBar`, `OptionTile`, `TinderCard`, `TileGrid`, `EtymologyStrip`, `ShareGrid` — all defined and used consistently. Provider names: `firstLaunchProvider`, `onboardingControllerProvider`, `miniPuzzleProvider`. Routes: all 12 (`/home` + 11 onboarding) registered in Task 5 router and navigated to consistently.

**Skipped per user direction:** social proof, personalised solution, comparison table, mild-mode toggle.

**Out of scope (follow-up plans):**
- Full 16-tile game port from HTML prototype
- Firebase auth (replace `AuthService` stubs)
- RevenueCat paywall (separate plan, post-launch month 2-3 once archive ≥ 60 puzzles)
- Notification scheduling (`flutter_local_notifications` + 9am daily trigger)
- Mild Mode toggle
- Real testimonials
