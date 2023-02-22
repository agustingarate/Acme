import 'package:acme_ioet/models/schedule.dart';

class ScheduleData {
  Schedule getSchedule(String timeFrame) {
    if (timeFrame.contains("-")) {
      List<String> timeFrameSplitted = timeFrame.split("-");
      Schedule schedule = Schedule(
        arrival: convertTimeToHours(timeFrameSplitted[0]),
        departure: convertTimeToHours(timeFrameSplitted[1]),
      );
      return schedule;
    } else {
      throw Exception("The timeFrame hasn't the correct format");
    }
  }

  double convertTimeToHours(String time) {
    if (time.contains(':')) {
      List<String> timeSplitted = time.split(':');
      return int.parse(timeSplitted[0]) + int.parse(timeSplitted[1]) / 60;
    } else {
      throw Exception("The time hasn't the correct format");
    }
  }
}
