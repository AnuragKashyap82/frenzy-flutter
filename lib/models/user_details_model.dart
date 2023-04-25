import 'package:firebase_auth/firebase_auth.dart';

class UserDetailsModel {
  final String email;
  final String name;
  final String phoneNo;
  final String photoUrl;
  final String uid;
  final String userType;

  UserDetailsModel(
      {required this.email,
        required this.name,
        required this.phoneNo,
        required this.photoUrl,
      required this.uid,
      required this.userType});

  Map<String, dynamic> getJson() => {
        'email': email,
         'name': name,
         'phoneNo': phoneNo,
         'photoUrl': photoUrl,
        'uid': uid,
        'userType': userType,
      };

  factory UserDetailsModel.getModelFromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      email: json["email"],
      name: json["name"],
      phoneNo: json["phoneNo"],
      photoUrl: json["photoUrl"],
      uid: json['uid'],
      userType: json['userType'],
    );
  }
}
