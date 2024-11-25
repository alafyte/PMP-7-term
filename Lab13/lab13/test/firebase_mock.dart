import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {}