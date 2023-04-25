import 'package:flutter/material.dart';

class ChooseCategoryWidget extends StatefulWidget {
  final snap;
  const ChooseCategoryWidget({Key? key, this.snap}) : super(key: key);

  @override
  State<ChooseCategoryWidget> createState() => _ChooseCategoryWidget();
}

class _ChooseCategoryWidget extends State<ChooseCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        width: double.infinity,
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                widget.snap['categoryName'],
                maxLines: 1,
                 overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
