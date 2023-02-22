import 'package:acme_ioet/data/day_data.dart';
import 'package:acme_ioet/data/employee_data.dart';
import 'package:acme_ioet/data/schedule_data.dart';
import 'package:acme_ioet/data/split_name_and_schedule_mixin.dart';
import 'package:acme_ioet/models/day.dart';
import 'package:acme_ioet/models/schedule.dart';
import 'package:test/test.dart';

void main() {
  group("splitNameAndScheduleTest", () {
    SplitNameAndScheduleMixin splitNameAndScheduleMixin =
        SplitNameAndScheduleMixin();
    test("the employeeInformation has the correct format", () {
      String employeeInformation = "LUNA=MO10:00-18:00,SA11:13-17:25";
      expect(
          splitNameAndScheduleMixin.splitNameAndSchedule(employeeInformation),
          ["LUNA", "MO10:00-18:00,SA11:13-17:25"]);
    });

    test("the employeeInformation doesn't have an =", () {
      String employeeInformation = "LUNAMO10:00-18:00,SA11:13-17:25";
      expect(
          () => splitNameAndScheduleMixin
              .splitNameAndSchedule(employeeInformation),
          throwsA(isA<Exception>()));
    });
  });

  group("getEmployeeNameTest", () {
    EmployeeData employeeData = EmployeeData();
    test("the employeeInformation has the correct format", () {
      String employeeInformation = "LUNA=MO10:00-18:00,SA11:13-17:25";
      expect(employeeData.getEmployeeName(employeeInformation), "LUNA");
    });
    test("the employeeInformation doesn't have an =", () {
      String employeeInformation = "LUNAMO10:00-18:00,SA11:13-17:25";
      expect(() => employeeData.getEmployeeName(employeeInformation),
          throwsA(isA<Exception>()));
    });
  });

  group("getDaysTest", () {
    test("the employeeInformation has the correct format", () {
      DayData dayData = DayData();

      String employeeInformation = "LUNA=MO10:00-18:00,SA12:00-17:30";
      List expectedDays = dayData.getDays(employeeInformation);
      List realDays = [
        Day(
          name: "MO",
          schedule: Schedule(arrival: 10.0, departure: 18.0),
        ),
        Day(
          name: "SA",
          schedule: Schedule(arrival: 12.0, departure: 17.5),
        ),
      ];

      bool equality = expectedDays[0].name == realDays[0].name &&
          expectedDays[0].schedule.arrival == realDays[0].schedule.arrival &&
          expectedDays[0].schedule.departure ==
              realDays[0].schedule.departure &&
          expectedDays[1].name == realDays[1].name &&
          expectedDays[1].schedule.arrival == realDays[1].schedule.arrival &&
          expectedDays[1].schedule.departure == realDays[1].schedule.departure;

      expect(equality, true);
    });
  });

  group("convertTimeToHoursTest", () {
    ScheduleData scheduleData = ScheduleData();
    group("The time String has the correct format", () {
      test("Exact hour (Ex: 10:00)", () {
        expect(scheduleData.convertTimeToHours('10:00'), 10);
      });
      test("Midnight", () {
        expect(scheduleData.convertTimeToHours('00:00'), 0);
      });

      test("Half past", () {
        expect(scheduleData.convertTimeToHours('18:30'), 18.5);
      });
    });

    group("The time hasn't the correct format", () {
      test("doesn't have an :", () {
        expect(() => scheduleData.convertTimeToHours("1530"),
            throwsA(isA<Exception>()));
      });
      test("doesn't have the hours or minutes", () {
        expect(() => scheduleData.convertTimeToHours(":"),
            throwsA(isA<Exception>()));
      });
    });
  });
}
