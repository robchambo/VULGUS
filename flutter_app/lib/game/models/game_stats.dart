class GameStats {
  final int gamesPlayed;
  final int gamesWon;
  final int currentStreak;
  final int maxStreak;
  final String? lastPlayedDate;

  const GameStats({
    this.gamesPlayed = 0,
    this.gamesWon = 0,
    this.currentStreak = 0,
    this.maxStreak = 0,
    this.lastPlayedDate,
  });

  double get winRate => gamesPlayed == 0 ? 0 : gamesWon / gamesPlayed;

  Map<String, dynamic> toJson() => {
        'gamesPlayed': gamesPlayed,
        'gamesWon': gamesWon,
        'currentStreak': currentStreak,
        'maxStreak': maxStreak,
        'lastPlayedDate': lastPlayedDate,
      };

  factory GameStats.fromJson(Map<String, dynamic> json) => GameStats(
        gamesPlayed: (json['gamesPlayed'] as int?) ?? 0,
        gamesWon: (json['gamesWon'] as int?) ?? 0,
        currentStreak: (json['currentStreak'] as int?) ?? 0,
        maxStreak: (json['maxStreak'] as int?) ?? 0,
        lastPlayedDate: json['lastPlayedDate'] as String?,
      );
}

class TodayResult {
  final bool won;
  final String shareGrid;
  final String shareText;
  final int guesses;
  final int mistakes;

  const TodayResult({
    required this.won,
    required this.shareGrid,
    required this.shareText,
    required this.guesses,
    required this.mistakes,
  });

  Map<String, dynamic> toJson() => {
        'won': won,
        'shareGrid': shareGrid,
        'shareText': shareText,
        'guesses': guesses,
        'mistakes': mistakes,
      };

  factory TodayResult.fromJson(Map<String, dynamic> json) => TodayResult(
        won: (json['won'] as bool?) ?? false,
        shareGrid: (json['shareGrid'] as String?) ?? '',
        shareText: (json['shareText'] as String?) ?? '',
        guesses: (json['guesses'] as int?) ?? 0,
        mistakes: (json['mistakes'] as int?) ?? 0,
      );
}
