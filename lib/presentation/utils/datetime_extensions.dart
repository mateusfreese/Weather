String formatTime(DateTime time) {
  return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
}