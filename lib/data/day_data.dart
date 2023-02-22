import 'package:acme_ioet/data/schedule_data.dart';
import 'package:acme_ioet/data/split_name_and_schedule_mixin.dart';
import 'package:acme_ioet/models/day.dart';

class DayData with SplitNameAndScheduleMixin {
  List<Day> getDays(String employeeInformation) {
    ScheduleData scheduleData = ScheduleData();
    List<Day> days = [];
    try {
      List<String> employeeTimeFrames =
          splitNameAndSchedule(employeeInformation)[1].split(",");
      for (String employeeTimeFrame in employeeTimeFrames) {
        days.add(
          Day(
            name: employeeTimeFrame.substring(0, 2),
            schedule: scheduleData.getSchedule(
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
