import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lab11_12/screens/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    print(_auth.currentUser);
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _user?.photoURL != null
                    ? NetworkImage(_user!.photoURL!)
                    : null,
                child: _user?.photoURL == null
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Email: ${_user?.email ?? 'Not available'}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Name: ${_user?.displayName != null && _user?.displayName?.length != 0 ? _user?.displayName : 'Not available'}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _signOut,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
