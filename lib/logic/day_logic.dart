import 'package:acme_ioet/logic/schedule_logic.dart';
import 'package:acme_ioet/models/day.dart';
import 'package:acme_ioet/utils/utils.dart';

class DayLogic {
  List<Day> getDays(String employeeInformation) {
    ScheduleLogic scheduleLogic = ScheduleLogic();
    List<Day> days = [];
    try {
      List<String> employeeTimeFrames =
          Utils.splitNameAndSchedule(employeeInformation)[1].split(",");
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
