import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_store/screens/add_address_screen.dart';
import 'package:frenzy_store/screens/orders_screen.dart';
import 'package:frenzy_store/screens/profile_screen.dart';
import 'package:frenzy_store/screens/wishlist_screen.dart';
import '../animations/fade_animation.dart';
import 'login_screen.dart';

class MyAccountScreen extends StatefulWidget {
  final snap;
  const MyAccountScreen({Key? key,required this.snap}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          shadowColor: Colors.blue,
          toolbarHeight: 48,
          title: Text(
            "My Account",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        body:
            screenSize.width > 600 ?
        SingleChildScrollView(
          child: Row(
            children: [
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width / 2,
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: PhysicalModel(
                    color: Colors.white,
                    shadowColor: Colors.blue.shade100,
                    elevation: 0,
                    borderRadius: BorderRadius.circular(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 64,
                          backgroundImage:
                          NetworkImage("${widget.snap['photoUrl']}"),
                        ),
                      SizedBox(
                        height: 26,
                      ),
                      Text("${widget.snap['name']}",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.black87,
                          )),
                        SizedBox(
                          height: 8,
                        ),
                        Text("${widget.snap['email']}",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              color: Colors.black87,
                            )),
                        SizedBox(
                          height: 64,
                        ),
                        SizedBox(
                            width: 220,
                            height: 46,
                            child: FadeAnimation(
                                1.7,
                                  ElevatedButton(
                                      onPressed: () async {
                                        _addChatUserDialog();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: StadiumBorder()),
                                      child:Text("Log Out".toLowerCase())),
                                )),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hey! ${widget.snap['name']}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          )),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_)=> OrdersScreen()));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 4 - 20,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.blue, width: 0.8),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                  child: Text(
                                "Orders",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    letterSpacing: 0.5),
                              )),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_)=> WishListScreen()));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 4 - 20,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.blue, width: 0.8),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                  child: Text(
                                    "Wishlist",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        letterSpacing: 0.5),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 4 - 20,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.blue, width: 0.8),
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                                child: Text(
                                  "Coupans",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
                                )),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 4 - 20,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.blue, width: 0.8),
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                                child: Text(
                                  "Help Center",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text("Account Settings",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: Colors.black,
                          )),
                      SizedBox(
                        height: 26,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.currency_rupee, color: Colors.blue, size: 24,),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(child: Text("FrenzyStore Pay Later", style: TextStyle(color: Colors.black87, letterSpacing: 0.2, fontSize: 12),)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(Icons.arrow_forward_outlined, color: Colors.blue, size: 16,),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 26,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=> ProfileScreen()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.person, color: Colors.blue, size: 24,),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(child: Text("Edir Profile", style: TextStyle(color: Colors.black87, letterSpacing: 0.2, fontSize: 12),)),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Icon(Icons.arrow_forward_outlined, color: Colors.blue, size: 16,),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 26,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.monetization_on, color: Colors.blue, size: 24,),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(child: Text("Saved Cards & Wallets", style: TextStyle(color: Colors.black87, letterSpacing: 0.2, fontSize: 12),)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(Icons.arrow_forward_outlined, color: Colors.blue, size: 16,),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 26,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=> AddAddressScreen()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.add_location_alt, color: Colors.blue, size: 24,),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(child: Text("Saved Address", style: TextStyle(color: Colors.black87, letterSpacing: 0.2, fontSize: 12),)),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Icon(Icons.arrow_forward_outlined, color: Colors.blue, size: 16,),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 26,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.notification_important_sharp, color: Colors.blue, size: 24,),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(child: Text("Notifications Settings", style: TextStyle(color: Colors.black87, letterSpacing: 0.2, fontSize: 12),)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(Icons.arrow_forward_outlined, color: Colors.blue, size: 16,),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 26,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.rate_review_outlined, color: Colors.blue, size: 24,),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(child: Text("My Reviews", style: TextStyle(color: Colors.black87, letterSpacing: 0.2, fontSize: 12),)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(Icons.arrow_forward_outlined, color: Colors.blue, size: 16,),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 26,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.question_answer_outlined, color: Colors.blue, size: 24,),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(child: Text("My Questions & Answer", style: TextStyle(color: Colors.black87, letterSpacing: 0.2, fontSize: 12),)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(Icons.arrow_forward_outlined, color: Colors.blue, size: 16,),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 26,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.surround_sound, color: Colors.blue, size: 24,),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(child: Text("Refer & Earn", style: TextStyle(color: Colors.black87, letterSpacing: 0.2, fontSize: 12),)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(Icons.arrow_forward_outlined, color: Colors.blue, size: 16,),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 26,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.branding_watermark_sharp, color: Colors.blue, size: 24,),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(child: Text("Terms, Policy & Licences", style: TextStyle(color: Colors.black87, letterSpacing: 0.2, fontSize: 12),)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(Icons.arrow_forward_outlined, color: Colors.blue, size: 16,),
                          ),
                         SizedBox(
                           height: 26,
                         )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ) :
            SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hey! ${widget.snap['name']}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          )),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_)=> OrdersScreen()));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2 - 20,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.blue, width: 0.8),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                  child: Text(
                                    "Orders",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        letterSpacing: 0.5),
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_)=> WishListScreen()));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2 - 20,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.blue, width: 0.8),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                  child: Text(
                                    "Wishlist",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        letterSpacing: 0.5),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2 - 20,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.blue, width: 0.8),
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                                child: Text(
                                  "Coupans",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
                                )),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2 - 20,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.blue, width: 0.8),
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                                child: Text(
                                  "Help Center",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      letterSpacing: 0.5),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text("Account Settings",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: Colors.black,
                          )),
                      SizedBox(
                        height: 26,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.currency_rupee, color: Colors.blue, size: 24,),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(child: Text("FrenzyStore Pay Later", style: TextStyle(color: Colors.black87, letterSpacing: 0.2, fontSize: 12),)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(Icons.arrow_forward_outlined, color: Colors.blue, size: 16,),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 26,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=> ProfileScreen()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.person, color: Colors.blue, size: 24,),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(child: Text("Edir Profile", style: TextStyle(color: Colors.black87, letterSpacing: 0.2, fontSize: 12),)),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Icon(Icons.arrow_forward_outlined, color: Colors.blue, size: 16,),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 26,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.monetization_on, color: Colors.blue, size: 24,),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(child: Text("Saved Cards & Wallets", style: TextStyle(color: Colors.black87, letterSpacing: 0.2, fontSize: 12),)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(Icons.arrow_forward_outlined, color: Colors.blue, size: 16,),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 26,
                      ),
                      InkWell(

                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=> AddAddressScreen()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.add_location_alt, color: Colors.blue, size: 24,),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(child: Text("Saved Address", style: TextStyle(color: Colors.black87, letterSpacing: 0.2, fontSize: 12),)),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Icon(Icons.arrow_forward_outlined, color: Colors.blue, size: 16,),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 26,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.notification_important_sharp, color: Colors.blue, size: 24,),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(child: Text("Notifications Settings", style: TextStyle(color: Colors.black87, letterSpacing: 0.2, fontSize: 12),)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(Icons.arrow_forward_outlined, color: Colors.blue, size: 16,),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 26,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.rate_review_outlined, color: Colors.blue, size: 24,),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(child: Text("My Reviews", style: TextStyle(color: Colors.black87, letterSpacing: 0.2, fontSize: 12),)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(Icons.arrow_forward_outlined, color: Colors.blue, size: 16,),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 26,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.question_answer_outlined, color: Colors.blue, size: 24,),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(child: Text("My Questions & Answer", style: TextStyle(color: Colors.black87, letterSpacing: 0.2, fontSize: 12),)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(Icons.arrow_forward_outlined, color: Colors.blue, size: 16,),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 26,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.surround_sound, color: Colors.blue, size: 24,),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(child: Text("Refer & Earn", style: TextStyle(color: Colors.black87, letterSpacing: 0.2, fontSize: 12),)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(Icons.arrow_forward_outlined, color: Colors.blue, size: 16,),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 26,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.branding_watermark_sharp, color: Colors.blue, size: 24,),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(child: Text("Terms, Policy & Licences", style: TextStyle(color: Colors.black87, letterSpacing: 0.2, fontSize: 12),)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(Icons.arrow_forward_outlined, color: Colors.blue, size: 16,),
                          ),
                          SizedBox(
                            height: 26,
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 26,
                      ),
                      SizedBox(
                          width: double.infinity,
                          height: 46,
                          child: FadeAnimation(
                            1.7,
                            ElevatedButton(
                                onPressed: () async {
                                  _addChatUserDialog();
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: StadiumBorder()),
                                child:Text("Log Out".toLowerCase())),
                          )),
                      SizedBox(
                        height: 26,
                      )
                    ],
                  ),
                ),
              ),
            )
    );
  }
  void _addChatUserDialog() {
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
                FirebaseAuth.instance.signOut().then((value) => {
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
