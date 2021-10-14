

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   LocalUser _userFromFirebaseUser(User user) =>
//       LocalUser.fromFireBaseUser(user);

//    Stream<User?> authStateChange() => _auth.authStateChanges();

//   Future signIn(String email, String password) async {
//     UserCredential result = await _auth.signInWithEmailAndPassword(
//         email: "thind7@hotmail.com", password: "garry123");
//     User user = result.user!;
//     return user.uid;
//   }

//   //signout
//   Future signOut() async {
//     return await _auth.signOut();
//   }
// }
