import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../animations/fade_animation.dart';
import '../resources/firestore_methods.dart';
import '../utils/utils.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  bool _isLoading = false;
  Uint8List? image;

  TextEditingController _categoryNameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Category",
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body:
      Center(
        child: Container(
          width: 350,
          height: 350,
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
                  FadeAnimation(
                    1.1,
                    InkWell(
                      onTap: () async {
                        Uint8List? temp = await Utils().pickImage();
                        if (temp != null) {
                          setState(() {
                            image = temp;
                          });
                        }
                      },
                      child: image != null
                          ? CircleAvatar(
                              radius: 52,
                              backgroundImage: MemoryImage(image!),
                            )
                          : const CircleAvatar(
                              radius: 52,
                              child: Icon(Icons.image_search_sharp),
                            ),
                    ),
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
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            controller: _categoryNameController,
                            style: TextStyle(fontSize: 12),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.add_shopping_cart_outlined,
                                color: Colors.blue,
                              ),
                              hintText: "Enter Category Name",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(26),
                                  borderSide: BorderSide(color: Colors.blue)),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: FadeAnimation(
                        1.5,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                if (image != null &&
                                    _categoryNameController.text.isNotEmpty) {
                                  final downloadUrl = FireStoreMethods()
                                      .uploadCategoryImage(image: image!)
                                      .then((value) {
                                    FireStoreMethods().uploadCategory(
                                        downloadUrl: value,
                                        categoryName:
                                            _categoryNameController.text);
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    _categoryNameController.text = "";
                                    image = null;
                                  });
                                }else{
                                  Utils().showSnackBar(context, "content");
                                }

                              },
                              style: ElevatedButton.styleFrom(
                                  shape: StadiumBorder()),
                              child: _isLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    )
                                  : Text("Upload Category".toLowerCase())),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
