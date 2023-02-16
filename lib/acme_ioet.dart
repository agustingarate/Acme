import 'dart:io';

int calculate() {
  return 6 * 7;
}

void readFileByLines() async {
  List<String> peopleSchedule = [];
  File file = File("lib/data/schedule_data.txt");
  peopleSchedule = await file.readAsLines();
  print(peopleSchedule);
}

void initializePeopleMap(List<String> peopleScheduleList) {
  Map<String, Map<String, String>> peopleMap = {};

  for (var personSchedule in peopleScheduleList) {
    String name = splitNameAndSchedule(personSchedule)[0];
    Map<String, String> schedules =
        getTimeFrames(splitNameAndSchedule(personSchedule)[1]);
    peopleMap[name] = schedules;
  }

  printEmployeeCoincidences(peopleMap);
}

List<String> splitNameAndSchedule(String personSchedule) {
  return personSchedule.split("=");
}

Map<String, String> getTimeFrames(String personSchedule) {
  List<String> timeFrames = personSchedule.split(",");
  Map<String, String> timeFramesMap = {};
  for (var x in timeFrames) {
    timeFramesMap[x.substring(0, 2)] = x.substring(2);
  }
  return timeFramesMap;
}

void printEmployeeCoincidences(Map<String, Map<String, String>> peopleMap) {
  List<String> names = peopleMap.keys.toList(); //[Agustin. Graciela, Tomas]
  for (int i = 0; i < peopleMap.keys.length; i++) {
    // < 3
    for (int j = i + 1; j < peopleMap.keys.length; j++) {
      // 3
      int coincidences = 0;
      peopleMap[names[i]]?.forEach((key, value) {
        if (peopleMap[names[j]]!.containsKey(key) &&
            peopleMap[names[j]]![key]!.contains(value) &&
            names[i] != names[j]) {
          coincidences++;
        }
      });
      print("${names[i]} - ${names[j]}: $coincidences");
    }
    names;
  }
}
