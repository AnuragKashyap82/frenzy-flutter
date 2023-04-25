import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_store/utils/utils.dart';

import '../resources/firestore_methods.dart';

class ProductDetailsWidget extends StatefulWidget {
  final snap;

  const ProductDetailsWidget({Key? key, required this.snap}) : super(key: key);

  @override
  State<ProductDetailsWidget> createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  double avgRating = 0.0;
  bool _alreadyInWishList = false;
  int len = 0;

  void checkAlreadyInWishList() async {
    await FireStoreMethods()
        .checkAlreadyInWishList(productId: widget.snap['productId'])
        .then((value) {
      if (value) {
        setState(() {
          _alreadyInWishList = true;
        });
      } else {
        setState(() {
          _alreadyInWishList = false;
        });
      }
    });
  }

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
    getProductAverageRatings();
    checkAlreadyInWishList();
  }

  @override
  Widget build(BuildContext context) {
    int discountPercent = 0;
    setState(() {
      discountPercent = int.parse(widget.snap['productCuttedPrice']) -
          int.parse(widget.snap['productPrice']);
      discountPercent = discountPercent * 100;
      discountPercent =
          discountPercent ~/ int.parse(widget.snap['productCuttedPrice']);
    });

    Widget image_carousel = Container(
        height: 320,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 320,
              viewportFraction: 1.0,
              autoPlay: false,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
            items: [
              '${widget.snap['banner1']}',
              '${widget.snap['banner2']}',
              '${widget.snap['banner3']}',
              '${widget.snap['banner4']}',
              '${widget.snap['banner5']}',
            ].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(26)),
                      child: Image.network(i, fit: BoxFit.fitWidth));
                },
              );
            }).toList(),
          ),
        ));

    return PhysicalModel(
      color: Colors.white,
      elevation: 4,
      shadowColor: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              image_carousel,
              Positioned(
                top: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: FloatingActionButton(
                    onPressed: () {
                      _alreadyInWishList ? FireStoreMethods()
                          .removeFromWishList(productId: widget.snap['productId'])
                          .then((value) => {
                                setState(() {
                                  _alreadyInWishList = false;
                                })
                              }):FireStoreMethods()
                          .addToWishList(productId: widget.snap['productId'])
                          .then((value) => {
                        setState(() {
                          _alreadyInWishList = true;
                        })
                      });
                    },
                    child: Icon(
                      _alreadyInWishList
                          ? Icons.favorite
                          : Icons.favorite_border,
                      size: 24,
                      color: Colors.redAccent,
                    ),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.snap['productTitle'],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  height: 18,
                  decoration: BoxDecoration(
                      color: Colors.green.shade600,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "$avgRating",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.star,
                          size: 12,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  "( $len )",
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Rs.${widget.snap['productPrice']}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 12,
                ),
                Center(
                  child: Text(
                    "Rs.${widget.snap['productCuttedPrice']}",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey.shade500),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Center(
                    child: Text(
                  "${discountPercent}% OFF",
                  style: TextStyle(fontSize: 18, color: Colors.green),
                ))
              ],
            ),
          ),
          SizedBox(
            height: 26,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Check price after coupan redemption",
                style: TextStyle(fontSize: 12, color: Colors.green),
              ),
              Container(
                decoration: BoxDecoration(
                    border:
                        Border.all(color: Colors.green.shade600, width: 0.8),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                  child: Center(
                      child: Text(
                    "Redeem",
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
