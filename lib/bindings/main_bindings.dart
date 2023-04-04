import 'package:get/get.dart';
import 'package:shooping_app/controller/main_controller.dart';
import 'package:shooping_app/controller/payment_controller.dart';
import 'package:shooping_app/controller/settings_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController());
    Get.put(SettingsController(), permanent: true);
    Get.put(PaymentController(), permanent: true);
  }
}