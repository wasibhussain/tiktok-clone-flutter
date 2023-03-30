import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';
import 'package:tiktok_clone/screens/login_screen.dart';

import 'package:tiktok_clone/utils/constants.dart';
import 'package:tiktok_clone/widgets/text_input_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static AuthController authControllerInstance = Get.find();

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tiktok Clone',
                  style: TextStyle(
                      color: buttonColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 35),
                ),
                const Text(
                  'Register',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 35),
                ),
                const SizedBox(height: 15),
                Stack(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 70,
                      backgroundImage: NetworkImage(
                          'https://e7.pngegg.com/pngimages/148/892/png-clipart-computer-icons-user-symbol-light-client-icon-service-computer.png'),
                    ),
                    Positioned(
                        top: 90,
                        right: -15,
                        child: IconButton(
                            onPressed: () => authControllerInstance.pickImage(),
                            icon: const Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                            )))
                  ],
                ),
                const SizedBox(height: 25),
                TextInputFeild(
                    controller: _userNameController,
                    labelText: 'Name',
                    icon: Icons.person),
                const SizedBox(height: 15),
                TextInputFeild(
                    controller: _emailController,
                    labelText: 'Email',
                    icon: Icons.email),
                const SizedBox(height: 15),
                TextInputFeild(
                  controller: _passwordController,
                  labelText: 'Password',
                  icon: Icons.password,
                  isObscure: true,
                ),
                const SizedBox(height: 15),
                Container(
                  width: mediaQuery.width * 0.98,
                  height: mediaQuery.height * 0.08,
                  decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    onTap: () => authControllerInstance.register(
                        _userNameController.text,
                        _emailController.text,
                        _passwordController.text,
                        authControllerInstance.profilePhoto),
                    child: const Center(
                        child: Text(
                      'Register',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    )),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        Get.to(LogInScreen());
                      },
                      child: Text(
                        'LogIn',
                        style: TextStyle(color: buttonColor, fontSize: 18),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
