import 'package:flutter/material.dart';
import 'package:frenzy_store/resources/firestore_methods.dart';
import 'package:frenzy_store/screens/review_product_screen.dart';
import 'package:frenzy_store/widgets/order_progress_bar_widget.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class OrderDetailsScreen extends StatefulWidget {
  final snap;

  const OrderDetailsScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int price = 1299;

  bool _isOrdered = true;
  bool _isPacked = false;
  bool _isShipped = false;
  bool _isDelivered = false;
  bool _isCancelled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.snap['orderStatus'] == "ordered"){
      setState(() {
        _isOrdered = true;
      });
    }else if(widget.snap['orderStatus'] == "packed"){
      setState(() {
        _isPacked = true;
      });
    }else if(widget.snap['orderStatus'] == "shipped"){
      setState(() {
        _isPacked = true;
        _isShipped = true;
      });
    }else if(widget.snap['orderStatus'] == "delivered"){
      setState(() {
        _isPacked = true;
        _isShipped = true;
        _isDelivered = true;
      });
    }else if(widget.snap['orderStatus'] == "cancelled"){
      setState(() {
        _isCancelled = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      price = int.parse(widget.snap['productPrice']) *
          int.parse(widget.snap['quantity']);
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Order Details",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Order ID: ${widget.snap['orderId']}",
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
            ),
            Divider(
              height: 0.2,
              color: Colors.grey.shade400,
            ),
            ProductDetailsWidget(snap: widget.snap),
            Divider(
              height: 0.2,
              color: Colors.grey.shade400,
            ),
            SizedBox(
              height: _isCancelled ?160:400,
              child: OrderProgressBarWidget(snap: widget.snap),
            ),
            _isCancelled ? Container():
            Divider(
              height: 0.2,
              color: Colors.grey.shade400,
            ),
            _isCancelled ? Container():
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    _orderCancelDialog();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w100),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                    height: 52, child: VerticalDivider(color: Colors.red)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      'Need Help?',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w100),
                    )
                  ],
                ),
              ],
            ),
            Divider(
              height: 0.2,
              color: Colors.grey.shade400,
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Your Ratings",
                style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SmoothStarRating(
                        allowHalfRating: false,
                        starCount: 5,
                        rating: 2,
                        size: 25.0,
                        filledIconData: Icons.star_outlined,
                        halfFilledIconData: Icons.star_half,
                        color: Colors.green,
                        borderColor: Colors.green,
                        spacing: 0.0),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddReviewProductScreen(
                                    snap: widget.snap,
                                  )));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 4),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.green.shade700, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "Rate Now",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: PhysicalModel(
                color: Colors.white,
                shadowColor: Colors.blue,
                elevation: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "SHIPPING DETAILS",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black54,
                            letterSpacing: 0.5),
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade400,
                      height: 0.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        "${widget.snap['name']}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: Text(
                        "${widget.snap['shippingAddress']}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        "${widget.snap['phoneNo']}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: PhysicalModel(
                color: Colors.white,
                shadowColor: Colors.blue,
                elevation: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        "Price Details",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade400,
                      height: 0.3,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Original Price",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w100),
                          ),
                          Text(
                            "Rs.${widget.snap['originalPrice']}",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Price",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          Text(
                            "Rs.${price.toString()}",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Delivery Charges",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          Text(
                            "Rs.${widget.snap['deliveryFee']}",
                            style: TextStyle(fontSize: 14, color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Discount",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          Text(
                            "Rs.${widget.snap['discount']}",
                            style: TextStyle(fontSize: 14, color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Divider(
                      color: Colors.grey.shade400,
                      height: 0.3,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Amount",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            "Rs.${widget.snap['purchasedPrice']}",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Divider(
                      color: Colors.grey.shade400,
                      height: 0.3,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "You saved Rs.${widget.snap['discount']} on this order",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.green),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: PhysicalModel(
                color: Colors.white,
                shadowColor: Colors.blue,
                elevation: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "PAYMENT DETAILS",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                            letterSpacing: 0.5),
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade400,
                      height: 0.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Text(
                        "COD: Rs. ${widget.snap['purchasedPrice']} to be paid",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _orderCancelDialog() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding:
                  EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Row(
                children: [
                  const Icon(
                    Icons.remove_shopping_cart,
                    color: Colors.blue,
                  ),
                  const Text("  Order Cancel")
                ],
              ),
              content: Text(
                "Are you sure want to Cancel the order?",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    FireStoreMethods()
                        .markOrderStatusCancelled(
                        orderBy: widget.snap['orderBy'],
                        orderId: widget.snap['orderId'],
                        orderFrom: widget.snap['orderFrom'])
                        .then((value) {
                      setState(() {

                        //update the progress indicator

                      });

                      Navigator.pop(context);
                    });
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
                MaterialButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Leave",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                )
              ],
            ));
  }
}

class ProductDetailsWidget extends StatefulWidget {
  final snap;

  const ProductDetailsWidget({Key? key, required this.snap}) : super(key: key);

  @override
  State<ProductDetailsWidget> createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.snap['productTitle']}",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "${widget.snap['productDescription']}",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Seller: Shop Name to be integrated",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rs.${widget.snap['purchasedPrice']}",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.green.shade700, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "Qty: ${widget.snap['quantity']}",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 26,
          ),
          Center(
              child: Image.network(
            "${widget.snap['productImage']}",
            width: 100,
            height: 120,
          ))
        ],
      ),
    );
  }
}
