import 'dart:io';

class EmployeeData {
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
