part of 'count_down_new_year_page.dart';

_HMS _formatDuration(Duration duration) {
  final h = duration.inHours.twoDigits();
  final m = duration.inMinutes.remainder(60).twoDigits();
  final s = duration.inSeconds.remainder(60).twoDigits();
  return _HMS(h, m, s);
}

class _HMS {
  final String hours;
  final String minutes;
  final String seconds;

  _HMS(this.hours, this.minutes, this.seconds);

  @override
  String toString() =>
      '_HMS{hours: $hours, minutes: $minutes, seconds: $seconds}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _HMS &&
          runtimeType == other.runtimeType &&
          hours == other.hours &&
          minutes == other.minutes &&
          seconds == other.seconds;

  @override
  int get hashCode => hours.hashCode ^ minutes.hashCode ^ seconds.hashCode;
}

extension _TwoDigitsNumExtension on num {
  String twoDigits() => toString().padLeft(2, '0');
}
