import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_store/screens/cart_screen.dart';
import 'package:frenzy_store/screens/my_account_screen.dart';
import 'package:frenzy_store/screens/search_screen.dart';
import '../../animations/fade_animation.dart';
import '../../utils/utils.dart';
import '../../widgets/category_widgets.dart';
import '../../widgets/product_widgets.dart';
import '../../widgets/reco_product_widgets.dart';
import '../add_category_screen.dart';
import '../category_product_screen.dart';

class WebHomeScreen extends StatefulWidget {
  const WebHomeScreen({Key? key}) : super(key: key);

  @override
  State<WebHomeScreen> createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends State<WebHomeScreen> {
  var _userData = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserDetails();
  }

  void loadUserDetails() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (userSnap.exists) {
        setState(() {
          _userData = userSnap.data()!;
        });
      } else {}
    } catch (e) {
      Utils().showSnackBar(context, e.toString());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    loadUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    bool _isLoading = false;
    final ScrollController controller = ScrollController();

    Widget image_carousel = Container(
        height: 220,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
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
              'https://mir-s3-cdn-cf.behance.net/project_modules/fs/1a7535108587025.5fc0eda181e4d.png',
              'https://mir-s3-cdn-cf.behance.net/project_modules/fs/1a7535108587025.5fc0eda181e4d.png',
              'https://mir-s3-cdn-cf.behance.net/project_modules/fs/1a7535108587025.5fc0eda181e4d.png',
            ].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)),
                      child: Image.network(i, fit: BoxFit.fitWidth));
                },
              );
            }).toList(),
          ),
        ));

    return Scaffold(
      appBar:
      AppBar(
        title: Builder(builder: (BuildContext context) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Frenzy\nStore",
                style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchScreen()));
                  },
                  child: TextField(
                    maxLines: 1,
                    enabled: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15.0),
                      /* -- Text and Icon -- */
                      hintText: "Search Products...",
                      hintStyle: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFFB3B1B1),
                      ),
                      // TextStyle
                      suffixIcon: const Icon(
                        Icons.search,
                        size: 26,
                        color: Colors.black54,
                      ),
                      // Icon
                      /* -- Border Styling -- */
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45.0),
                        borderSide: const BorderSide(
                          width: 0.8,
                          color: Color(0xFFFF0000),
                        ), // BorderSide
                      ),
                      // OutlineInputBorder
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45.0),
                        borderSide: const BorderSide(
                          width: 0.8,
                          color: Colors.white,
                        ), // BorderSide
                      ),
                      // OutlineInputBorder
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45.0),
                        borderSide: const BorderSide(
                          width: 0.8,
                          color: Colors.green,
                        ), // BorderSide
                      ), // OutlineInputBorder
                    ), // InputDecoration
                  ),
                ), // TextField
              ),
              SizedBox(
                width: 32,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> MyAccountScreen(snap: _userData)));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _userData['name'] == null
                          ? Center(
                              child: CircularProgressIndicator(
                              strokeWidth: 1,
                              color: Colors.white,
                            ))
                          : Text(
                              "${_userData['name']}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                  letterSpacing: 0.5),
                            ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 6),
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 16,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Become a seller",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 0.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "More",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 0.5),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => CartScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 6),
                        child: Icon(
                          Icons.shopping_cart,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Cart",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                            letterSpacing: 0.5),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        }),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Container(
                  height: 75,
                  width: double.infinity,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("category")
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
                        }
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            CategoryProductScreen(
                                                categoryName: snapshot.data!
                                                    .docs[index]
                                                    .data()['categoryName'])));
                                  },
                                  child: Center(
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: FadeAnimation(
                                        1.1,
                                        CategoryWidgets(
                                          snap:
                                              snapshot.data!.docs[index].data(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ));
                      }),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.black,
                      ),
                    )
                  : image_carousel,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.pink.shade100,
                ),
                height: 360,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Top Rated",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          height: 300,
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("products")
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  );
                                }
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.docs.length,
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            child: FadeAnimation(
                                              1.1,
                                              ProductWidget(
                                                snap: snapshot.data!.docs[index]
                                                    .data(),
                                              ),
                                            ),
                                          ),
                                        ));
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                height: 360,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Recently Viewed",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          height: 300,
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("products")
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  );
                                }
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.docs.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            child: FadeAnimation(
                                              1.1,
                                              RecoProductWidget(
                                                snap: snapshot.data!.docs[index]
                                                    .data(),
                                              ),
                                            ),
                                          ),
                                        ));
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.amber.shade100,
                ),
                height: 360,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "You May Like...",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          height: 300,
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("products")
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  );
                                }
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.docs.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            child: FadeAnimation(
                                              1.1,
                                              ProductWidget(
                                                snap: snapshot.data!.docs[index]
                                                    .data(),
                                              ),
                                            ),
                                          ),
                                        ));
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                height: 360,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Recomended items",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          height: 300,
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("products")
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  );
                                }
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.docs.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            child: FadeAnimation(
                                              1.1,
                                              RecoProductWidget(
                                                snap: snapshot.data!.docs[index]
                                                    .data(),
                                              ),
                                            ),
                                          ),
                                        ));
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.pink.shade100,
                    borderRadius: BorderRadius.circular(12)),
                height: 360,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Most Sold Products",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          height: 300,
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("products")
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  );
                                }
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.docs.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            child: FadeAnimation(
                                              1.1,
                                              ProductWidget(
                                                snap: snapshot.data!.docs[index]
                                                    .data(),
                                              ),
                                            ),
                                          ),
                                        ));
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(12)),
                height: 360,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "All products",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          height: 300,
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("products")
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  );
                                }
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.docs.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            child: FadeAnimation(
                                              1.1,
                                              ProductWidget(
                                                snap: snapshot.data!.docs[index]
                                                    .data(),
                                              ),
                                            ),
                                          ),
                                        ));
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              ),
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
                        "All products",
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
                                      crossAxisCount: 4, mainAxisExtent: 300),
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
      floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddCategoryScreen()));
            },
            child: Icon(Icons.add_outlined),
          )),
    );
  }

}
