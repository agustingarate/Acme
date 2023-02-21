import 'package:acme_ioet/models/schedule.dart';

class ScheduleLogic {
  Schedule getSchedule(String timeFrame) {
    List<String> timeFrameSplitted = timeFrame.split("-");
    Schedule schedule = Schedule(
      arrival: convertTimeToHours(timeFrameSplitted[0]),
      departure: convertTimeToHours(timeFrameSplitted[1]),
    );
    return schedule;
  }

  double convertTimeToHours(String time) {
    List<String> timeSplitted = time.split(':');
    return int.parse(timeSplitted[0]) + int.parse(timeSplitted[1]) / 60;
  }
}
