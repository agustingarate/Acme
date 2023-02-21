class SplitNameAndScheduleMixin {
  List<String> splitNameAndSchedule(String employeeInformation) {
    if (employeeInformation.contains("=")) {
      return employeeInformation.split("=");
    } else {
      throw Exception("The employee information hasn't the correct format");
    }
  }
}
