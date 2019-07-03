String formatTime(int time) {
  if (time <= 0) return "";

  var days = time ~/ (24 * 60 * 60);
  var hours = (time / (60 * 60) - days * 24).toInt();
  var minutes = ((time / 60) - days * 24 * 60 - hours * 60).toInt();
  var seconds =
      (time - days * 24 * 60 * 60 - hours * 60 * 60 - minutes * 60).toInt();

  var hourstr = "";
  if (hours > 9) {
    hourstr = "$hours";
  } else {
    hourstr = "0$hours";
  }

  var minutestr = "";
  if (minutes > 9) {
    minutestr = "$minutes";
  } else {
    minutestr = "0$minutes";
  }

  var secondstr = "";
  if (seconds > 9) {
    secondstr = "$seconds";
  } else {
    secondstr = "0$seconds";
  }

  return "$days天  $hourstr:$minutestr:$secondstr";
}
