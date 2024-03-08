import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatController extends GetxController {
  RxString imagePath = "".obs;

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
}
