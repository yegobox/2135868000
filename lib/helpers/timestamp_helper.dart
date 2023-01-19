String getTimeAgo(int timestamp) {
  final difference = DateTime.now().millisecondsSinceEpoch - timestamp;

  if (difference < 60000) {
    // less than 1 minute
    final seconds = difference ~/ 1000;
    return '$seconds seconds';
  } else if (difference < 3600000) {
    // less than 1 hour
    final minutes = difference ~/ 60000;
    return '$minutes minutes';
  } else if (difference < 86400000) {
    // less than 1 day
    final hours = difference ~/ 3600000;
    return '$hours hours';
  } else {
    final days = difference ~/ 86400000;
    return '$days days';
  }
}
