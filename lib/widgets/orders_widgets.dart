import 'package:flutter/material.dart';

class OrderWidgets extends StatefulWidget {
  final snap;
  const OrderWidgets({Key? key,required this.snap}) : super(key: key);

  @override
  State<OrderWidgets> createState() => _OrderWidgetsState();
}

class _OrderWidgetsState extends State<OrderWidgets> {

  bool _isOrdered = false;
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
        _isShipped = true;
      });
    } else if (widget.snap['orderStatus'] == "delivered") {
      setState(() {
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
              padding: const EdgeInsets.only(left: 12, right: 12, top: 26, bottom: 26),
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
                            _isOrdered ?
                            Text(
                              "Your order has been placed on ${widget.snap['orderDate']}  ${widget.snap['orderTime']}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.black54,),
                            ) :_isPacked ?
                            Text(
                              "Your order has been packed on ${widget.snap['orderPackedDate']}   ${widget.snap['orderPackedTime']}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.black54,),
                            ) :_isShipped ?
                            Text(
                              "Your order has been shipped on ${widget.snap['orderShippedDate']}   ${widget.snap['orderShippedTime']}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.black54,),
                            ):_isDelivered ?
                            Text(
                              "Your order has been delivered on ${widget.snap['orderDeliveredDate']}   ${widget.snap['orderDeliveredTime']}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.black54,),
                            ):_isCancelled ?
                            Text(
                              "Your order has been cancelled on ${widget.snap['orderCancelledDate']}   ${widget.snap['orderCancelledTime']}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.black54,),
                            ): Container(),
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
