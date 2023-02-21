import 'package:acme_ioet/logic/schedule_logic.dart';
import 'package:acme_ioet/models/day.dart';
import 'package:acme_ioet/utils/utils.dart';

class DayLogic {
  List<Day> getDays(String employeeInformation) {
    ScheduleLogic scheduleLogic = ScheduleLogic();
    List<Day> days = [];
    List<String> employeeTimeFrames =
        splitNameAndSchedule(employeeInformation)[1]
            .split(","); //Ex: SA14:00-18:00
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
  }
}
