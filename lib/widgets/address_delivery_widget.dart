import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class AddressDeliveryWidget extends StatefulWidget {
  final snap;

  const AddressDeliveryWidget({Key? key, required this.snap}) : super(key: key);

  @override
  State<AddressDeliveryWidget> createState() => _AddressDeliveryWidgetState();
}

class _AddressDeliveryWidgetState extends State<AddressDeliveryWidget> {

  bool _isLoading = false;
  var _addressData = {};

  String cod = "COD snkdcn kwncn";

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
        });
      } else {}
      setState(() {});
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
    if(widget.snap['isCod'] == true){
      setState(() {
        cod = "Cash on delivery available";
      });
    }else{
      setState(() {
        cod = "Cash on delivery not available";
      });
    }
    return PhysicalModel(
      color: Colors.white,
      elevation: 4,
      shadowColor: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Deliver to: ",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  "${_addressData['name']}, ${_addressData['phoneNo']}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text("${_addressData['area']}, ${_addressData['city']}, ${_addressData['pinCode']}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                )),
            SizedBox(
              height: 12,
            ),
            Divider(
              height: 0.6,
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.delivery_dining_outlined,
                  color: Colors.grey,
                  size: 16,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  "Rs.${widget.snap['deliveryFee']}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Delivery Within ${widget.snap['deliveryWithin']}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),

                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.keyboard_return_rounded,
                  color: Colors.grey,
                  size: 16,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  "10 days Return Policy",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.attach_money,
                  color: Colors.grey,
                  size: 16,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  cod,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 4,
            )
          ],
        ),
      ),
    );
  }
}
