import 'package:flutter/material.dart';

class AllDetailsWidgets extends StatefulWidget {
  final snap;
  const AllDetailsWidgets({Key? key, required this.snap}) : super(key: key);

  @override
  State<AllDetailsWidgets> createState() => _AllDetailsWidgetsState();
}

class _AllDetailsWidgetsState extends State<AllDetailsWidgets> {
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.white,
      elevation: 4,
      shadowColor: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "All Detsils",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              widget.snap['allDetails'],
              style: TextStyle(fontSize: 12, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
