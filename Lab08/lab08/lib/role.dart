import 'package:hive/hive.dart';
part 'role.g.dart';

@HiveType(typeId: 0)
class Role {
  @HiveField(0)
  String name;

  Role(this.name);
}
