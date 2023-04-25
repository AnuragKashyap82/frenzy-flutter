import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_store/resources/firestore_methods.dart';
import 'package:frenzy_store/screens/delivery_screen.dart';
import 'package:frenzy_store/screens/rewards_widgets.dart';
import 'package:frenzy_store/utils/utils.dart';
import 'package:frenzy_store/widgets/address_delivery_widget.dart';
import 'package:frenzy_store/widgets/all_details_widgets.dart';
import 'package:frenzy_store/widgets/product_details_widget.dart';
import 'package:frenzy_store/widgets/question_widget.dart';

import '../widgets/product_review_widgets.dart';

class ProductDetailsScreen extends StatefulWidget {
  final snap;

  const ProductDetailsScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  bool _alreadyInCart = false;
  bool _isLoading = false;
  bool _isStocks = false;

  void checkInStocks() async {
    if (widget.snap['noOfQuantity'] == "0" ||
        widget.snap['noOfQuantity'] == "-1" ||
        widget.snap['noOfQuantity'] == "-2" ||
        widget.snap['noOfQuantity'] == "-3") {
      setState(() {
        _isStocks = false;
      });
    } else {
      _isStocks = true;
    }
  }

  void checkAlreadyInCart() async {
    setState(() {
      _isLoading = true;
    });
    await FireStoreMethods()
        .checkAlreadyInCart(productId: widget.snap['productId'])
        .then((value) {
      if (value) {
        setState(() {
          _alreadyInCart = true;
          _isLoading = false;
        });
      } else {
        setState(() {
          _alreadyInCart = false;
          _isLoading = false;
        });
      }
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkAlreadyInCart();
    checkInStocks();
    Timer(const Duration(seconds: 15), () {
      FireStoreMethods()
          .addToRecentViewed(
        productId: widget.snap['productId'],
      )
          .then((value) {
        Utils().showSnackBar(context, "Added to recentlyViewed");
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.snap['productTitle'],
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              child: Column(
                children: [
                  ProductDetailsWidget(snap: widget.snap),
                  SizedBox(
                    height: 8,
                  ),
                  RewardsWidgets(),
                  SizedBox(
                    height: 8,
                  ),
                  AddressDeliveryWidget(snap: widget.snap),
                  SizedBox(
                    height: 8,
                  ),
                  AllDetailsWidgets(snap: widget.snap),
                  SizedBox(
                    height: 8,
                  ),
                  ProductReviewWidget(snap: widget.snap),
                  SizedBox(
                    height: 8,
                  ),
                  QuestionWidgets(snap: widget.snap),
                  SizedBox(
                    height: 60,
                  ),
                  // TabLayout()
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _isStocks
                ? Container(
                    height: 50.0,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            _alreadyInCart
                                ? await FireStoreMethods()
                                    .removeFromCart(
                                        productId: widget.snap['productId'])
                                    .then((value) {
                                    setState(() {
                                      _alreadyInCart = false;
                                      _isLoading = false;
                                    });
                                  })
                                : await FireStoreMethods()
                                    .addToCart(
                                        productId: widget.snap['productId'],
                                        productPrice:
                                            widget.snap['productPrice'],
                                        productCuttedPrice:
                                            widget.snap['productCuttedPrice'],
                                        quantity: "1")
                                    .then((value) {
                                    _showAddedToCartDialog();
                                    setState(() {
                                      _alreadyInCart = true;
                                      _isLoading = false;
                                    });
                                  });
                          },
                          child: Container(
                            height: 50,
                            width: screenSize.width / 2,
                            color: Colors.white,
                            child: Center(
                              child: _isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.blue,
                                    ))
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          _alreadyInCart
                                              ? "Remove cart"
                                              : "Add to Cart",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Icon(
                                          Icons.shopping_cart,
                                          size: 24,
                                          color: Colors.black,
                                        )
                                      ],
                                    ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => DeliveryScreen(
                                          snap: widget.snap,
                                        )));
                          },
                          child: Container(
                            height: 50,
                            width: screenSize.width / 2,
                            color: Colors.blue,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Buy Now",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    height: 50,
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        "Out of Stocks",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.redAccent,
                            letterSpacing: 0.5),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  void _showAddedToCartDialog() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              title: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.green.shade700,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 24,
                        )),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Okay! 1 item added to cart",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.snap['productTitle'],
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 42,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: Text(
                            "Done",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => DeliveryScreen(
                                        snap: widget.snap,
                                      )));
                        },
                        child: Container(
                          height: 42,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: Text(
                            "Continue",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          )),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ));
  }
}
