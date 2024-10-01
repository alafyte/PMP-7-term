import 'dart:convert';

import 'package:lab03/lab03.dart';

void main(List<String> arguments) async {
  var engineer = Engineer("Vlad", 28);
  engineer.develop();

  print('-----------------------');

  List<Employee> employees = [
    Employee("Anton", 35),
    Employee("Vlad", 25),
    Employee("Oleg", 30)
  ];

  employees.sort();
  for (var e in employees) {
    print("${e.name}: ${e.age}");
  }

  print('-----------------------');

  var employeesIter = EmployeeIterable([
    Employee("Anton", 35),
    Employee("Vlad", 25),
    Employee("Oleg", 30)
  ]);

  for (var employee in employeesIter) {
    print("${employee.name}: ${employee.age}");
  }

  print('-----------------------');

  var employee = Employee("Oleg", 35);

  String jsonString = jsonEncode(employee);
  print("Serialized JSON: $jsonString");

  Employee newEmployee = Employee.fromJson(jsonDecode(jsonString));
  print("Deserialized Employee: ${newEmployee.name}, ${newEmployee.age}");

  print('-----------------------');

  print("Fetching data...");
  String data = await fetchData();
  print("Data: $data");

  print('-----------------------');

  await callFuture();

  print('-----------------------');

  await callSingleSubscriptionStream();

  print('-----------------------');

  var stream = broadcastStream();

  stream.listen((event) {
    print("Listener 1: $event");
  });

  stream.listen((event) {
    print("Listener 2: $event");
  });
}
