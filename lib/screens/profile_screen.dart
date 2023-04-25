import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_store/animations/fade_animation.dart';
import 'package:frenzy_store/resources/firestore_methods.dart';
import '../utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = false;
  bool _isLoadingDetails = false;
  Uint8List? image;
  var _userData = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _isLoadingDetails = true;
    });
    loadUserDetails();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void loadUserDetails() async {
    setState(() {
      _isLoadingDetails = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (userSnap.exists) {
        setState(() {
          _userData = userSnap.data()!;
        });
      } else {}
      setState(() {});
    } catch (e) {
      Utils().showSnackBar(context, e.toString());
    }
    setState(() {
      _isLoadingDetails = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController =
        TextEditingController(text: _userData["name"]);
    TextEditingController _emailController =
        TextEditingController(text: _userData["email"]);
    TextEditingController _phoneNoController =
        TextEditingController(text: _userData["phoneNo"]);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Profile",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        centerTitle: true,
      ),
      body: _isLoadingDetails
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.blue,
            ))
          : Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  FadeAnimation(
                    1.1,
                    GestureDetector(
                      onTap: () async {
                        Uint8List? temp = await Utils().pickImage();
                        if (temp != null) {
                          setState(() {
                            image = temp;
                          });
                          setState(() {
                            _isLoading = true;
                          });
                          final downloadUrl = FireStoreMethods()
                              .uploadImageToDatabase(
                                  image: image!, uid: _userData["uid"])
                              .then((value) {
                            FireStoreMethods()
                                .updateUserImage(downloadUrl: value);
                          });
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      child: image != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundImage: MemoryImage(image!),
                            )
                          : CircleAvatar(
                              radius: 64,
                              backgroundImage:
                                  NetworkImage(_userData["photoUrl"]),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  FadeAnimation(
                      1.2,
                      TextField(
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        controller: _nameController,
                        style: TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.blue,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          hintText: "Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(26),
                              borderSide: BorderSide.none),
                        ),
                      )),
                  SizedBox(
                    height: 8,
                  ),
                  FadeAnimation(
                      1.3,
                      TextField(
                        enabled: false,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.blue,
                          ),
                          suffixIcon: Icon(
                            Icons.verified_user,
                            color: Colors.green,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(26),
                              borderSide: BorderSide.none),
                        ),
                      )),
                  SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: FadeAnimation(
                        1.4,
                        TextField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          controller: _phoneNoController,
                          style: TextStyle(fontSize: 12),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.blue,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            hintText: "Phone No.",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(26),
                                borderSide: BorderSide.none),
                          ),
                        )),
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: FadeAnimation(
                        1.5,
                        ElevatedButton(
                            onPressed: () async {
                              if (_nameController.text.isEmpty) {
                                Utils().showSnackBar(context, "Enter Name");
                              } else if (_phoneNoController.text.isEmpty) {
                                Utils().showSnackBar(context, "Enter Phone No");
                              } else {
                                setState(() {
                                  _isLoading = true;
                                });
                                await FireStoreMethods().updateUserDetailsToDb(
                                    name: _nameController.text,
                                    phone: _phoneNoController.text);
                                setState(() {
                                  _isLoading = false;
                                });
                                Navigator.pop(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder()),
                            child: _isLoading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text("Update")),
                      )),
                ],
              ),
            ),
    );
  }
}
