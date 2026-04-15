import 'dart:convert';

class OnboardingAnswers {
  final String? goal;
  final Set<String> painPoints;
  final List<bool> tinderResponses;
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
        notificationsRequested:
            notificationsRequested ?? this.notificationsRequested,
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
        categoryPreferences:
            (j['categoryPreferences'] as List).cast<String>().toSet(),
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
        goal,
        painPoints.length,
        tinderResponses.length,
        categoryPreferences.length,
        notificationsRequested,
        email,
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
