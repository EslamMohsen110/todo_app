import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/login/login_navigator.dart';
import 'package:todo_app/auth/login/login_screen_view_model.dart';
import 'package:todo_app/auth/register/register_screen.dart';
import 'package:todo_app/resoures/color/color_app.dart';
import 'package:todo_app/widgets/dialog_utils.dart';
import 'package:todo_app/widgets/text_filed_widget.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  LoginScreenViewModel viewModel = LoginScreenViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Container(
              color: ColorApp.cPrimaryLightBackgroundColor,
              child: Image.asset(
                'assets/images/bg.png',
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.fill,
              )),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              title: Text(
                'Login',
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
                      SizedBox(
                        height: height * 0.2,
                      ),
                      Text(
                        'Welcome Back!',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
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
                        controller: viewModel.emailController,
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
                          controller: viewModel.passwordController),
                      Text(
                        'Forgot Password ? ',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: ColorApp.cPrimaryDarkBackGroundColor,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          login();
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: ColorApp.cWhiteColor,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorApp.cPrimaryColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(RegisterScreen.routeName);
                        },
                        child: const Text(
                          'Or Create My Account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ColorApp.cPrimaryDarkBackGroundColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void login() {
    if (globalKey.currentState?.validate() == true) {
      viewModel.login();
    }
  }

  @override
  void hideLoading() {
    DialogUtils.hideLoading(context);
  }

  @override
  void showLoading(String message) {
    DialogUtils.showLoading(
      context: context,
      message: message,
    );
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
