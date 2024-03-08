import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';

class ChatController extends GetxController {
  RxString imagePath = "".obs;
  RxBool loading = false.obs;
  RxString value = "".obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  StreamController<QuerySnapshot>? streamController;

  @override
  void onInit() {
    super.onInit();
    // Call this method to initialize the stream
    initializeStream();
  }

  @override
  void onClose() {
    // Close the stream controller when not needed to avoid memory leaks
    streamController?.close();
    super.onClose();
  }

  // Method to initialize the stream from Firestore
  void initializeStream() {
    // Initialize the stream controller
    streamController = StreamController<QuerySnapshot>();
    // Get the Firestore collection and listen for changes
    firestore.collection("Users").snapshots().listen((event) {
      // Add the event to the stream
      streamController?.add(event);
    });
  }

  TextEditingController searchController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image.path.toString();
    }
  }

  String getRandomString(int length) {
    var rand = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return List.generate(length, (index) => chars[rand.nextInt(chars.length)])
        .join();
  }

// Get the file name from the image path
  String getFileNameFromPath(String path) {
    return path.split('/').last;
  }

// Generate a random image address and upload the image

  void addUsersAndMessages() async {
    loading.value = true;
    try {
      if (userNameController.text.isEmpty || messageController.text.isEmpty) {
        loading.value = false;
        Get.snackbar("Error", "Please fill all the values");
      } else if (imagePath.isEmpty) {
        loading.value = false;
        Get.snackbar("Error", "Please upload your image");
      } else {
        String randomImageAddress =
            getRandomString(10); // Change 10 to desired length
        String fileName = getFileNameFromPath(imagePath.value);
        String randomFileName = '$randomImageAddress$fileName';

        UploadTask uploadImage = FirebaseStorage.instance
            .ref()
            .child("UserImages")
            .child(randomFileName)
            .putFile(File(imagePath.value));

        TaskSnapshot taskSnapshot = await uploadImage;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        // Prepare data to be added to Firestore
        Map<String, dynamic> userData = {
          'userName': userNameController.text,
          'message': messageController.text,
          'time': DateTime.now(),
          'image': downloadUrl,
        };

        await firestore.collection("Users").add(userData);

        loading.value = false;

        Get.snackbar("User Added", "Your Message has been send to the user");
        Get.back();
        imagePath.value = "";
        messageController.clear();
        userNameController.clear();
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }

  void search(String keyword) {
    if (keyword.isEmpty) {
      // If the search keyword is empty, reset the stream
      initializeStream();
    } else {
      streamController?.addStream(
        firestore
            .collection("Users")
            .where('userName', isGreaterThanOrEqualTo: keyword)
            .where('userName', isLessThan: keyword + 'z')
            .snapshots()
            .switchMap((event) => Stream.value(event)),
      );
      update();
    }
  }
}
