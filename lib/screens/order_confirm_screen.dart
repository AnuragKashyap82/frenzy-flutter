import 'package:flutter/material.dart';

class OrderConfirmScreen extends StatefulWidget {
  final String orderId;
  const OrderConfirmScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderConfirmScreen> createState() => _OrderConfirmScreenState();
}

class _OrderConfirmScreenState extends State<OrderConfirmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: PhysicalModel(
                color: Colors.green,
                elevation: 4,
                shadowColor: Colors.green,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(40)),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Center(
                        child: Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 24,
                    )),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Order Placed Successfully!!!",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "OrderId: ${widget.orderId}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
