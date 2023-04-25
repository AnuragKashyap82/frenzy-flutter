import 'dart:developer';

import 'package:flutter/material.dart';

class CategoryWidgets extends StatefulWidget {
  final snap;
  const CategoryWidgets({Key? key, required this.snap}) : super(key: key);

  @override
  State<CategoryWidgets> createState() => _CategoryWidgetsState();
}

class _CategoryWidgetsState extends State<CategoryWidgets> {
  @override
  Widget build(BuildContext context) {
    log("Category widgets gets called");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        width: 60,
        height: 60,
        child: Column(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.snap['imageUrl']),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              widget.snap['categoryName'],
              maxLines: 1,
               overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: Colors.black87),
            )
          ],
        ),
      ),
    );
  }
}
