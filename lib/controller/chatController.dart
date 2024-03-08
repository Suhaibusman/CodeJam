import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatController extends GetxController {
  RxString imagePath = "".obs;
  RxBool loading = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
            .child("user")
            .child(randomFileName)
            .putFile(File(imagePath.value));

        TaskSnapshot taskSnapshot = await uploadImage;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        // Prepare data to be added to Firestore
        Map<String, dynamic> userData = {
          'userName': userNameController.text,
          'description': messageController.text,
          'time': DateTime.now(),
          'image': downloadUrl,
        };

        await firestore.collection("User").add(userData);

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
}
