import 'package:flutter/material.dart';

class OrderProgressBarWidget extends StatefulWidget {
  final snap;
  const OrderProgressBarWidget({Key? key, required this.snap}) : super(key: key);

  @override
  State<OrderProgressBarWidget> createState() => _OrderProgressBarWidgetState();
}

class _OrderProgressBarWidgetState extends State<OrderProgressBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              PhysicalModel(
                color: Colors.green.shade600,
                shadowColor: Colors.green.shade600,
                elevation: 5,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                      color: Colors.green.shade600,
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Ordered",
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "${widget.snap['orderDate']}  ${widget.snap['orderTime']}",
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  Text(
                    "Your Order has been placed",
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ],
              ),

            ],
          ),
          Expanded(
              child: VerticalDivider(
            thickness: 1,
            width: 2,
            color: Colors.green.shade600,
          )),
          Row(
            children: [
              PhysicalModel(
                color: Colors.grey.shade400,
                shadowColor: Colors.grey.shade400,
                elevation: 5,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Packed",
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Apr 23, 2023 04:12 PM",
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  Text(
                    "Your Order has been packed",
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ],
              ),

            ],
          ),
          Expanded(
              child: VerticalDivider(
            thickness: 1,
                width: 2,
            color: Colors.grey.shade400,
          )),
          Row(
            children: [
              PhysicalModel(
                color: Colors.grey.shade400,
                shadowColor: Colors.grey.shade400,
                elevation: 5,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Shipped",
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Apr 23, 2023 04:12 PM",
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  Text(
                    "Your Order has been shipped",
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ],
              ),

            ],
          ),
          Expanded(
              child: VerticalDivider(
                thickness: 1,
                width: 2,
            color: Colors.grey.shade400,
          )),
          Row(
            children: [
              PhysicalModel(
                color: Colors.grey.shade400,
                shadowColor: Colors.grey.shade400,
                elevation: 5,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Delivered",
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "",
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  Text(
                    "Your order is yet to be delivered",
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ],
              ),

            ],
          ),
        ],
      ),
    );
  }
}
