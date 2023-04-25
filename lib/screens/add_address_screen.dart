import 'package:flutter/material.dart';
import 'package:frenzy_store/resources/firestore_methods.dart';
import 'package:frenzy_store/utils/utils.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  bool _isLoading = false;

  TextEditingController _cityController = TextEditingController();
  TextEditingController _completeAddController = TextEditingController();
  TextEditingController _pinCodeController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _landmarkController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();
  TextEditingController _alterPhoneNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add or Manage Address",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller: _cityController,
                style: TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.location_city_rounded,
                    color: Colors.blue,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: "City",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(26),
                      borderSide: BorderSide.none),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
                controller: _completeAddController,
                style: TextStyle(fontSize: 12),
                maxLines: 6,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.location_city_rounded,
                    color: Colors.blue,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: "Location/area/street/complete address",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(26),
                      borderSide: BorderSide.none),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 2 - 16,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      controller: _pinCodeController,
                      style: TextStyle(fontSize: 12),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.location_city_rounded,
                          color: Colors.blue,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        hintText: "Pin Code",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(26),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 2 - 16,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: _stateController,
                      style: TextStyle(fontSize: 12),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.location_city_rounded,
                          color: Colors.blue,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        hintText: "State",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(26),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller: _landmarkController,
                style: TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.location_city_rounded,
                    color: Colors.blue,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: "Land mark",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(26),
                      borderSide: BorderSide.none),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                controller: _nameController,
                style: TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: "Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(26),
                      borderSide: BorderSide.none),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                controller: _phoneNoController,
                style: TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone_in_talk,
                    color: Colors.blue,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: "Phone No.",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(26),
                      borderSide: BorderSide.none),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                controller: _alterPhoneNoController,
                style: TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone_in_talk,
                    color: Colors.blue,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: "Alternate Phone no.",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(26),
                      borderSide: BorderSide.none),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 46,
                  child:
                  ElevatedButton(
                      onPressed: () async {
                        if (_cityController.text.isEmpty) {
                          Utils().showSnackBar(context, "Enter city!!");
                        } else if (_completeAddController.text.isEmpty) {
                          Utils().showSnackBar(
                              context, "Enter CompleteAddress!!");
                        } else if (_pinCodeController.text.isEmpty) {
                          Utils().showSnackBar(context, "Enter PinCode!!");
                        } else if (_stateController.text.isEmpty) {
                          Utils().showSnackBar(context, "Enter State!!");
                        } else if (_landmarkController.text.isEmpty) {
                          Utils().showSnackBar(context, "Enter landmark!!");
                        } else if (_nameController.text.isEmpty) {
                          Utils().showSnackBar(context, "Enter name!!");
                        } else if (_phoneNoController.text.isEmpty) {
                          Utils().showSnackBar(context, "Enter PhoneNo!!");
                        } else if (_alterPhoneNoController.text.isEmpty) {
                          Utils().showSnackBar(
                              context, "Enter alternate Phone No!!");
                        } else {
                          setState(() {
                            _isLoading = true;
                          });
                          FireStoreMethods().addMyAddress(
                            city: _cityController.text,
                            alterPhoneNo: _alterPhoneNoController.text,
                            area: _completeAddController.text,
                            landmark: _landmarkController.text,
                            name: _nameController.text,
                            phoneNo: _phoneNoController.text,
                            pinCode: _pinCodeController.text,
                            state: _stateController.text,
                          ).then((value) {
                            Navigator.pop(context);
                            setState(() {
                              _isLoading = false;
                            });
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder()),
                      child: _isLoading ? CircularProgressIndicator(strokeWidth: 1,
                        color: Colors.white,) : Text("Save".toLowerCase())

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
