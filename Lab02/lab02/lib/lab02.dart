abstract class Worker {
  String name;
  int age;

  Worker(this.name, this.age);

  void work();
}

class Manager extends Worker {
  String department;

  Manager(super.name, super.age, this.department);

  @override
  void work() {
    print("$name is managing the $department department.");
  }
}

class Engineer extends Worker {
  String specialization;

  Engineer(super.name, super.age, this.specialization);

  @override
  void work() {
    print("$name is working on $specialization tasks.");
  }
}

abstract class Workable {
  void startWork();
  void stopWork();
}

class Technician implements Workable {
  String task;

  Technician(this.task);

  @override
  void startWork() {
    print("Technician started $task.");
  }

  @override
  void stopWork() {
    print("Technician stopped $task.");
  }
}

class Employee {
  String name;
  int age;

  // Sttaic поле
  static int employeeCount = 0;

  // Конструктор
  Employee(this.name, this.age) {
    employeeCount++;
  }

  // Именованный конструктор
  Employee.fromIntern(String name) : this(name, 18);

  // Getter
  String get employeeName => name;

  // Setter
  set employeeAge(int age) {
    if (age > 0) {
      this.age = age;
    }
  }

  // Static функции
  static void showEmployeeCount() {
    print("Total employees: $employeeCount");
  }

  // С именованным параметром
  void takeLeave({required int days}) {
    print("$name is taking $days days off.");
  }

  // С необязательным параметром по умолчанию
  void workOvertime([int hours = 2]) {
    print("$name is working overtime for $hours hours.");
  }

  // c параметром типа функция
  void taskAssignment(Function task) {
    print("Assigning task to $name.");
    task();
  }
}
