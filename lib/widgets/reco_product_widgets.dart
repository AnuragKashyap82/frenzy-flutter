import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frenzy_store/screens/product_details_screen.dart';

class RecoProductWidget extends StatefulWidget {
  final snap;

  const RecoProductWidget({Key? key, this.snap}) : super(key: key);

  @override
  State<RecoProductWidget> createState() => _RecoProductWidget();
}

class _RecoProductWidget extends State<RecoProductWidget> {
  @override
  Widget build(BuildContext context) {
    log("Product widgets gets called");
    double size = MediaQuery.of(context).size.width;
    double width = 120;
    double height = 160;

    double imageWidth = 60;
    double imageHeight = 80;

    setState(() {
      if(size < 600){
        width = 120;
        height = 180;
        imageWidth = 100;
        imageHeight = 80;
      }else {
        width = 240;
        height = 240;

        imageWidth = 200;
        imageHeight = 140;
      }
    });
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(snap: widget.snap)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey.shade400, width: 0.5),
              color: Colors.white),
          width: width,
          height: height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Image.network(
                    widget.snap['productImage'],
                    width: imageWidth,
                    height: imageHeight,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  widget.snap['productTitle'],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    widget.snap['productDescription'],
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.green,
                        fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    "Rs.${widget.snap['productPrice']}",
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
