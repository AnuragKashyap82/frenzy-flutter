import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_store/resources/firestore_methods.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../utils/utils.dart';

class WishListWidget extends StatefulWidget {
  final snap;

  const WishListWidget({Key? key, required this.snap}) : super(key: key);

  @override
  State<WishListWidget> createState() => _WishListWidgetState();
}

class _WishListWidgetState extends State<WishListWidget> {
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
    setState(() {
      _isLoading = true;
    });
    loadProductDetails();
    getProductAverageRatings();
  }

  void loadProductDetails() async {
    try {
      var productSnap = await FirebaseFirestore.instance
          .collection("products")
          .doc(widget.snap['productId'])
          .get();
      if (productSnap.exists) {
        setState(() {
          _productData = productSnap.data()!;

          _isLoading = false;

          discountPercent = int.parse(_productData['productCuttedPrice']) -
              int.parse(_productData['productPrice']);
          discountPercent = discountPercent * 100;
          discountPercent =
              discountPercent ~/ int.parse(_productData['productCuttedPrice']);
        });
      } else {}
    } catch (e) {
      Utils().showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator(strokeWidth: 1,))
        :
    Padding(
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
                          child: Container(
                            height: 181,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 16),
                                  child: Text(
                                    _productData['productTitle'],
                                    style: TextStyle(
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
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
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
                                      SizedBox(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Rs.${_productData['productPrice']}",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.grey),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        "Rs.${_productData['productCuttedPrice']}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        "${discountPercent}% OFF",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
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
                                 _productData['isCod'] ? "COD Not Available" : "COD Available",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, top: 8, bottom: 0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Delivery charges Rs.${_productData['deliveryFee']}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black87),
                                        ),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            FireStoreMethods()
                                                .removeFromWishList(
                                                    productId: widget
                                                        .snap['productId'])
                                                .then((value) {});
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            size: 24,
                                            color: Colors.black,
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  )
                ],
              ),
            ),
          );
  }
}
