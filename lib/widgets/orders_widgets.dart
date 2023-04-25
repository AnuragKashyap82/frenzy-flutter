import 'package:flutter/material.dart';

class OrderWidgets extends StatefulWidget {
  final snap;
  const OrderWidgets({Key? key,required this.snap}) : super(key: key);

  @override
  State<OrderWidgets> createState() => _OrderWidgetsState();
}

class _OrderWidgetsState extends State<OrderWidgets> {
  @override
  Widget build(BuildContext context) {
    return
      Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: PhysicalModel(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 26, right: 16, top: 26, bottom: 26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap['productTitle'],
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                color: Colors.green.shade700,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Delivered on monday 22nd Apr",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.black54,),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Image.network(
                    widget.snap['productImage'],
                    width: 40,
                    height: 60,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(Icons.arrow_forward_ios_sharp, color: Colors.black, size: 12,)
                ],
              ),
            ),
            Divider(height: 0.2, color: Colors.grey.shade400,)
          ],
        ),
      ),
    );
  }
}
