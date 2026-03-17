import 'package:get/get.dart';

class MessagesController extends GetxController {
  final messages = <String>[].obs;

  void sendMessage(String message) {
    if (message.isNotEmpty) {
      messages.add(message);
    }
  }

  void goBack() {
    Get.back();
  }
}
