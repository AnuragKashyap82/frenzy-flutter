import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_store/screens/cart_screen.dart';
import 'package:frenzy_store/screens/category_product_screen.dart';
import 'package:frenzy_store/screens/login_screen.dart';
import 'package:frenzy_store/screens/my_account_screen.dart';
import 'package:frenzy_store/screens/orders_screen.dart';
import 'package:frenzy_store/screens/search_screen.dart';
import 'package:frenzy_store/screens/wishlist_screen.dart';
import 'package:frenzy_store/utils/utils.dart';
import 'package:frenzy_store/widgets/category_widgets.dart';
import 'package:frenzy_store/widgets/reco_product_widgets.dart';
import 'package:frenzy_store/widgets/reco_recent_product_widgets.dart';

import '../animations/fade_animation.dart';
import '../widgets/product_widgets.dart';
import 'add_category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  }

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(Icons.search),
              )),
          InkWell(
              onTap: () {
                Utils().showSnackBar(context, "noti Clicked");
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(Icons.notification_important_sharp),
              )),
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const CartScreen()));
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(Icons.shopping_cart),
              )),
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: [
            DrawerHeader(
              padding:
              const EdgeInsets.only(top: 22, left: 8, right: 8, bottom: 8),
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 34,
                      backgroundImage: NetworkImage("${_userData['photoUrl']}"),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${_userData['name']}",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${_userData['email']}",
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.shopping_bag,
                  color: Colors.black87,
                ),
                title: const Text(
                  'My Frenzy',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.category,
                  color: Colors.black87,
                ),
                title: const Text(
                  'All Category',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.add_chart_sharp,
                  color: Colors.black87,
                ),
                title: const Text(
                  'Add Category',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.add_shopping_cart_outlined,
                  color: Colors.black87,
                ),
                title: const Text(
                  'Add Product',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {

                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.store_outlined,
                  color: Colors.black87,
                ),
                title: const Text(
                  'Trending Store',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.add_shopping_cart_sharp,
                  color: Colors.black87,
                ),
                title: const Text(
                  'My Products',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.account_balance_wallet,
                  color: Colors.black87,
                ),
                title: const Text(
                  'Sell on frenzy store',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.surround_sound,
                  color: Colors.black87,
                ),
                title: const Text(
                  'Refer & Earn',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.shopping_bag,
                  color: Colors.black87,
                ),
                title: const Text(
                  'My Orders',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => OrdersScreen()));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.card_giftcard,
                  color: Colors.black87,
                ),
                title: const Text(
                  'My Rewards',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.shopping_cart,
                  color: Colors.black87,
                ),
                title: const Text(
                  'My Cart',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const CartScreen()));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.favorite,
                  color: Colors.black87,
                ),
                title: const Text(
                  'My Wishlist',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const WishListScreen()));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.person,
                  color: Colors.black87,
                ),
                title: const Text(
                  'My Account',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (_) => MyAccountScreen(snap: _userData,)));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.logout,
                  color: Colors.black87,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {
                  _addChatUserDialog();
                },
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
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
                          itemBuilder: (context, index) =>
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          CategoryProductScreen(
                                              categoryName: snapshot.data!
                                                  .docs[index]
                                                  .data()['categoryName'])));
                                },
                                child: Container(
                                  child: FadeAnimation(
                                    1.1,
                                    CategoryWidgets(
                                      snap: snapshot.data!.docs[index].data(),
                                    ),
                                  ),
                                ),
                              ));
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: image_carousel,
            ),

            SizedBox(
              height: 8,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Container(
                width: double.infinity,
                color: Colors.pink.shade100,
                height: 250,
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
                        child: Container(
                          height: 180,
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
            //Grid View
            // Padding(
            //     padding: const EdgeInsets.symmetric(vertical: 0),
            //     child:
            //     Container(
            //       width: double.infinity,
            //       height: 550,
            //       color: Colors.blue.shade100,
            //       child:
            //       GridView.count(
            //         primary: false,
            //         padding: const EdgeInsets.all(20),
            //         crossAxisSpacing: 10,
            //         mainAxisSpacing: 10,
            //         crossAxisCount: 2,
            //         children: <Widget>[
            //           Container(
            //             width: double.infinity / 3,
            //             height: 250,
            //             padding: const EdgeInsets.all(8),
            //             color: Colors.teal[100],
            //             child: ProductWidget(),
            //           ),
            //           Container(
            //             width: double.infinity / 3,
            //             height: 250,
            //             padding: const EdgeInsets.all(8),
            //             color: Colors.teal[200],
            //             child: ProductWidget(),
            //           ),
            //           Container(
            //             width: double.infinity / 3,
            //             height: 250,
            //             padding: const EdgeInsets.all(8),
            //             color: Colors.teal[300],
            //             child: ProductWidget(),
            //           ),
            //           Container(
            //             width: double.infinity / 3,
            //             height: 250,
            //             padding: const EdgeInsets.all(8),
            //             color: Colors.teal[400],
            //             child: ProductWidget(),
            //           ),
            //         ],
            //       ),
            //     )
            // ),
            //
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Container(
                width: double.infinity,
                color: Colors.white,
                height: 250,
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
                          height: 180,
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
                                      strokeWidth: 1,
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
                                              RecoRecentProductWidget(
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
                color: Colors.amber.shade100,
                height: 250,
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
                          height: 180,
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
                height: 250,
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
                          height: 180,
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
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Container(
                width: double.infinity,
                color: Colors.pink.shade100,
                height: 250,
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
                          height: 180,
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("products")
                                  .orderBy('trendingCount', descending: true)
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
                color: Colors.amber.shade100,
                height: 250,
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
                          height: 180,
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
                                  crossAxisCount: 2, mainAxisExtent: 200),
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

  void _addChatUserDialog() {
    showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
              contentPadding:
              EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Row(
                children: [
                  const Icon(
                    Icons.logout,
                    color: Colors.blue,
                  ),
                  const Text("  Logout")
                ],
              ),
              content: Text(
                "Are you sure want to logout?",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
                MaterialButton(
                  onPressed: () async {
                    FirebaseAuth.instance.signOut().then((value) =>
                    {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()))
                    });
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                )
              ],
            ));
  }
}
