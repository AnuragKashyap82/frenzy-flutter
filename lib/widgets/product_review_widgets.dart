import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../animations/fade_animation.dart';
import '../screens/review_product_screen.dart';
import '../utils/utils.dart';

class ProductReviewWidget extends StatefulWidget {
  final snap;
  const ProductReviewWidget({Key? key,required this.snap}) : super(key: key);

  @override
  State<ProductReviewWidget> createState() => _ProductReviewWidgetState();
}

class _ProductReviewWidgetState extends State<ProductReviewWidget> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  double avgRating = 0.0;
  int len = 0;
  String ratingDes = "Good";

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
    if(sum! < 1){
     setState(() {
       ratingDes = "Nothing Say";
     });
    }else if(sum < 2 && sum > 1){
      setState(() {
        ratingDes = "Very Poor";
      });
    }else if(sum < 3 && sum > 2){
      setState(() {
        ratingDes = "Average";
      });
    }else if(sum < 4 && sum > 3){
      setState(() {
        ratingDes = "Good";
      });
    }else if(sum < 5 && sum > 4){
      setState(() {
        ratingDes = "Very Good";
      });
    }else if(sum == 5){
      setState(() {
        ratingDes = "Best";
      });
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
                    "Ratings & Reviews",
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
                            builder: (context) => AddReviewProductScreen(snap: widget.snap)));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(6)),
                    child: Center(
                      child: Text(
                        "Rate Now",
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
              height: 12,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  ratingDes,
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),

                Center(
                  child: SmoothStarRating(
                      allowHalfRating: false,
                      onRatingChanged: (v) {
                        setState(() {
                          avgRating = v;
                        });
                      },
                      starCount: 5,
                      rating: avgRating,
                      size: 20.0,
                      filledIconData: Icons.star_outlined,
                      halfFilledIconData: Icons.star_half,
                      color: Colors.green,
                      borderColor: Colors.green,
                      spacing: 0.0
                  ),
                ),

                Text(
                  "$len ratings\nand reviews",
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),

            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("products")
                    .doc(widget.snap['productId'])
                    .collection("ratings")
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
                                CustomersRatingsWidgets(
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
                "See all $len reviews",
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

class CustomersRatingsWidgets extends StatefulWidget {
  final snap;
  const CustomersRatingsWidgets({Key? key,required this.snap}) : super(key: key);

  @override
  State<CustomersRatingsWidgets> createState() =>
      _CustomersRatingsWidgetsState();
}

class _CustomersRatingsWidgetsState extends State<CustomersRatingsWidgets> {
  bool _isLoading = false;
  bool _isLoadingDetails = false;
  var _userData = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _isLoadingDetails = true;
    });
    loadUserDetails();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void loadUserDetails() async {
    setState(() {
      _isLoadingDetails = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.snap['uid'])
          .get();
      if (userSnap.exists) {
        setState(() {
          _userData = userSnap.data()!;
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Center(
              child: SmoothStarRating(
                  allowHalfRating: false,
                  starCount: 5,
                  rating: widget.snap['rating'],
                  size: 16.0,
                  filledIconData: Icons.star_outlined,
                  halfFilledIconData: Icons.star_half,
                  color: Colors.green,
                  borderColor: Colors.green,
                  spacing: 0.0
              ),
            ),
            SizedBox(
              width: 24,
            ),
            Text(
              "To be integrated!!!",
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          "${widget.snap['review']}",
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
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
                        "${_userData['name']}",
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
                        "${widget.snap['reviewDateTime']}",
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
