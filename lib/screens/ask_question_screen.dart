import 'package:flutter/material.dart';
import 'package:frenzy_store/resources/firestore_methods.dart';
import 'package:frenzy_store/utils/utils.dart';

import '../animations/fade_animation.dart';

class AskQuestionScreen extends StatefulWidget {
  final snap;

  const AskQuestionScreen({Key? key, this.snap}) : super(key: key);

  @override
  State<AskQuestionScreen> createState() => _AskQuestionScreenState();
}

class _AskQuestionScreenState extends State<AskQuestionScreen> {
  bool _isLoading = false;
  TextEditingController _questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Write question",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      body: Center(
        child: Container(
          width: 350,
          height: 300,
          child: Center(
            child: PhysicalModel(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(26),
              shadowColor: Colors.blue,
              elevation: 7,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  FadeAnimation(
                      1.3,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Expanded(
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 8,
                            controller: _questionController,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(fontSize: 12),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.question_mark,
                                color: Colors.blue,
                              ),
                              hintText: "Type your question",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(26),
                                  borderSide: BorderSide(color: Colors.blue)),
                            ),
                          ),
                        ),
                      )),
                  Expanded(
                    child: SizedBox(
                      height: 32,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: FadeAnimation(
                          1.5,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (_questionController.text.length < 10) {
                                    Utils().showSnackBar(context,
                                        "Enter your question - min 10 char!!!");
                                  } else {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                   await FireStoreMethods().addQuestion(
                                      productId: widget.snap['productId'],
                                      question: _questionController.text,
                                    ).then((value) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      Navigator.pop(context);
                                   });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: StadiumBorder()),
                                child: _isLoading
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      )
                                    : Text(
                                        "Submit",
                                        style: TextStyle(fontSize: 14),
                                      )),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
