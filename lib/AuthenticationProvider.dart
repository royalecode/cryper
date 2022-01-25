import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationProvider{

  final FirebaseAuth firebaseAuth;
  // FirebaseAuth instance

  AuthenticationProvider(this.firebaseAuth);
  //Constructor to initialize the Firebase Auth instance.

  Stream<User?> get authState => firebaseAuth.idTokenChanges();

}