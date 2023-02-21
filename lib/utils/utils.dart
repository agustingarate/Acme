import 'dart:io';

class Utils {
  static List<String> splitNameAndSchedule(String employeeInformation) {
    if (employeeInformation.contains("=")) {
      return employeeInformation.split("=");
    } else {
      throw Exception("The employee information hasn't the correct format");
    }
  }

  static Future<List<String>> readFileByLines(String filePath) async {
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
