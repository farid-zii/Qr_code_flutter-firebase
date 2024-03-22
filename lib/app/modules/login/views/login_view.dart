import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code/app/controllers/auth_controller.dart';
import 'package:qr_code/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController emailC = TextEditingController(
    text: "admin@example.com",
  );
  final TextEditingController passwordC = TextEditingController(
    text: "123456",
  );

  final AuthController authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amberAccent,
          title: const Text('LoginView'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextField(
              autocorrect: false,
              controller: emailC,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(
              () => TextField(
                autocorrect: false,
                controller: passwordC,
                keyboardType: TextInputType.text,
                obscureText: controller.isHidden.value,
                decoration: InputDecoration(
                    labelText: "Password",
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.isHidden.toggle();
                        },
                        icon: Icon(controller.isHidden.isFalse
                            ? Icons.remove_red_eye
                            : Icons.remove_red_eye_outlined)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
                      controller.isLoading(true);
                      Map<String, dynamic> hasil =
                          await authC.login(emailC.text, passwordC.text);
                      controller.isLoading(false);

                      if (hasil["error"] == true) {
                        Get.snackbar("Error", hasil["message"]);
                      } else {
                        Get.offAllNamed(Routes.home);
                      }
                    } else {
                      Get.snackbar("Error", "Email dan Password Wajib di isi");
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(vertical: 20)),
                child: Obx(() =>
                    Text(controller.isLoading.isFalse ? "Login" : "Loading")))
          ],
        ));
  }
}
