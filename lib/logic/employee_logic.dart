import 'package:acme_ioet/logic/day_logic.dart';
import 'package:acme_ioet/models/employee.dart';
import 'package:acme_ioet/models/day.dart';
import 'package:acme_ioet/utils/utils.dart';

class EmployeeLogic {
  List<Employee> initializePeopleMap(List<String> employeesInformationList) {
    List<Employee> employees = [];
    DayLogic dayLogic = DayLogic();
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
    return Utils.splitNameAndSchedule(employeeInformation)[0];
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
