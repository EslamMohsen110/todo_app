import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/register/register_navigator.dart';
import 'package:todo_app/auth/register/register_screen_view_model.dart';
import 'package:todo_app/widgets/dialog_utils.dart';
import 'package:todo_app/widgets/text_filed_widget.dart';

import '../../resoures/color/color_app.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterNavigator {
  var globalKey = GlobalKey<FormState>();
  final userNameController = TextEditingController(text: 'Eslam Mohsen');
  final emailController =
      TextEditingController(text: 'eslam.mohsen99@gmail.com');
  final passwordController = TextEditingController(text: '01093499817');
  final confirmPasswordController = TextEditingController(text: '01093499817');
  RegisterScreenViewModel viewModel = RegisterScreenViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(children: [
        Container(
          color: ColorApp.cPrimaryLightBackgroundColor,
          child: Image.asset(
            'assets/images/bg.png',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              foregroundColor: ColorApp.cWhiteColor,
              elevation: 0,
              title: Text(
                'Register',
                style: TextStyle(fontSize: 25),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
            ),
            body: SingleChildScrollView(
              child: Form(
                key: globalKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: height * 0.2),
                      TextFiledWidget(
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please Enter User Name';
                          }
                          return null;
                        },
                        title: 'User Name',
                        controller: userNameController,
                      ),
                      SizedBox(height: 15),
                      TextFiledWidget(
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please Enter Email';
                          }
                          final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(text);
                          if (!emailValid) {
                            return 'Please enter vaild email';
                          }
                          return null;
                        },
                        title: 'Email',
                        controller: emailController,
                      ),
                      SizedBox(height: 15),
                      TextFiledWidget(
                          obscureText: true,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please Enter Password';
                            }
                            if (text.length < 6) {
                              return 'Password should be at least 6 letters';
                            }
                            return null;
                          },
                          title: 'Password',
                          controller: passwordController),
                      SizedBox(height: 15),
                      TextFiledWidget(
                        obscureText: true,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Please Enter Confirm Password';
                          }
                          if (text.length < 6) {
                            return 'Password should be at least 6 letters';
                          }
                          if (text != passwordController.text) {
                            return "Confirm Password doesn't match Password.";
                          }
                          return null;
                        },
                        title: 'Confirm Password',
                        controller: confirmPasswordController,
                      ),
                      SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          register();
                        },
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            color: ColorApp.cWhiteColor,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorApp.cPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ))
      ]),
    );
  }

  void register() {
    if (globalKey.currentState?.validate() == true) {
      viewModel.register(emailController.text, passwordController.text);
    }
  }

  @override
  void hideLoading() {
    DialogUtils.hideLoading(context);
  }

  @override
  void showLoading(String message) {
    DialogUtils.showLoading(context: context, message: message);
  }

  @override
  void showMyMessage(String message) {
    DialogUtils.showMassage(
      context: context,
      content: message,
      posActionName: 'Ok',
    );
  }
}
