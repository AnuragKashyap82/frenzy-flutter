import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../animations/fade_animation.dart';
import '../widgets/reco_product_widgets.dart';

class CategoryProductScreen extends StatefulWidget {
  final String categoryName;
  const CategoryProductScreen({Key? key, required this.categoryName}) : super(key: key);

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {

  @override
  Widget build(BuildContext context) {
    int gridCount = 2;
    double gridHeight = 280;
    double size = MediaQuery.of(context).size.width;
    if(size < 600){
      setState(() {
        gridCount = 2;
        gridHeight = 200;
      });
    }else if(size > 600 && size < 1000){
      setState(() {
        gridCount = 3;
        gridHeight = 250;
      });
    }else{
      setState(() {
        gridCount = 4;
        gridHeight = 280;
      });
    }
    Widget image_carousel = Container(
        height: 220,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 220,
              viewportFraction: 1,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
            items: [
              'https://firebasestorage.googleapis.com/v0/b/frenzy-store-flutter.appspot.com/o/bannerSlider%2Fbanner3.png?alt=media&token=82da7d24-3fde-4c5e-ae5e-8ef172630251',
              'https://firebasestorage.googleapis.com/v0/b/frenzy-store-flutter.appspot.com/o/bannerSlider%2Fbanner1.jpg?alt=media&token=ca383e85-0d59-444c-b541-79ff030a2c21',
              "https://firebasestorage.googleapis.com/v0/b/frenzy-store-flutter.appspot.com/o/bannerSlider%2Fbanner2.png?alt=media&token=0f6df572-4ca5-472d-9f9c-3db54ddf30f2"
            ].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(26)),
                      child: Image.network(i, fit: BoxFit.cover));
                },
              );
            }).toList(),
          ),
        ));



    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style:
              TextStyle(fontSize: 16, color: Colors.white, letterSpacing: 0.5),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: image_carousel,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Category: ${widget.categoryName}",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("products")
                              .where("category", isEqualTo: "${widget.categoryName}")
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            }
                            return GridView.builder(
                              itemCount: snapshot.data!.docs.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              primary: false,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: gridCount, mainAxisExtent: gridHeight),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  child: FadeAnimation(
                                    1.1,
                                    RecoProductWidget(
                                      snap: snapshot.data!.docs[index].data(),
                                    ),
                                  ),
                                );
                              },
                            );
                          })
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
