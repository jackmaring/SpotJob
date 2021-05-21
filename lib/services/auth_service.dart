import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthService {
  // Sign out
  static void signOut() {
    auth.FirebaseAuth.instance.signOut();
  }

  static Future<String> signIn(String email, String password) async {
    auth.UserCredential result = await auth.FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    auth.User user = result.user;
    return user.uid;
  }

  static Future<String> signUp(String email, String password) async {
    auth.UserCredential result = await auth.FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    auth.User user = result.user;
    return user.uid;
  }
}
