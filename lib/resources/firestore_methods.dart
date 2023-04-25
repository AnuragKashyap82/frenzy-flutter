import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import '../models/user_details_model.dart';

class FireStoreMethods {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future uploadUserDetailsToDb({required UserDetailsModel user}) async {
    await firebaseFirestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(user.getJson());
  }

  Future updateUserDetailsToDb({
    required String name,
    required String phone,
  }) async {
    await firebaseFirestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "name": name,
      "phoneNo": phone,
    });
  }

  Future uploadCategory({
    required String categoryName,
    required String downloadUrl,
  }) async {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    await firebaseFirestore.collection("category").doc(timestamp).set({
      "categoryName": categoryName,
      "imageUrl": downloadUrl,
    });
  }

  Future addToCart({
    required String productId,
    required String quantity,
    required String productPrice,
    required String productCuttedPrice,
  }) async {
    DateTime time = DateTime.now();

    String date = DateFormat("MMM d, yyyy").format(DateTime.now());
    String tDate = DateFormat("hh:mm a").format(DateTime.now());

    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .collection("myCart")
        .doc(productId)
        .set({
      "timestamp": "${date} ${tDate}",
      "productId": productId,
      "quantity": quantity,
      "productPrice": productPrice,
      "productCuttedPrice": productCuttedPrice,
    });
  }

  Future addToRecentViewed({
    required String productId,
  }) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .collection("myRecentProducts")
        .doc(productId)
        .set({
      "productId": productId,
    });
  }

  Future removeFromCart({
    required String productId,
  }) async {

    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .collection("myCart")
        .doc(productId)
        .delete();
  }

  Future addToWishList({
    required String productId,
  }) async {
    DateTime time = DateTime.now();

    String date = DateFormat("MMM d, yyyy").format(DateTime.now());
    String tDate = DateFormat("hh:mm a").format(DateTime.now());

    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .collection("myWishList")
        .doc(productId)
        .set({
      "timestamp": "${date} ${tDate}",
      "productId": productId,
    });
  }

  Future removeFromWishList({
    required String productId,
  }) async {

    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .collection("myWishList")
        .doc(productId)
        .delete();
  }

  Future addToSaveLater({
    required String productId,
    required String quantity,
    required String productPrice,
    required String productCuttedPrice,

  }) async {
    DateTime time = DateTime.now();

    String date = DateFormat("MMM d, yyyy").format(DateTime.now());
    String tDate = DateFormat("hh:mm a").format(DateTime.now());

    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .collection("saveLater")
        .doc(productId)
        .set({
      "timestamp": "${date} ${tDate}",
      "productId": productId,
    });
  }

  Future removeFromSaveLater({
    required String productId,
  }) async {

    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .collection("saveLater")
        .doc(productId)
        .delete();
  }

  Future<String> addOrder({
    required String productId,
    required String deliveryFee,
    required String productImage,
    required String productDescription,
    required String discount,
    required bool isCancelled,
    required String name,
    required String orderFrom,
    required String originalPrice,
    required String phoneNo,
    required String productPrice,
    required String productTitle,
    required String purchasedPrice,
    required String quantity,
    required String shippingAddress,
  }) async {
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    String date = DateFormat("MMM d, yyyy").format(DateTime.now());
    String time = DateFormat("hh:mm a").format(DateTime.now());
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .collection("MyOrders")
        .doc(orderId)
        .set({
      "orderId": orderId,
      "productId": productId,
      "orderDate": date,
      "deliveryFee": deliveryFee,
      "productDescription": productDescription,
      "orderTime": time,
      "name": name,
      "productImage": productImage,
      "originalPrice": originalPrice,
      "productPrice": productPrice,
      "productTitle": productTitle,
      "purchasedPrice": purchasedPrice,
      "quantity": quantity,
      "orderFrom": orderFrom,
      "discount": discount,
      "orderStatus": "ordered",
      "paymentMethod": "COD",
      "phoneNo": phoneNo,
      "shippingAddress": shippingAddress,
      "orderBy": firebaseAuth.currentUser?.uid,
    });
    await addOrderToSeller(
      productId: productId,
      shopId: orderFrom,
      orderId: orderId
    );
    return orderId;

  }

  Future addOrderToSeller({
    required String orderId,
    required String productId,
    required String shopId,
  }) async {
    await firebaseFirestore
        .collection("sellers")
        .doc(shopId)
        .collection("orders")
        .doc(orderId)
        .set({
      "orderId": orderId,
      "productId": productId,
      "shopId": shopId,
      "orderBy": firebaseAuth.currentUser?.uid,
    });

  }

  Future decreaseProductQuantityCount({
    required String productId,
    required String noOfQuantity,
  }) async {
    await firebaseFirestore
        .collection("products")
        .doc(productId)
        .update({
      "noOfQuantity": noOfQuantity,
    });
  }

  Future increaseTendingCount({
    required String productId,
    required String trendingCount,
  }) async {
    await firebaseFirestore
        .collection("products")
        .doc(productId)
        .update({
      "trendingCount": trendingCount,
    });

  }

  Future addQuestion({
    required String productId,
    required String question,
  }) async {
    DateTime time = DateTime.now();
    String questionId = DateTime.now().millisecondsSinceEpoch.toString();
    String date = DateFormat("MMM d, yyyy").format(DateTime.now());
    String tDate = DateFormat("hh:mm a").format(DateTime.now());

    await firebaseFirestore
        .collection("products")
        .doc(productId)
        .collection("questions")
        .doc(questionId)
        .set({
      "question": question,
      "productId": productId,
      "questionId": questionId,
      "time": "$date $tDate",
      "answer": "Not yet answered",
      "uid": firebaseAuth.currentUser?.uid,
    });
    addToMyQuestion(productId: productId, questionId: questionId,question: question);
  }

  Future addToMyQuestion({
    required String productId,
    required String questionId,
    required String question,
  }) async {
    DateTime time = DateTime.now();
    String questionId = DateTime.now().millisecondsSinceEpoch.toString();
    String date = DateFormat("MMM d, yyyy").format(DateTime.now());
    String tDate = DateFormat("hh:mm a").format(DateTime.now());

    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .collection("myQuestions")
        .doc(questionId)
        .set({
      "question": question,
      "productId": productId,
      "questionId": questionId,
      "time": "$date $tDate",
      "answer": "Not yet answered",
      "uid": firebaseAuth.currentUser?.uid,
    });
  }

  Future addRatingReview({
    required var rating,
    required String review,
    required String productId,
  }) async {
    DateTime time = DateTime.now();
    String questionId = DateTime.now().millisecondsSinceEpoch.toString();
    String date = DateFormat("MMM d, yyyy").format(DateTime.now());
    String tDate = DateFormat("hh:mm a").format(DateTime.now());

    await firebaseFirestore
        .collection("products")
        .doc(productId)
        .collection("ratings")
        .doc(firebaseAuth.currentUser?.uid)
        .set({
      "orderId": "",
      "productId": productId,
      "rating": rating,
      "reviewDateTime": "$date $tDate",
      "review": review,
      "uid": firebaseAuth.currentUser?.uid,
    });
    addToMyRatingReview(
      productId: productId,
      rating: rating,
      review: review,
    );
  }

  Future addToMyRatingReview({
    required var rating,
    required String review,
    required String productId,
  }) async {
    DateTime time = DateTime.now();
    String questionId = DateTime.now().millisecondsSinceEpoch.toString();
    String date = DateFormat("MMM d, yyyy").format(DateTime.now());
    String tDate = DateFormat("hh:mm a").format(DateTime.now());

    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .collection("MyRatings")
        .doc(productId)
        .set({
      "orderId": "",
      "productId": productId,
      "rating": rating,
      "reviewDateTime": "$date $tDate",
      "review": review,
      "uid": firebaseAuth.currentUser?.uid,
    });
  }

  Future addMyAddress({
    required String city,
    required String alterPhoneNo,
    required String area,
    required String landmark,
    required String name,
    required String phoneNo,
    required String pinCode,
    required String state,
  }) async {
    String addressId = DateTime.now().millisecondsSinceEpoch.toString();

    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .collection("MyAddress")
        .doc("default")
        .set({
      "addressId": addressId,
      "city": city,
      "alterPhoneNo": alterPhoneNo,
      "area": area,
      "landmark": landmark,
      "name": name,
      "phoneNo": phoneNo,
      "pinCode": pinCode,
      "state": state,
    });
  }

  Future updateUserImage({required String downloadUrl}) async {
    await firebaseFirestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"photoUrl": downloadUrl});
  }

  Future<String> uploadImageToDatabase(
      {required Uint8List image, required String uid}) async {
    Reference storageRef =
        FirebaseStorage.instance.ref().child("profileImages").child(uid);
    UploadTask uploadTask = storageRef.putData(image);
    TaskSnapshot task = await uploadTask;
    return task.ref.getDownloadURL();
  }

  Future<String> uploadCategoryImage({required Uint8List image}) async {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageRef =
        FirebaseStorage.instance.ref().child("categoryImages").child(timestamp);
    UploadTask uploadTask = storageRef.putData(image);
    TaskSnapshot task = await uploadTask;
    return task.ref.getDownloadURL();
  }

  Future<String> uploadProductImage({required Uint8List image}) async {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageRef =
        FirebaseStorage.instance.ref().child("productImages").child(timestamp);
    UploadTask uploadTask = storageRef.putData(image);
    TaskSnapshot task = await uploadTask;
    return task.ref.getDownloadURL();
  }

  Future<bool> checkAlreadyInCart({
    required String productId,
  }) async {
      var cartSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(firebaseAuth.currentUser?.uid)
          .collection("myCart")
          .doc(productId)
          .get();
      if (cartSnap.exists) {
        return  true;
      } else {
        return  false;
      }
  }

  Future<bool> checkAlreadyInWishList({
    required String productId,
  }) async {
    var cartSnap = await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .collection("myWishList")
        .doc(productId)
        .get();
    if (cartSnap.exists) {
      return  true;
    } else {
      return  false;
    }
  }

  Future<String> uploadProduct({
    required String productImage,
    required String category,
    required String productPrice,
    required String productCuttedPrice,
    required String stocks,
    required String deliveryFee,
    required String? shopId,
  }) async {
    String productId = DateTime.now().millisecondsSinceEpoch.toString();

    await firebaseFirestore.collection("products").doc(productId).set({
      "active": false,
      "isDetailsCompleted": false,
      "category": category,
      "productImage": productImage,
      "productPrice": productPrice,
      "productCuttedPrice": productCuttedPrice,
      "deliveryFee": deliveryFee,
      "noOfQuantity": stocks,
      "shopId": shopId,
      "trendingCount": "0",
      "productId": productId,
    });
    return productId;
  }

  Future<String> uploadDescription({
    required String productId,
    required String productTitle,
    required String productDescription,
    required String deliveryWithin,
    required bool isCod,
    required bool isTabSelected,
    required String allDetails,
  }) async {
    await firebaseFirestore.collection("products").doc(productId).update({
      "isCod": isCod,
      "isTabSelected": isTabSelected,
      "productTitle": productTitle,
      "productDescription": productDescription,
      "deliveryWithin": deliveryWithin,
      "allDetails": allDetails,
    });
    return productId;
  }

  Future<String> sendForQC({
    required String productId,
    required String banner1,
    required String banner2,
    required String banner3,
    required String banner4,
    required String banner5,
    required String banner6,
  }) async {
    DateTime time = DateTime.now();
    String timestamp = time.millisecondsSinceEpoch.toString();

    String date = DateFormat("MMM d, yyyy").format(DateTime.now());
    String tDate = DateFormat("hh:mm a").format(DateTime.now());

    await firebaseFirestore.collection("products").doc(productId).update({
      "banner1": banner1,
      "banner2": banner2,
      "banner3": banner3,
      "banner4": banner4,
      "banner5": banner5,
      "banner6": banner6,
      "isDetailsCompleted": true,
      "processedDate": date,
      "processedTime": tDate,
    });
    return productId;
  }
}
