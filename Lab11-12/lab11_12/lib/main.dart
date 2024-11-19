import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lab11_12/logic/notification_service.dart';
import 'package:lab11_12/screens/login_page.dart';
import 'package:lab11_12/screens/home_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(),
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: FirebaseAuth.instance.authStateChanges().first,
      builder: (context, snapshot) {
        // Check if the connection to Firebase has completed
        if (snapshot.connectionState == ConnectionState.done) {
          // If the user is authenticated, go to the HomePage
          if (snapshot.data != null) {
            return const HomePage();
          }
          // If the user is not authenticated, show the LoginPage
          return const LoginPage();
        }
        // While waiting for Firebase to load, show a loading indicator
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
