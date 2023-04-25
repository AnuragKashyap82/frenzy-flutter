import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../animations/fade_animation.dart';
import '../../resources/firestore_methods.dart';
import '../../utils/utils.dart';

class AddProductAllImagesScreen extends StatefulWidget {
  final String productId;

  const AddProductAllImagesScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  State<AddProductAllImagesScreen> createState() =>
      _AddProductAllImagesScreenState();
}

class _AddProductAllImagesScreenState extends State<AddProductAllImagesScreen> {
  Uint8List? banneer1;
  Uint8List? banneer2;
  Uint8List? banneer3;
  Uint8List? banneer4;
  Uint8List? banneer5;
  Uint8List? banneer6;

  String banner1Url = "";
  String banner2Url = "";
  String banner3Url = "";
  String banner4Url = "";
  String banner5Url = "";
  String banner6Url = "";

  bool _isUploading = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add a new product",
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Font View",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(26),
                ),
                child: banneer1 != null
                    ? Image.memory(banneer1!)
                    : Icon(Icons.add_a_photo_rounded),
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () async {},
                child: SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: FadeAnimation(
                      1.9,
                      ElevatedButton(
                          onPressed: () async {
                            Uint8List? temp = await Utils().pickImage();
                            if (temp != null) {
                              setState(() {
                                banneer1 = temp;
                              });
                            }
                            setState(() {
                              _isUploading = true;
                            });
                            if (banneer1 != null) {
                              FireStoreMethods()
                                  .uploadProductImage(image: banneer1!)
                                  .then((value) {
                                setState(() {
                                  banner1Url = value;
                                  _isUploading = false;
                                  Utils().showSnackBar(context, banner1Url);
                                });
                              });
                            } else {
                              Utils().showSnackBar(context, "Pick image !!!");
                            }
                          },
                          style:
                              ElevatedButton.styleFrom(shape: StadiumBorder()),
                          child: Text("Upload Photo".toLowerCase())),
                    )),
              ),
              SizedBox(
                height: 12,
              ),
              const Text(
                "Follow Image Guidelines to reduce the Quality Check faliure",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Image Guidelines",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Use clear color image with minimum resolution of 500 * 500 px.",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Check the sample to ensure provided the correct image View.",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Back View",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(26),
                ),
                child: banneer2 != null
                    ? Image.memory(banneer2!)
                    : Icon(Icons.add_a_photo_rounded),
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: FadeAnimation(
                    1.9,
                    ElevatedButton(
                        onPressed: () async {
                          Uint8List? temp = await Utils().pickImage();
                          if (temp != null) {
                            setState(() {
                              banneer2 = temp;
                            });
                          }
                          setState(() {
                            _isUploading = true;
                          });
                          if (banneer2 != null) {
                            FireStoreMethods()
                                .uploadProductImage(image: banneer2!)
                                .then((value) {
                              setState(() {
                                banner2Url = value;
                                _isUploading = false;
                                Utils().showSnackBar(context, banner2Url);
                              });
                            });
                          } else {
                            Utils().showSnackBar(context, "Pick image !!!");
                          }
                        },
                        style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                        child: Text("Upload Photo".toLowerCase())),
                  )),
              SizedBox(
                height: 12,
              ),
              const Text(
                "Follow Image Guidelines to reduce the Quality Check faliure",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Image Guidelines",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Use clear color image with minimum resolution of 500 * 500 px.",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Check the sample to ensure provided the correct image View.",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Side View",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(26),
                ),
                child: banneer3 != null
                    ? Image.memory(banneer3!)
                    : Icon(Icons.add_a_photo_rounded),
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: FadeAnimation(
                    1.9,
                    ElevatedButton(
                        onPressed: () async {
                          Uint8List? temp = await Utils().pickImage();
                          if (temp != null) {
                            setState(() {
                              banneer3 = temp;
                            });
                          }
                          setState(() {
                            _isUploading = true;
                          });
                          if (banneer3 != null) {
                            FireStoreMethods()
                                .uploadProductImage(image: banneer3!)
                                .then((value) {
                              setState(() {
                                banner3Url = value;
                                _isUploading = false;
                                Utils().showSnackBar(context, banner3Url);
                              });
                            });
                          } else {
                            Utils().showSnackBar(context, "Pick image !!!");
                          }
                        },
                        style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                        child: Text("Upload Photo".toLowerCase())),
                  )),
              SizedBox(
                height: 12,
              ),
              const Text(
                "Follow Image Guidelines to reduce the Quality Check faliure",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Image Guidelines",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Use clear color image with minimum resolution of 500 * 500 px.",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Check the sample to ensure provided the correct image View.",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Side View",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(26),
                ),
                child: banneer4 != null
                    ? Image.memory(banneer4!)
                    : Icon(Icons.add_a_photo_rounded),
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: FadeAnimation(
                    1.9,
                    ElevatedButton(
                        onPressed: () async {
                          Uint8List? temp = await Utils().pickImage();
                          if (temp != null) {
                            setState(() {
                              banneer4 = temp;
                            });
                          }
                          setState(() {
                            _isUploading = true;
                          });
                          if (banneer4 != null) {
                            FireStoreMethods()
                                .uploadProductImage(image: banneer4!)
                                .then((value) {
                              setState(() {
                                banner4Url = value;
                                _isUploading = false;
                                Utils().showSnackBar(context, banner4Url);
                              });
                            });
                          } else {
                            Utils().showSnackBar(context, "Pick image !!!");
                          }
                        },
                        style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                        child: Text("Upload Photo".toLowerCase())),
                  )),
              SizedBox(
                height: 12,
              ),
              const Text(
                "Follow Image Guidelines to reduce the Quality Check faliure",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Image Guidelines",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Use clear color image with minimum resolution of 500 * 500 px.",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Check the sample to ensure provided the correct image View.",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "More Photos",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(26),
                ),
                child: banneer5 != null
                    ? Image.memory(banneer5!)
                    : Icon(Icons.add_a_photo_rounded),
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: FadeAnimation(
                    1.9,
                    ElevatedButton(
                        onPressed: () async {
                          Uint8List? temp = await Utils().pickImage();
                          if (temp != null) {
                            setState(() {
                              banneer5 = temp;
                            });
                          }
                          setState(() {
                            _isUploading = true;
                          });
                          if (banneer5 != null) {
                            FireStoreMethods()
                                .uploadProductImage(image: banneer5!)
                                .then((value) {
                              setState(() {
                                banner5Url = value;
                                _isUploading = false;
                                Utils().showSnackBar(context, banner5Url);
                              });
                            });
                          } else {
                            Utils().showSnackBar(context, "Pick image !!!");
                          }
                        },
                        style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                        child: Text("Upload Photo".toLowerCase())),
                  )),
              SizedBox(
                height: 12,
              ),
              const Text(
                "Follow Image Guidelines to reduce the Quality Check faliure",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Image Guidelines",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Use clear color image with minimum resolution of 500 * 500 px.",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Check the sample to ensure provided the correct image View.",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "More Photos",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(26),
                ),
                child: banneer6 != null
                    ? Image.memory(banneer6!)
                    : Icon(Icons.add_a_photo_rounded),
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: FadeAnimation(
                    1.9,
                    ElevatedButton(
                        onPressed: () async {
                          Uint8List? temp = await Utils().pickImage();
                          if (temp != null) {
                            setState(() {
                              banneer6 = temp;
                            });
                          }
                          setState(() {
                            _isUploading = true;
                          });
                          if (banneer6 != null) {
                            FireStoreMethods()
                                .uploadProductImage(image: banneer6!)
                                .then((value) {
                              setState(() {
                                banner6Url = value;
                                _isUploading = false;
                                Utils().showSnackBar(context, banner6Url);
                              });
                            });
                          } else {
                            Utils().showSnackBar(context, "Pick image !!!");
                          }
                        },
                        style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                        child: Text("Upload Photo".toLowerCase())),
                  )),
              SizedBox(
                height: 12,
              ),
              const Text(
                "Follow Image Guidelines to reduce the Quality Check faliure",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Image Guidelines",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Use clear color image with minimum resolution of 500 * 500 px.",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Check the sample to ensure provided the correct image View.",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              SizedBox(
                height: 26,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: FadeAnimation(
                    1.9,
                    ElevatedButton(
                        onPressed: () async {

                            setState(() {
                              _isLoading = true;
                            });
                            FireStoreMethods().sendForQC(
                              productId: widget.productId,
                              banner1: banner1Url,
                              banner2: banner2Url,
                              banner3: banner3Url,
                              banner4: banner4Url,
                              banner5: banner5Url,
                              banner6: banner6Url,
                            ).then((value) {
                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            });
                          },
                        style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                        child: _isLoading ? CircularProgressIndicator(strokeWidth: 2, color: Colors.white,): Text("Send to QC")),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
