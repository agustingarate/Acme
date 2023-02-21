import 'package:acme_ioet/logic/employee_logic.dart';
import 'package:acme_ioet/models/employee.dart';

class MainApp {
  void myApp() async {
    EmployeeLogic employeeLogic = EmployeeLogic();
    try {
      List<Employee> employees = await employeeLogic.initializePeopleMap();
      employeeLogic.printEmployeeCoincidences(employees);
    } catch (e) {
      print(e);
    }
  }
}
