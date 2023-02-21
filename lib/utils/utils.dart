import 'dart:io';

List<String> splitNameAndSchedule(String personSchedule) {
  return personSchedule.split("=");
}

Future<List<String>> readFileByLines(String filePath) async {
  List<String> fileLines = [];
  File file = File(filePath);
  fileLines = await file.readAsLines();
  return fileLines;
}
