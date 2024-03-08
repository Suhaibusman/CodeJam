import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatController extends GetxController {
  RxString imagePath = "".obs;
  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image.path.toString();
    }
  }
}
