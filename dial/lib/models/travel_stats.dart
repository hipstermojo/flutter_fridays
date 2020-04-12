class Stats {
  static const Duration TOTAL_DURATION = Duration(hours: 45, minutes: 42);
  static const int ASCENT = 9780;
  String _difficulty;
  int _dailyDistance;
  Duration _avgDuration;
  int days;
  Stats(this.days) {
    this._avgDuration = Duration(minutes: TOTAL_DURATION.inMinutes ~/ days);
    this._dailyDistance = (ASCENT / days).round();
    if (days >= 16) {
      this._difficulty = "Easy";
    } else if (days >= 10) {
      this._difficulty = "Intermediate";
    } else {
      this._difficulty = "Hard";
    }
  }

  String get difficulty => _difficulty;
  int get distance => _dailyDistance;
  Duration get duration => _avgDuration;
}
