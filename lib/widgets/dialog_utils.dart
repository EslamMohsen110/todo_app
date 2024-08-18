import 'package:flutter/material.dart';
import 'package:todo_app/resoures/color/color_app.dart';

class DialogUtils {
  ///Show Loading
  static void showLoading(
      {required BuildContext context, required String message}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(
                color: ColorApp.cPrimaryColor,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(message),
              ),
            ],
          ),
        );
      },
    );
  }

  ///Hide Loading
  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  ///Show Massage

  static void showMassage({
    required BuildContext context,
    required String content,
    String title = '',
    String? posActionName,
    Function? postAction,
    String? negActionName,
    Function? negAction,
  }) {
    List<Widget> action = [];
    if (posActionName != null) {
      action.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            // if(postAction!=null){
            //   postAction.call();
            // }
            postAction?.call();
          },
          child: Text(posActionName),
        ),
      );
    }
    if (negActionName != null) {
      action.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(negActionName),
        ),
      );
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            content,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: action,
        );
      },
    );
  }
}
