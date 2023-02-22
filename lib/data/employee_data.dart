import 'dart:io';
import 'package:acme_ioet/data/day_data.dart';
import 'package:acme_ioet/data/split_name_and_schedule_mixin.dart';
import 'package:acme_ioet/models/employee.dart';

class EmployeeData with SplitNameAndScheduleMixin {
  Future<List<Employee>> initializeEmployeesList() async {
    DayData dayData = DayData();
    EmployeeData employeeData = EmployeeData();

    List<Employee> employees = [];
    List<String> employeesInformationList =
        await employeeData.readFileByLines("lib/data/schedule_data.txt");

    if (employeesInformationList.isNotEmpty) {
      for (var employeeInformation in employeesInformationList) {
        employees.add(
          Employee(
            name: getEmployeeName(employeeInformation),
            days: dayData.getDays(employeeInformation),
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

  Future<List<String>> readFileByLines(String filePath) async {
    List<String> fileLines = [];
    File file = File(filePath);
    fileLines = await file.readAsLines();
    if (fileLines.length < 5) {
      throw Exception("There are a minimun of 5 rows of data");
    } else {
      return fileLines;
    }
  }
}
