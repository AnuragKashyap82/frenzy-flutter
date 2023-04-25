import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../resources/firestore_methods.dart';
import '../utils/utils.dart';

class SaveLaterWidget extends StatefulWidget {
  final snap;

  const SaveLaterWidget({Key? key, required this.snap}) : super(key: key);

  @override
  State<SaveLaterWidget> createState() => _SaveLaterWidgetState();
}

class _SaveLaterWidgetState extends State<SaveLaterWidget> {
  bool _isLoading = false;
  int discountPercent = 0;
  var _productData = {};
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  double avgRating = 0.0;
  int len = 0;

  void getProductAverageRatings() async {
    final data = await firebaseFirestore
        .collection("products")
        .doc(widget.snap['productId'])
        .collection("ratings")
        .get();
    List<Map<String, dynamic>?>? documentData = data.docs
        .map((e) => e.data() as Map<String, dynamic>?)
        .toList(); //working

    len = documentData.length;
    double? sum = 0.0;
    for (int i = 0; i < len; i++) {
      sum = (sum! + documentData[i]!['rating']) as double?;
      // print('i ' + i.toString() + ' amt: ' + sum.toString());
    }
    setState(() {
      avgRating = sum! / len as double;
      len = documentData.length;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadProductDetails();
    getProductAverageRatings();
  }

  void loadProductDetails() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var productSnap = await FirebaseFirestore.instance
          .collection("products")
          .doc(widget.snap['productId'])
          .get();
      if (productSnap.exists) {
        setState(() {
          _productData = productSnap.data()!;
          discountPercent = int.parse(_productData['productCuttedPrice']) -
              int.parse(_productData['productPrice']);
          discountPercent = discountPercent * 100;
          discountPercent =
              discountPercent ~/ int.parse(_productData['productCuttedPrice']);
          _isLoading = false;
        });
      } else {}
    } catch (e) {
      Utils().showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    log("save Later screen gets called");

    return _isLoading
        ?const Center(
            child: CircularProgressIndicator(
            strokeWidth: 1,
          ))
        : Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: PhysicalModel(
              color: Colors.white,
              shadowColor: Colors.blue,
              elevation: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 16, bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          _productData['productImage'],
                          width: 100,
                          height: 140,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 16),
                                  child: Text(
                                    _productData['productTitle'],
                                    style:const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 16),
                                  child: Text(
                                    _productData['productDescription'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: SmoothStarRating(
                                            allowHalfRating: false,
                                            onRatingChanged: (v) {
                                            },
                                            starCount: 5,
                                            rating: avgRating,
                                            size: 16.0,
                                            filledIconData: Icons.star_outlined,
                                            halfFilledIconData: Icons.star_half,
                                            color: Colors.green,
                                            borderColor: Colors.green,
                                            spacing: 0.0
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 26,
                                      ),
                                        Text(
                                        "( ${len} )",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Rs.${_productData['productPrice']}",
                                        style:const TextStyle(
                                            fontSize: 18, color: Colors.grey),
                                      ),
                                      const  SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        "Rs.${_productData['productCuttedPrice']}",
                                        style:const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const    SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        discountPercent != null
                                            ? "${discountPercent}% OFF"
                                            : "",
                                        style:const TextStyle(
                                            fontSize: 18,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const   SizedBox(
                                        width: 12,
                                      ),
                                    ],
                                  ),
                                ),
                                const  SizedBox(
                                  height: 6,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child:const Padding(
                          padding:  EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Text(
                            "Qty: 1",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      )),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey.shade400,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          FireStoreMethods()
                              .addToCart( productId: widget.snap['productId'],
                              productPrice:
                              _productData['productPrice'],
                              productCuttedPrice:
                              _productData['productCuttedPrice'],
                              quantity: "1")
                              .then((value) {
                            FireStoreMethods()
                                .removeFromSaveLater(
                                    productId: widget.snap['productId'])
                                .then((value) {

                            });
                          });
                        },
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.black87,
                              size: 24,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              'Move to Cart',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w100),
                            )
                          ],
                        ),
                      ),
                      const   SizedBox(
                          height: 40,
                          child: VerticalDivider(color: Colors.red)),
                      InkWell(
                        onTap: () {
                          FireStoreMethods()
                              .removeFromSaveLater(
                              productId: widget.snap['productId'])
                              .then((value) {
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const[
                            Icon(
                              Icons.delete,
                              color: Colors.black87,
                              size: 24,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              'Remove',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w100),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const  SizedBox(
                    height: 8,
                  )
                ],
              ),
            ),
          );
  }
}
