

class Stats{
  String _difficulty;
  int _dailyDistance;
  Duration _avgDuration;
  int days;
  Stats(this.days){
    if(days >= 16){
      this._difficulty = "Easy";
      this._dailyDistance = 611;
      this._avgDuration = Duration(hours: 2,minutes: 51);
    } else if(days >=10){
      this._difficulty = "Intermediate";
      this._dailyDistance = 978;
      this._avgDuration = Duration(hours: 4,minutes: 34);
    } else {
      this._difficulty = "Hard";
      this._dailyDistance = 2445;
      this._avgDuration = Duration(hours: 11,minutes: 25);
    }
  }

  String get difficulty => _difficulty;
  int get distance => _dailyDistance;
  Duration get duration => _avgDuration;

}