import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/standard_app_bar.dart';
import '../../../widgets/standard_button.dart';
import '../getx_controllers/login_member_controller.dart';

class LoginPageMember extends StatelessWidget {
  LoginPageMember({Key? key}) : super(key: key);

  LoginMemberController loginMemberController =
      Get.put(LoginMemberController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: StandardAppBar(
          title: 'Login Page Member',
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: Get.width,
          height: Get.height - kToolbarHeight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                    radius: Get.width / 4,
                    backgroundImage: AssetImage('assets/images/logo.jpeg')),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: '10 Digit Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  controller: loginMemberController.phoneController,
                  keyboardType: TextInputType.phone,
                ),
                StandardButton(
                  text: 'Login',
                  onPressed: () {
                    loginMemberController.login();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
