import 'package:hive/hive.dart';
import 'package:lab08/role.dart';
part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  String name;

  @HiveField(1)
  Role role;

  User(this.name, this.role);
}
