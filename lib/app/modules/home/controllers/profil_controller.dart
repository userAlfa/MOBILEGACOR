import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var selectedImagePath = ''.obs;

  // Function to select image from gallery
  void selectImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      Get.snackbar('Success', 'Profile photo updated');
    } else {
      Get.snackbar('Error', 'No image selected');
    }
  }

  // Function to take picture with camera
  void takePicture() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      Get.snackbar('Success', 'Profile photo updated');
    } else {
      Get.snackbar('Error', 'No picture taken');
    }
  }

  // Function to delete profile photo
  void deletePhoto() {
    selectedImagePath.value = '';
    Get.snackbar('Success', 'Profile photo deleted');
  }
}
