import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/login/login_navigator.dart';

import '../../firebase/firebase_utils/firebase_utils.dart';
import '../../provider/auth_user_provider.dart';
import '../../widgets/dialog_utils.dart';

class LoginScreenViewModel extends ChangeNotifier {
  var globalKey = GlobalKey<FormState>();
  late LoginNavigator navigator;
  var emailController = TextEditingController(text: 'Eslam.mohsen99@gmail.com');
  var passwordController = TextEditingController(text: '01093499817');

  void login() async {
    ///login
    navigator.showLoading('Waiting...');
    // DialogUtils.showLoading(context: context, message: 'Loading...');
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // var user =
      //     await FirebaseUtils.readUserFromFirebase(credential.user?.uid ?? '');
      // if (user == null) {
      //   return;
      // }
      // var authUserProvider =
      //     Provider.of<AuthUserProvider>(context, listen: false);
      // authUserProvider.updateUser(user);
      ///todo: hide Loading
      navigator.hideLoading();

      ///todo: Show Massage
      navigator.showMyMessage('Login Successflly');
      /////todo: hide Loading
      // DialogUtils.hideLoading(context);
      /////todo: Show Massage
      // DialogUtils.showMassage(
      //   context: context,
      //   content: 'Login Successflly',
      //   title: 'Success',
      //   posActionName: 'Ok',
      //   postAction: () {
      //     Navigator.of(context).pushNamedAndRemoveUntil(
      //       HomeScreen.routeName,
      //       (route) => false,
      //     );
      //   },
      // );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        ///todo: hide Loading
        navigator.hideLoading();

        ///todo: Show Massage
        navigator.showMyMessage('No user found for that email.');

        // ///todo: hide Loading
        // DialogUtils.hideLoading(context);
        //
        // ///todo: Show Massage
        // DialogUtils.showMassage(
        //     context: context,
        //     content: 'No user found for that email.',
        //     title: 'Erorr',
        //     posActionName: 'Ok');
        // print('No user found for that email.');
      }
    } catch (e) {
      ///todo: hide Loading
      navigator.hideLoading();

      ///todo: Show Massage
      navigator.showMyMessage(e.toString());
      // ///todo: hide Loading
      // DialogUtils.hideLoading(context);
      //
      // ///todo: Show Massage
      // DialogUtils.showMassage(
      //     context: context,
      //     content: e.toString(),
      //     title: 'Erorr',
      //     posActionName: 'Ok');

      print(e.toString());
    }
  }
}
