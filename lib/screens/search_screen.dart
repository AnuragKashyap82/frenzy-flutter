import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../animations/fade_animation.dart';
import '../widgets/reco_product_widgets.dart';
class SearchScreen extends StatefulWidget {
  final snap;
  const SearchScreen({Key? key, this.snap}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                onChanged: (val) {





                },
                style: TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.blue,
                  ),
                  suffixIcon: IconButton(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    icon:Icon(Icons.arrow_circle_left_outlined, size: 24,),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    color: Colors.blue,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: "Search products.....",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                      borderSide: BorderSide.none),
                ),
              ),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  width: double.infinity,
                  child:
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
