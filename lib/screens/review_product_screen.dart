import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_store/resources/firestore_methods.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../animations/fade_animation.dart';
import '../utils/utils.dart';

class AddReviewProductScreen extends StatefulWidget {
  final snap;

  const AddReviewProductScreen({Key? key, this.snap}) : super(key: key);

  @override
  State<AddReviewProductScreen> createState() => _AddReviewProductScreenState();
}

class _AddReviewProductScreenState extends State<AddReviewProductScreen> {
  bool _isLoading = false;
  bool _isLoadingDetails = false;
  var _productData = {};
  var rating = 0.0;
  TextEditingController _reviewController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _isLoadingDetails = true;
    });
    loadProductDetails();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void loadProductDetails() async {
    setState(() {
      _isLoadingDetails = true;
    });
    try {
      var productSnap = await FirebaseFirestore.instance
          .collection("products")
          .doc(widget.snap['productId'])
          .get();
      if (productSnap.exists) {
        setState(() {
          _productData = productSnap.data()!;
        });
      } else {}
      setState(() {});
    } catch (e) {
      Utils().showSnackBar(context, e.toString());
    }
    setState(() {
      _isLoadingDetails = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Review Product",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      body:

      _isLoadingDetails
          ? Center(
          child: CircularProgressIndicator(
            strokeWidth: 1,
          ))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 48,
                backgroundImage:
                NetworkImage(_productData["productImage"]),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                _productData["productTitle"],
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Rate the product",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
              ),
              SizedBox(
                height: 8,
              ),

              Center(
                child: SmoothStarRating(
                    allowHalfRating: false,
                    onRatingChanged: (v) {
                      setState(() {
                        rating = v;
                      });
                    },
                    starCount: 5,
                    rating: rating,
                    size: 40.0,
                    filledIconData: Icons.star_outlined,
                    halfFilledIconData: Icons.star_half,
                    color: Colors.green,
                    borderColor: Colors.green,
                    spacing: 0.0
                ),
              ),

              SizedBox(
                height: 8,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Write a review",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.black87),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          FadeAnimation(
                              1.3,
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0),
                                child: Expanded(
                                  child: TextField(
                                    keyboardType:
                                    TextInputType.multiline,
                                    controller: _reviewController,
                                    maxLines: 8,
                                    textInputAction:
                                    TextInputAction.done,
                                    style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration(
                                      hintText:
                                      "Share your experience of the product....",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                              color: Colors.blue)),
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (rating == 0.0) {
                          Utils().showSnackBar(
                              context, "Give rating please!!!");
                        } else if (_reviewController.text.isEmpty) {
                          Utils().showSnackBar(context, "write your review!!!");
                        } else {
                          setState(() {
                            _isLoading = true;
                          });
                          FireStoreMethods().addRatingReview(rating: rating,
                              review: _reviewController.text,
                                productId: widget.snap['productId']).then((value) {
                            Navigator.pop(context);
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder()),
                      child: _isLoading
                          ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : Text("Rate Now")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
