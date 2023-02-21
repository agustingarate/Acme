import 'package:acme_ioet/logic/employee_logic.dart';
import 'package:acme_ioet/models/employee.dart';
import 'package:acme_ioet/utils/utils.dart';

class MainApp {
  void myApp() async {
    EmployeeLogic employeeLogic = EmployeeLogic();
    try {
      List<String> employeesInformationList =
          await Utils.readFileByLines("lib/data/schedule_data.txt");
      List<Employee> employees =
          employeeLogic.initializePeopleMap(employeesInformationList);
      employeeLogic.printEmployeeCoincidences(employees);
    } catch (e) {
      print(e);
    }
  }
}
