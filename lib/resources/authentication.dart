import 'package:firebase_auth/firebase_auth.dart';
import 'package:frenzy_store/resources/firestore_methods.dart';

import '../models/user_details_model.dart';

class AuthenticationMethods {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> signUpUser({
    required String name,
    required String email,
    required String password,
    required String cPassword,
  }) async {
    name.trim();
    email.trim();
    password.trim();
    cPassword.trim();
    String output = "something went wrong";
    if (name != "" && email != "" && password != "" && cPassword == password) {
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        UserDetailsModel user = UserDetailsModel(
          name: name,
          email: email,
          phoneNo: "",
            photoUrl: "",
          uid: FirebaseAuth.instance.currentUser!.uid,
          userType: "users"
        );
        await FireStoreMethods().uploadUserDetailsToDb(user: user);
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else if (name.isEmpty) {
      output = "Please Enter your name";
    } else if (email.isEmpty) {
      output = "Please Enter your email";
    } else if (password.length < 8) {
      output = "Password must contains 8 characters";
    } else if (cPassword != password) {
      output = "Confirm Password doesn't match";
    }
    return output;
  }

  Future<String> signInUser(
      {required String email, required String password}) async {
    email.trim();
    password.trim();
    String output = "something went wrong";
    if (email != "" && password != "") {
      try {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else if (email.isEmpty) {
      output = "Please Enter your email";
    } else if (password.isEmpty) {
      output = "Please Enter your password";
    }
    return output;
  }
}
