abstract class Worker {
  int id;
  String name;
  int age;

  Worker(this.id, this.name, this.age);

  void work();
}

class Manager extends Worker {
  String department;

  Manager(super.id, super.name, super.age, this.department);

  @override
  void work() {
    print("$name is managing the $department department.");
  }
}