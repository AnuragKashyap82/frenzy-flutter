import 'package:flutter/material.dart';

class OrderProgressBarWidget extends StatefulWidget {
  final snap;

  const OrderProgressBarWidget({Key? key, required this.snap})
      : super(key: key);

  @override
  State<OrderProgressBarWidget> createState() => _OrderProgressBarWidgetState();
}

class _OrderProgressBarWidgetState extends State<OrderProgressBarWidget> {
  bool _isOrdered = true;
  bool _isPacked = false;
  bool _isShipped = false;
  bool _isDelivered = false;
  bool _isCancelled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.snap['orderStatus'] == "ordered") {
      setState(() {
        _isOrdered = true;
      });
    } else if (widget.snap['orderStatus'] == "packed") {
      setState(() {
        _isPacked = true;
      });
    } else if (widget.snap['orderStatus'] == "shipped") {
      setState(() {
        _isPacked = true;
        _isShipped = true;
      });
    } else if (widget.snap['orderStatus'] == "delivered") {
      setState(() {
        _isPacked = true;
        _isShipped = true;
        _isDelivered = true;
      });
    } else if (widget.snap['orderStatus'] == "cancelled") {
      setState(() {
        _isCancelled = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //ordered
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
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade600),
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
          _isCancelled ? Expanded(
              child: VerticalDivider(
                thickness: 1,
                width: 2,
                color: Colors.red,
              )):
          Expanded(
              child: VerticalDivider(
            thickness: 1,
            width: 2,
            color: Colors.green.shade600,
          )),

          //packed
          _isCancelled
              ? Container()
              : Row(
                  children: [
                    PhysicalModel(
                      color: _isPacked
                          ? Colors.green.shade600
                          : Colors.grey.shade400,
                      shadowColor: _isPacked
                          ? Colors.green.shade600
                          : Colors.grey.shade400,
                      elevation: 5,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                            color: _isPacked
                                ? Colors.green.shade600
                                : Colors.grey.shade400,
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
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black87),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              _isPacked
                                  ? "${widget.snap['orderPackedDate']}   ${widget.snap['orderPackedTime']}"
                                  : "",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                        Text(
                          _isPacked
                              ? "Your Order has been packed"
                              : "Your Order is yet to be packed",
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                      ],
                    ),
                  ],
                ),
          _isCancelled ? Container():
          Expanded(
              child: VerticalDivider(
            thickness: 1,
            width: 2,
            color: _isPacked ? Colors.green.shade600 : Colors.grey.shade400,
          )),

          //shipped
          _isCancelled
              ? Container()
              : Row(
                  children: [
                    PhysicalModel(
                      color: _isShipped
                          ? Colors.green.shade600
                          : Colors.grey.shade400,
                      shadowColor: _isShipped
                          ? Colors.green.shade600
                          : Colors.grey.shade400,
                      elevation: 5,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                            color: _isShipped
                                ? Colors.green.shade600
                                : Colors.grey.shade400,
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
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black87),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              _isShipped
                                  ? "${widget.snap['orderShippedDate']}   ${widget.snap['orderShippedTime']}"
                                  : "",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                        Text(
                          _isShipped
                              ? "Your Order has been shipped"
                              : "Your Order is Yet to be shipped",
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                      ],
                    ),
                  ],
                ),
          _isCancelled ? Container():
          Expanded(
              child: VerticalDivider(
            thickness: 1,
            width: 2,
            color: _isShipped ? Colors.green.shade600 : Colors.grey.shade400,
          )),

          //Delivered
          _isCancelled
              ? Row(
                  children: [
                    PhysicalModel(
                      color: _isCancelled
                          ? Colors.green.shade600
                          : Colors.grey.shade400,
                      shadowColor: _isDelivered
                          ? Colors.green.shade600
                          : Colors.grey.shade400,
                      elevation: 5,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                            color: _isCancelled
                                ? Colors.red
                                : Colors.grey.shade400,
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
                              "Cancelled",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.red),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              _isCancelled
                                  ? "${widget.snap['orderCancelledDate']}   ${widget.snap['orderCancelledTime']}"
                                  : "",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                        Text(
                           "Your order has been Cancelled",
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                      ],
                    ),
                  ],
                )
              : Row(
                  children: [
                    PhysicalModel(
                      color: _isDelivered
                          ? Colors.green.shade600
                          : Colors.grey.shade400,
                      shadowColor: _isDelivered
                          ? Colors.green.shade600
                          : Colors.grey.shade400,
                      elevation: 5,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                            color: _isDelivered
                                ? Colors.green.shade600
                                : Colors.grey.shade400,
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
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black87),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              _isDelivered
                                  ? "${widget.snap['orderDeliveredDate']}   ${widget.snap['orderDeliveredTime']}"
                                  : "",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                        Text(
                          _isDelivered
                              ? "Your order has been delivered"
                              : "Your order is yet to be delivered",
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
