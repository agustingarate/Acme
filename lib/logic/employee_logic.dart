import 'package:acme_ioet/data/employee_data.dart';
import 'package:acme_ioet/logic/day_logic.dart';
import 'package:acme_ioet/logic/split_name_and_schedule_mixin.dart';
import 'package:acme_ioet/models/employee.dart';
import 'package:acme_ioet/models/day.dart';

class EmployeeLogic with SplitNameAndScheduleMixin {
  Future<List<Employee>> initializeEmployeesList() async {
    DayLogic dayLogic = DayLogic();
    EmployeeData employeeData = EmployeeData();

    List<Employee> employees = [];
    List<String> employeesInformationList =
        await employeeData.readFileByLines("lib/data/schedule_data.txt");

    if (employeesInformationList.isNotEmpty) {
      for (var employeeInformation in employeesInformationList) {
        employees.add(
          Employee(
            name: getEmployeeName(employeeInformation),
            days: dayLogic.getDays(employeeInformation),
          ),
        );
      }
      return employees;
    } else {
      throw Exception("Employees Information List is empty");
    }
  }

  String getEmployeeName(String employeeInformation) {
    return splitNameAndSchedule(employeeInformation)[0];
  }

  void printEmployeeCoincidences(List<Employee> employees) {
    for (int i = 0; i < employees.length; i++) {
      for (int j = i + 1; j < employees.length; j++) {
        int coincidences = 0;
        for (var firstEmployeeDay in employees[i].days) {
          if (employees[j].days.any(
                (secondEmployeeDay) => validateEmployeesIntervals(
                    firstEmployeeDay, secondEmployeeDay),
              )) {
            coincidences++;
          }
        }
        print("${employees[i].name} - ${employees[j].name}: $coincidences");
      }
    }
  }

  bool validateEmployeesIntervals(Day firstEmployeeDay, Day secondEmployeeDay) {
    return firstEmployeeDay.name == secondEmployeeDay.name &&
        ((firstEmployeeDay.schedule.arrival <=
                    secondEmployeeDay.schedule.arrival &&
                firstEmployeeDay.schedule.departure >=
                    secondEmployeeDay.schedule.departure) ||
            (firstEmployeeDay.schedule.arrival >=
                    secondEmployeeDay.schedule.arrival &&
                firstEmployeeDay.schedule.departure <=
                    secondEmployeeDay.schedule.departure));
  }
}
