import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<User?> registerUser(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await saveUserData(userCredential.user);
    return userCredential.user;
  } catch (e) {
    print('Error during registration: $e');
    return null;
  }
}

Future<void> saveUserData(User? user) async {
  if (user == null) return;

  await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
    'email': user.email,
  });
}

Future<User?> signInUser(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  } catch (e) {
    print('Error during sign-in: $e');
    return null;
  }
}
