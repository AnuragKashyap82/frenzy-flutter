import 'package:flutter/material.dart';

class RewardsWidgets extends StatelessWidget {
  const RewardsWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.white,
      elevation: 4,
      shadowColor: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.card_giftcard_sharp,
                  color: Colors.black,
                  size: 16,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Title",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
              " Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,"
              " when an unknown printer took a galley of type and scrambled it to make a type "
              "specimen book. It has survived not only five centuries, but also the leap into"
              "publishing software like Aldus PageMaker including versions of Lorem Ipsum",
              style: TextStyle(fontSize: 12, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
