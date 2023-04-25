import 'package:flutter/material.dart';

import '../animations/fade_animation.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
              ),
              FadeAnimation(
                  1.1,
                  Container(
                      width: 280,
                      height: 280,
                      child: Icon(
                        Icons.wifi_password_outlined, size: 160,
                        color: Colors.blue,
                      ))),
              SizedBox(
                height: 8,
              ),
              FadeAnimation(
                1.2, Text(
                  "Forgot Password?",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              FadeAnimation(1.3, Text(
                  "Don't worry we just need your registered email and its done",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              FadeAnimation(
                  1.4,
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.blue,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      hintText: "Registered Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide: BorderSide.none),
                    ),
                  )),
              SizedBox(
                height: 18,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: FadeAnimation(
                    1.5,
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                        child: Text("Reset Password".toLowerCase())),
                  )),
              SizedBox(
                height: 8,
              ),
              FadeAnimation(
                1.6, Text(
                  "check your inbox after clicking reset password",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
