import 'package:acme_ioet/data/employee_data.dart';
import 'package:acme_ioet/models/employee.dart';
import 'package:acme_ioet/models/day.dart';

class EmployeeLogic {
  Future<List<Employee>> initializeEmployeesList() async {
    EmployeeData employeeData = EmployeeData();
    return employeeData.initializeEmployeesList();
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
