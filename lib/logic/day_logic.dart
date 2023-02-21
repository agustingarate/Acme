import 'package:acme_ioet/logic/schedule_logic.dart';
import 'package:acme_ioet/logic/split_name_and_schedule_mixin.dart';
import 'package:acme_ioet/models/day.dart';

class DayLogic with SplitNameAndScheduleMixin {
  List<Day> getDays(String employeeInformation) {
    ScheduleLogic scheduleLogic = ScheduleLogic();
    List<Day> days = [];
    try {
      List<String> employeeTimeFrames =
          splitNameAndSchedule(employeeInformation)[1].split(",");
      for (String employeeTimeFrame in employeeTimeFrames) {
        days.add(
          Day(
            name: employeeTimeFrame.substring(0, 2),
            schedule: scheduleLogic.getSchedule(
              employeeTimeFrame.substring(2),
            ),
          ),
        );
      }
      return days;
    } catch (e) {
      rethrow;
    }
//Eg: SA14:00-18:00
  }
}
