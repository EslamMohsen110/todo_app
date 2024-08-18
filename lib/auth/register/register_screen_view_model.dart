import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/auth/register/register_navigator.dart';

import '../../widgets/dialog_utils.dart';

class RegisterScreenViewModel extends ChangeNotifier {
  /// Hold Data - Handle Logic
  var globalKey = GlobalKey<FormState>();
  late RegisterNavigator navigator;

  void register(String email, String password) async {
    ///register
    ///todo: Show Loading
    navigator.showLoading("Loading...");
    // DialogUtils.showLoading(context: context, massage: 'Loading...');
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // MyUser myUser = MyUser(
      //   id: credential.user?.uid ?? '',
      //   name: userNameController.text,
      //   email: emailController.text,
      // );
      // var authUserProvider =
      // Provider.of<AuthUserProvider>(context, listen: false);
      // authUserProvider.updateUser(myUser);
      // FirebaseUtils.addUserToFireStore(myUser);
      ///todo: hide Loading
      navigator.hideLoading();

      ///todo: Show Massage
      navigator.showMyMessage('Register Successflly');
      // DialogUtils.showMassage(
      //   context: context,
      //   content: 'Register Successflly',
      //   title: 'Success',
      //   posActionName: 'Ok',
      //   postAction: () {
      //     Navigator.of(context).pushNamedAndRemoveUntil(
      //       HomeScreen.routeName,
      //           (route) => false,
      //     );
      //   },
      // );
      print(credential.user?.uid ?? '');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ///todo: hide Loading
        navigator.hideLoading();

        ///todo: Show Massage
        navigator.showMyMessage('The password provided is too weak.');
        // ///todo: hide Loading
        // DialogUtils.hideLoading(context);
        //
        // ///todo: Show Massage
        // DialogUtils.showMassage(
        //     context: context,
        //     content: 'The password provided is too weak.',
        //     title: 'Error',
        //     posActionName: 'Ok');
      } else if (e.code == 'email-already-in-use') {
        ///todo: hide Loading
        navigator.hideLoading();

        ///todo: Show Massage
        navigator.showMyMessage('The account already exists for that email.');
        // ///todo: hide Loading
        // DialogUtils.hideLoading(context);
        // ///todo: Show Massage
        // DialogUtils.showMassage(
        //     context: context,
        //     content: 'The account already exists for that email.',
        //     title: 'Error',
        //     posActionName: 'Ok'
        //     );
      }
    } catch (e) {
      ///todo: hide Loading
      navigator.hideLoading();

      ///todo: Show Massage
      navigator.showMyMessage(e.toString());
      // ///todo: hide Loading
      // DialogUtils.hideLoading(context);
      // ///todo: Show Massage
      // DialogUtils.showMassage(
      //   context: context,
      //   content: e.toString(),
      //   title: 'Error',
      // );
      print(e.toString());
    }
  }
}
