import 'dart:developer';

import 'package:flutter/material.dart';

import '../screens/product_details_screen.dart';

class ProductWidget extends StatefulWidget {
  final snap;

  const ProductWidget({Key? key,required this.snap, }) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
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
        child: PhysicalModel(
          color: Colors.white,
          shadowColor: Colors.blue,
          elevation: 3,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
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
                 const SizedBox(
                    height: 6,
                  ),
                  Text(
                    widget.snap['productTitle'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                 const SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      widget.snap['productDescription'],
                      style:const TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.green,
                          fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      "Rs.${widget.snap['productPrice']}",
                      style:const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
