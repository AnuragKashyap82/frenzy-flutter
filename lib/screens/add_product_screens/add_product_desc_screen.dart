import 'package:flutter/material.dart';
import 'package:frenzy_store/resources/firestore_methods.dart';
import 'package:frenzy_store/screens/add_product_screens/add_product_all_image_screen.dart';
import 'package:frenzy_store/utils/utils.dart';

import '../../animations/fade_animation.dart';

class AddProductDescriptionScreen extends StatefulWidget {
  final String productId;

  const AddProductDescriptionScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  State<AddProductDescriptionScreen> createState() =>
      _AddProductDescriptionScreenState();
}

class _AddProductDescriptionScreenState
    extends State<AddProductDescriptionScreen> {
  bool _isCOD = true;
  String layout = "Tab Layout";
  String cod = "COD available";
  bool _isLoading = false;

  TextEditingController _productTitleController = TextEditingController();
  TextEditingController _productDescriptionController = TextEditingController();
  TextEditingController _deliveryTimeController = TextEditingController();
  TextEditingController _productDetailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add a new product",
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Product Details",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black),
              ),
              SizedBox(
                height: 16,
              ),
              TextFieldWidget(
                  text: "Product title", controller: _productTitleController),
              SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                  text: "Product Description",
                  controller: _productDescriptionController),
              SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                  text: "Product will be delivered within",
                  controller: _deliveryTimeController),
              SizedBox(
                height: 8,
              ),
              Text(
                "Cash on delivery available",
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () {
                  _showCODDialog();
                },
                child: Container(
                  height: 52,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          _isCOD ? "COD Available" : "COD not available",
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Tab Layout or Details layout",
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () {
                  _showTabDialog();
                },
                child: Container(
                  height: 52,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          layout,
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                  text: "Product All Details",
                  controller: _productDetailsController),
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
                        if (_productTitleController.text.isEmpty) {
                          Utils().showSnackBar(
                              context, "Please Enter all the fields");
                        } else if (_productDescriptionController.text.isEmpty) {
                          Utils().showSnackBar(
                              context, "Please Enter all the fields");
                        } else if (_deliveryTimeController.text.isEmpty) {
                          Utils().showSnackBar(
                              context, "Please Enter all the fields");
                        } else if (_productDetailsController.text.isEmpty) {
                          Utils().showSnackBar(
                              context, "Please Enter all the fields");
                        } else {
                          setState(() {
                            _isLoading = true;
                          });
                          FireStoreMethods()
                              .uploadDescription(
                                  productId: widget.productId,
                                  allDetails: _productDetailsController.text,
                                  deliveryWithin: _deliveryTimeController.text,
                                  isCod: _isCOD,
                                  isTabSelected: false,
                                  productDescription:
                                      _productDescriptionController.text,
                                  productTitle: _productTitleController.text)
                              .then((productId) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AddProductAllImagesScreen(
                                            productId: productId)));
                            setState(() {
                              _isLoading = false;
                            });
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                      child: _isLoading
                          ? CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            )
                          : Text("Next".toLowerCase()),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _showCODDialog() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding:
                  EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Row(
                children: [
                  const Icon(
                    Icons.currency_rupee,
                    color: Colors.blue,
                  ),
                  const Text("  Is COD Available")
                ],
              ),
              content: Text(
                "Is cod available on ths product?",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _isCOD = false;
                    });
                  },
                  child: const Text(
                    "No",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
                MaterialButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    setState(() {
                      _isCOD = true;
                    });
                  },
                  child: const Text(
                    "Yes",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                )
              ],
            ));
  }

  void _showTabDialog() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding:
                  EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Row(
                children: [
                  const Icon(
                    Icons.layers_clear_outlined,
                    color: Colors.blue,
                  ),
                  const Text("  Layout Details")
                ],
              ),
              content: Text(
                "Tab layout or All Details Layouts",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      layout = "Tab Layout";
                    });
                  },
                  child: const Text(
                    "Tab",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
                MaterialButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    setState(() {
                      layout = "All Details layout";
                    });
                  },
                  child: const Text(
                    "Details",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                )
              ],
            ));
  }
}

class TextFieldWidget extends StatefulWidget {
  final String text;
  final TextEditingController controller;

  const TextFieldWidget(
      {Key? key, required this.text, required this.controller})
      : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(
            height: 6,
          ),
          TextField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            controller: widget.controller,
            style: TextStyle(fontSize: 12),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
