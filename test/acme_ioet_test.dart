import 'package:acme_ioet/logic/day_logic.dart';
import 'package:acme_ioet/logic/employee_logic.dart';
import 'package:acme_ioet/logic/schedule_logic.dart';
import 'package:acme_ioet/models/day.dart';
import 'package:acme_ioet/models/schedule.dart';
import 'package:acme_ioet/utils/utils.dart';
import 'package:test/test.dart';

void main() {
/*Test de integracion:
  1) Sistema fun
*/

/*
  splitNameAndScheduleTest
    - the employeeInformation has the correct format. X
    - the employeeInformation string hasn't an '='
    - personSchedule is equal to '='

  getEmployeeNameTest
    - the employeeInformation has the correct format. X
  
  getDaysTest
    - the employeeInformation has the correct format. X
  getScheduleTest
    - the timeFrame has the correct format.


  convertTimeToHours
    - The time string has the correct format.
  printEmployeeCoincidences
*/

  group("splitNameAndScheduleTest", () {
    test("the employeeInformation has the correct format", () {
      String employeeInformation = "LUNA=MO10:00-18:00,SA11:13-17:25";
      expect(Utils.splitNameAndSchedule(employeeInformation),
          ["LUNA", "MO10:00-18:00,SA11:13-17:25"]);
    });

    test("the employeeInformation doesn't have an =", () {
      String employeeInformation = "LUNAMO10:00-18:00,SA11:13-17:25";
      expect(() => Utils.splitNameAndSchedule(employeeInformation),
          throwsA(isA<Exception>()));
    });
  });

  group("getEmployeeNameTest", () {
    EmployeeLogic employeeLogic = EmployeeLogic();
    test("the employeeInformation has the correct format", () {
      String employeeInformation = "LUNA=MO10:00-18:00,SA11:13-17:25";
      expect(employeeLogic.getEmployeeName(employeeInformation), "LUNA");
    });
    test("the employeeInformation doesn't have an =", () {
      String employeeInformation = "LUNAMO10:00-18:00,SA11:13-17:25";
      expect(() => employeeLogic.getEmployeeName(employeeInformation),
          throwsA(isA<Exception>()));
    });
  });

  group("getDaysTest", () {
    test("the employeeInformation has the correct format", () {
      DayLogic dayLogic = DayLogic();

      String employeeInformation = "LUNA=MO10:00-18:00,SA12:00-17:30";
      List expectedDays = dayLogic.getDays(employeeInformation);
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
    ScheduleLogic scheduleLogic = ScheduleLogic();
    group("The time String has the correct format", () {
      test("Exact hour (Ex: 10:00)", () {
        expect(scheduleLogic.convertTimeToHours('10:00'), 10);
      });
      test("Midnight", () {
        expect(scheduleLogic.convertTimeToHours('00:00'), 0);
      });

      test("Half past", () {
        expect(scheduleLogic.convertTimeToHours('18:30'), 18.5);
      });
    });

    group("The time hasn't the correct format", () {
      test("doesn't have an :", () {
        expect(() => scheduleLogic.convertTimeToHours("1530"),
            throwsA(isA<Exception>()));
      });
      test("doesn't have the hours or minutes", () {
        expect(() => scheduleLogic.convertTimeToHours(":"),
            throwsA(isA<Exception>()));
      });
    });
  });
}
