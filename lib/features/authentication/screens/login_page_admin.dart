import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/standard_app_bar.dart';
import '../../../widgets/standard_button.dart';
import '../getx_controllers/login_admin_controller.dart';

class LoginPageAdmin extends StatelessWidget {
  LoginPageAdmin({Key? key}) : super(key: key);

  LoginAdminController loginAdminController = Get.put(LoginAdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: StandardAppBar(
          title: 'Login Page Admin',
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: Get.width,
          height: Get.height - 2 * kToolbarHeight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: Get.height / 4,
                    child: Image.asset('assets/images/logo.jpeg')),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  controller: loginAdminController.emailController,
                ),
                Obx(() {
                  return TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          loginAdminController.showPassword.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          loginAdminController.showPassword.value =
                              !loginAdminController.showPassword.value;
                        },
                      ),
                    ),
                    controller: loginAdminController.passwordController,
                    obscureText: !loginAdminController.showPassword.value,
                  );
                }),
                Obx(() {
                  return loginAdminController.showLoader.value
                      ? CircularProgressIndicator()
                      : StandardButton(
                          text: 'Login',
                          onPressed: () {
                            loginAdminController.login();
                          },
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
