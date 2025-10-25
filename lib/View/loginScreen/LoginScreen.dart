import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ModelView/lgionModelView/LoginProvider.dart';
import '../../utlis/ScreenSize.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignInProvider(),
      child: Login(),
    );
  }
}

class Login extends StatelessWidget {
  Login({super.key});

  @override
  Widget build(BuildContext context) {
    final login = Provider.of<SignInProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: ScreenSize.height(context) * 0.016,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        login.changeLang('ar', context);
                      },
                      child: Text(
                        'العربية',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        login.changeLang('ru', context);
                      },
                      child: Text(
                        'Русский',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenSize.height(context) * 0.1),
                Center(
                  child: Text(
                    'login_title'.tr(),
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'welcome_message'.tr(),
                    style: const TextStyle(color: Colors.grey, fontSize: 30),
                  ),
                ),

                Text(
                  'phone_number_label'.tr(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),

                Form(
                  key: login.formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        obscureText: false,
                        controller: login.emailController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'phone_required'.tr();
                          } else if (val.length < 10) {
                            return 'phone_invalid'.tr();
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: Colors.blueAccent,
                            size: 20,
                          ),
                          label: Text(
                            'phone'.tr(),
                            style: const TextStyle(color: Colors.blueAccent),
                          ),
                          hintText: 'phone'.tr(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Colors.blueAccent,
                            ),
                          ),
                          filled: true,
                          fillColor: const Color(0xfff6f8fb),
                        ),
                      ),

                      Text(
                        'password_label'.tr(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),

                      TextFormField(
                        controller: login.passwordController,
                        obscureText: login.isObscure,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'password_required'.tr();
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          label: Text(
                            'password'.tr(),
                            style: const TextStyle(color: Colors.blueAccent),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              login.togglePasswordVisibility();
                            },
                            icon: Icon(
                              login.isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          hintText: 'enter_password'.tr(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          filled: true,
                          fillColor: const Color(0xfff6f8fb),
                        ),
                      ),
                    ],
                  ),
                ),

                Center(
                  child: Consumer<SignInProvider>(
                    builder: (context, function, child) {
                      return ElevatedButton(
                        onPressed: () {
                          function.signIn(
                            login.emailController.text,
                            login.passwordController.text,
                            context,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(ScreenSize.width(context) * 0.75, 30),
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          'login_button'.tr(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
