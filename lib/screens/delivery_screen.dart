import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_store/screens/add_address_screen.dart';
import 'package:frenzy_store/screens/payment_screen.dart';
import '../utils/utils.dart';

class DeliveryScreen extends StatefulWidget {
  final snap;

  const DeliveryScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

int discountPercent = 0;
int quantityCount = 1;
int productPrice = 1299;
int productCuttedPrice = 1299;
int discount = 1299;
int totalAmount = 1299;
int totalSaving = 1299;

class _DeliveryScreenState extends State<DeliveryScreen> {
  bool _isLoading = false;
  var _addressData = {};
  bool _isAddressAvailable = false;

  void getMyAddress() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var addressSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("MyAddress")
          .doc("default")
          .get();
      if (addressSnap.exists) {
        setState(() {
          _addressData = addressSnap.data()!;
          _isAddressAvailable = true;
        });
      } else {
      }
    } catch (e) {
      Utils().showSnackBar(context, e.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyAddress();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    setState(() {
      discountPercent = int.parse(widget.snap['productCuttedPrice']) -
          int.parse(widget.snap['productPrice']);

      discountPercent = discountPercent * 100;
      discountPercent =
          discountPercent ~/ int.parse(widget.snap['productCuttedPrice']);

      productPrice = int.parse(widget.snap['productPrice']) * quantityCount;
      productCuttedPrice =
          int.parse(widget.snap['productCuttedPrice']) * quantityCount;

      totalAmount = productPrice + int.parse(widget.snap['deliveryFee']);
      totalSaving = productCuttedPrice - productPrice;
      discount = totalSaving;
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Delivery",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
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
                                  "2",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
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
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
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
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Center(
                                    child: Text(
                                  "3",
                                  style: TextStyle(fontSize: 12),
                                )),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 1,
                          ),
                          Text(
                            "Payment",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: PhysicalModel(
                    color: Colors.white,
                    shadowColor: Colors.blue,
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 16, bottom: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Image.network(
                                    widget.snap['productImage'],
                                    width: 100,
                                    height: 140,
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (quantityCount == 1) {
                                              Utils().showSnackBar(context,
                                                  "1 quantity must be selected!!!");
                                            } else {
                                              setState(() {
                                                quantityCount =
                                                    quantityCount - 1;
                                              });
                                            }
                                          },
                                          child: Icon(
                                            Icons.add_circle_outline_sharp,
                                            size: 24,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          "$quantityCount",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (quantityCount == int.parse(widget.snap['noOfQuantity'])) {
                                              Utils().showSnackBar(context,
                                                  "${widget.snap['noOfQuantity']} quantity available for Now");
                                            } else {
                                              setState(() {
                                                quantityCount =
                                                    quantityCount + 1;
                                              });
                                            }
                                          },
                                          child: Icon(
                                            Icons.add_circle_outline_sharp,
                                            size: 24,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  height: 181,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 16),
                                        child: Text(
                                          widget.snap['productTitle'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 16),
                                        child: Text(
                                          widget.snap['productDescription'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 16,
                                              color: Colors.green.shade700,
                                            ),
                                            SizedBox(
                                              width: 1,
                                            ),
                                            Icon(
                                              Icons.star,
                                              size: 16,
                                              color: Colors.green.shade700,
                                            ),
                                            SizedBox(
                                              width: 1,
                                            ),
                                            Icon(
                                              Icons.star,
                                              size: 16,
                                              color: Colors.green.shade700,
                                            ),
                                            SizedBox(
                                              width: 1,
                                            ),
                                            Icon(
                                              Icons.star,
                                              size: 16,
                                              color: Colors.green.shade700,
                                            ),
                                            SizedBox(
                                              width: 1,
                                            ),
                                            Icon(
                                              Icons.star,
                                              size: 16,
                                              color: Colors.green.shade700,
                                            ),
                                            SizedBox(
                                              width: 26,
                                            ),
                                            Text(
                                              "(15455)",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Rs.${productCuttedPrice}",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey),
                                            ),
                                            SizedBox(
                                              width: 0,
                                            ),
                                            Text(
                                              "Rs.${productPrice}",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 0,
                                            ),
                                            Text(
                                              "${discountPercent}% OFF",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 0,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              widget.snap['isCod']
                                                  ? "COD Not Available"
                                                  : "COD Available",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.blue),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                            top: 8,
                                            bottom: 0),
                                        child: Text(
                                          "Delivery charges Rs.${widget.snap['deliveryFee']}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black87),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        )
                      ],
                    ),
                  ),
                ),
                _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                        strokeWidth: 1,
                        color: Colors.black,
                      ))
                    : Padding(
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
                                  "${_addressData['name']}",
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
                                  "${_addressData['area']},\n${_addressData['city']}, ${_addressData['pinCode']}",
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
                                  "${_addressData['phoneNo']}, ${_addressData['alterPhoneNo']}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 46,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    AddAddressScreen()));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: StadiumBorder()),
                                      child: Text(
                                        "Change or add new Address",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      )),
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
                                "Rs.${productCuttedPrice.toString()}",
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
                                "Rs.${productPrice.toString()}",
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
                            "You saved Rs.$totalSaving on this order",
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
                              "Rs.${totalAmount}\nTotal Amount",
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
                      _isAddressAvailable ?
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PaymentScreen(
                                    snap: widget.snap,
                                discount: totalSaving.toString(),
                                originalPrice: productCuttedPrice.toString(),
                                purchasedPrice: productPrice.toString(),
                                quantityCount: quantityCount.toString(),
                                totalAmount: totalAmount.toString(),
                                name: _addressData['name'],
                                phoneNo: _addressData['phoneNo'],
                                shippingAddress: "${_addressData['area']}, ${_addressData['city']}, ${_addressData['pinCode']}, ${_addressData['state']}",
                                  )))
                          :
                          Utils().showSnackBar(context, "Add Address First to continue")
                      ;
                    },
                    child: Container(
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
