import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_store/utils/utils.dart';

import '../../animations/fade_animation.dart';
import '../../widgets/category_widgets.dart';
import '../../widgets/choose_category_widgets.dart';
import 'add_product_details_screen.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String selectedCategory = "Not Yet Selected";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add a new Product",
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CupertinoSearchTextField(
                      padding: EdgeInsets.all(14),
                      style: TextStyle(fontSize: 14, letterSpacing: 0.5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue)),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Your Category",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 26),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade600)),
                      child:  Text(selectedCategory),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Alternatively choose your category from below options",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Text(
                      "All Categories",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("category")
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<
                                        QuerySnapshot<Map<String, dynamic>>>
                                    snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data!.docs.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedCategory = snapshot.data!.docs[index]['categoryName'];
                                          });
                                        },
                                        child: Container(
                                          child: FadeAnimation(
                                            1.1,
                                            ChooseCategoryWidget(
                                              snap: snapshot.data!.docs[index]
                                                  .data(),
                                            ),
                                          ),
                                        ),
                                      ));
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: double.infinity,
              height: 46,
              child: FadeAnimation(
                1.7,
                ElevatedButton(
                  onPressed: () async {
                    if(selectedCategory != "Not Yet Selected"){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => AddProductDetailsScreen(
                            selectCategory: selectedCategory,
                          )));
                    }else{
                      Utils().showSnackBar(context, "Select Your category!!!");
                    }
                  },
                  style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                  child: Text("Next".toLowerCase()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
