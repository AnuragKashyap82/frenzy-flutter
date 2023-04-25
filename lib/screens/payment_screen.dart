import 'package:flutter/material.dart';
import 'package:frenzy_store/resources/firestore_methods.dart';
import 'package:frenzy_store/screens/delivery_screen.dart';
import 'package:frenzy_store/screens/order_confirm_screen.dart';

class PaymentScreen extends StatefulWidget {
  final snap;
  final String originalPrice;
  final String purchasedPrice;
  final String quantityCount;
  final String discount;
  final String totalAmount;
  final String name;
  final String phoneNo;
  final String shippingAddress;

  const PaymentScreen({
    Key? key,
    required this.snap,
    required this.originalPrice,
    required this.purchasedPrice,
    required this.quantityCount,
    required this.discount,
    required this.totalAmount,
    required this.name,
    required this.phoneNo,
    required this.shippingAddress,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int quantityCount = int.parse(widget.snap['noOfQuantity']);
    int trendingCount = int.parse(widget.snap['trendingCount']);
    Size screenSize = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Payment Details",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          PhysicalModel(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Center(
                                    child: Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 12,
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Text(
                            "Address",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 0,
                      ),
                      Container(
                        height: 0.8,
                        margin: EdgeInsets.only(bottom: 18),
                        width: screenSize.width / 4,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          PhysicalModel(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Center(
                                    child: Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 12,
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Text(
                            "Confirmation",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 0,
                      ),
                      Container(
                        height: 0.8,
                        margin: EdgeInsets.only(bottom: 18),
                        width: screenSize.width / 4,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          PhysicalModel(
                            color: Colors.blue,
                            elevation: 8,
                            shadowColor: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Center(
                                    child: Text(
                                      "3",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 1,
                          ),
                          Text(
                            "Payment",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "All payment options",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 16,
                            width: 16,
                            decoration: BoxDecoration(
                              color: Colors.green.shade700,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            "Wallet / Postpaid",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                letterSpacing: 0.5),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 0.2,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 16,
                            width: 16,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            "Net Banking",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                letterSpacing: 0.5),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(
                        color: Colors.grey.shade400,
                        height: 0.2,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 16,
                            width: 16,
                            decoration: BoxDecoration(
                              color: Colors.green.shade700,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            "UPI",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                letterSpacing: 0.5),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(
                        color: Colors.grey.shade400,
                        height: 0.2,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 16,
                            width: 16,
                            decoration: BoxDecoration(
                              color: Colors.green.shade700,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            "Credit/ Debit/ ATM card",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                letterSpacing: 0.5),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(
                        color: Colors.grey.shade400,
                        height: 0.2,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 16,
                            width: 16,
                            decoration: BoxDecoration(
                              color: Colors.green.shade700,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.done,
                              size: 8,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            "Cash On Delivery(COD)",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                letterSpacing: 0.5),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(
                        color: Colors.grey.shade400,
                        height: 0.2,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
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
                                "Rs.$productCuttedPrice",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
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
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                              Text(
                                "Rs.$productPrice",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
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
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                              Text(
                                "Rs.${widget.snap['deliveryFee']}",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.green),
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
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                              Text(
                                "Rs.$discount",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.green),
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
                                "Rs.$totalAmount",
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
                            "You saved Rs.${discount} totalSaving on this order",
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
                SizedBox(
                  height: 60,
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 50.0,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {},
                    child: Container(
                      height: 50,
                      width: screenSize.width / 2,
                      color: Colors.white,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Rs.$totalAmount\nTotal Amount",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      await FireStoreMethods()
                          .addOrder(
                        productId: widget.snap['productId'],
                        deliveryFee: widget.snap['deliveryFee'],
                        productImage: widget.snap['productImage'],
                        productDescription: widget.snap['productDescription'],
                        discount: widget.discount,
                        isCancelled: false,
                        name: widget.name,
                        orderFrom: widget.snap['shopId'],
                        originalPrice: widget.originalPrice,
                        phoneNo: widget.phoneNo,
                        productPrice: widget.snap['productPrice'],
                        productTitle: widget.snap['productTitle'],
                        purchasedPrice: widget.totalAmount,
                        quantity: widget.quantityCount,
                        shippingAddress: widget.shippingAddress,
                      )
                          .then((orderId) {
                        setState(() {
                          quantityCount =
                              quantityCount - int.parse(widget.quantityCount);
                          trendingCount = trendingCount + int.parse(widget.quantityCount);
                        });
                        FireStoreMethods().decreaseProductQuantityCount(
                            productId: widget.snap['productId'],
                            noOfQuantity: quantityCount.toString())
                            .then((value) {
                          setState(() {
                            _isLoading = false;
                          });
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      OrderConfirmScreen(orderId: orderId)));
                        });
                      });
                     await FireStoreMethods().increaseTendingCount(
                          productId: widget.snap['productId'], trendingCount: trendingCount.toString());
                    },
                    child: _isLoading
                        ? Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          color: Colors.black,
                        ))
                        : Container(
                      height: 50,
                      width: screenSize.width / 2,
                      color: Colors.blue,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Continue",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
