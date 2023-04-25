import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_store/screens/ask_question_screen.dart';

import '../animations/fade_animation.dart';

class QuestionWidgets extends StatefulWidget {
  final snap;
  const QuestionWidgets({Key? key,required this.snap}) : super(key: key);

  @override
  State<QuestionWidgets> createState() => _QuestionWidgetsState();
}

class _QuestionWidgetsState extends State<QuestionWidgets> {
  int len = 0;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  void getProductQuesCount() async {
    final data = await firebaseFirestore
        .collection("products")
        .doc(widget.snap['productId'])
        .collection("questions")
        .get();
    List<Map<String, dynamic>?>? documentData = data.docs
        .map((e) => e.data() as Map<String, dynamic>?)
        .toList(); //working

    len = documentData.length;
    setState(() {
      len = documentData.length;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductQuesCount();
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.white,
      elevation: 4,
      shadowColor: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Questions & Answers",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AskQuestionScreen(snap: widget.snap)));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(6)),
                    child: Center(
                      child: Text(
                        "Ask Questions",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),

            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("products")
                    .doc(widget.snap['productId'])
                    .collection("questions")
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                    snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    );
                  }else{
                    return
                      ListView.builder(
                          physics:const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {},
                            child: Container(
                              child: FadeAnimation(
                                1.1,
                                AllQuestions(
                                  snap: snapshot.data!.docs[index].data(),
                                ),
                              ),
                            ),
                          ));

                  }

                }),


            SizedBox(
              height: 12,
            ),
            Divider(
              height: 0.3,
              color: Colors.grey.shade400,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
              child: Text(
                "See all $len questions",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AllQuestions extends StatefulWidget {
  final snap;
  const AllQuestions({Key? key, this.snap}) : super(key: key);

  @override
  State<AllQuestions> createState() => _AllQuestionsState();
}

class _AllQuestionsState extends State<AllQuestions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Q: ${widget.snap['question']}",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          "A: ${widget.snap['answer']}",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Anurag Kashyap to be integra",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "shop Owner",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.more_vert,
                  size: 24,
                  color: Colors.black54,
                )
              ],
            )
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Divider(
          height: 0.3,
          color: Colors.grey.shade400,
        ),
        SizedBox(
          height: 4,
        )
      ],
    );
  }
}
