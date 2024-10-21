import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lab08/role.dart';
import 'package:lab08/user.dart';
class UserListPage extends StatefulWidget {
  final Function(User) onUserSelected;

  UserListPage({Key? key, required this.onUserSelected}) : super(key: key); // Измените конструктор

  @override
  UserListPageState createState() => UserListPageState();
}

class UserListPageState extends State<UserListPage> {
  late Box<User> usersBox;

  @override
  void initState() {
    super.initState();
    usersBox = Hive.box<User>('users');
  }

  void _addUser() {
    var random = Random();
    int randomNumber = random.nextInt(100);
    final user = User("New User $randomNumber", Role("user"));
    usersBox.add(user);
    setState(() {});
  }

  void _deleteUser(int index) {
    usersBox.deleteAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List with Roles'),
      ),
      body: ValueListenableBuilder(
        valueListenable: usersBox.listenable(),
        builder: (context, Box<User> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text('No users available.'));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final user = box.getAt(index);
              return ListTile(
                title: Text(user!.name),
                subtitle: Text('Role: ${user.role.name}'),
                onTap: () {
                  _showUserDetails(user);
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteUser(index),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addUser,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showUserDetails(User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('User Details'),
          content: Text('Name: ${user.name}\nRole: ${user.role.name}'),
          actions: <Widget>[
            TextButton(
              child: const Text('Select User'),
              onPressed: () {
                widget.onUserSelected(user);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
