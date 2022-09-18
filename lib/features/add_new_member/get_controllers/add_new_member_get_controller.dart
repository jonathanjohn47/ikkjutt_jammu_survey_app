import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddNewMemberGetController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController designationController = TextEditingController();

  RxString profilePicLink = 'assets/images/profile.png'.obs;

  void addNewMember() {}
}
