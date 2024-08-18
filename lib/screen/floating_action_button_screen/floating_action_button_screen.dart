import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase/firebase_utils/firebase_utils.dart';
import 'package:todo_app/provider/auth_user_provider.dart';
import 'package:todo_app/resoures/model/title_model.dart';

import '../../provider/my_provider.dart';
import '../../resoures/color/color_app.dart';

class FloatingActionButtonScreen extends StatefulWidget {
  const FloatingActionButtonScreen({super.key});

  @override
  State<FloatingActionButtonScreen> createState() =>
      _FloatingActionButtonScreenState();
}

class _FloatingActionButtonScreenState
    extends State<FloatingActionButtonScreen> {
  final globalKey = GlobalKey<FormState>();
  var selectData = DateTime.now();
  String title = '';
  String description = '';
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    listProvider = Provider.of<ListProvider>(context);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: globalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add new Task',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextFormField(
              onChanged: (text) {
                title = text;
              },
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Enter your task';
                }
                return null;
              },
              style: Theme.of(context).textTheme.headlineSmall,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                    color: provider.isLight()
                        ? ColorApp.cWhiteColor
                        : ColorApp.cBlackColor),
                hintText: 'Enter your task Title',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onChanged: (text) {
                description = text;
              },
              style: Theme.of(context).textTheme.headlineSmall,
              maxLines: 4,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Enter your task';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Enter your task Description',
              ),
            ),
            Text('Select time',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                showCalender();
              },
              child: Text(
                  '${selectData.day}/${selectData.month}/${selectData.year}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelSmall),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                vaildTextFiled();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorApp.cPrimaryColor),
              child: Text(
                'Add',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: ColorApp.cWhiteColor),
              ),
            )
          ],
        ),
      ),
    );
  }

  void vaildTextFiled() {
    if (globalKey.currentState!.validate() == true) {
      TaskModels taskModel = TaskModels(
        title: title,
        description: description,
        dateTime: selectData,
      );
      var authUserProvider =
          Provider.of<AuthUserProvider>(context, listen: false);
      FirebaseUtils.addTaskToFireStore(
              taskModel, authUserProvider.currentUser!.id!)
          .then(
        (value) {
          listProvider
              .getAllTasksFromFireStore(authUserProvider.currentUser!.id!);
          Navigator.pop(context);
        },
      ).timeout(
        const Duration(seconds: 1),
        onTimeout: () {
          listProvider
              .getAllTasksFromFireStore(authUserProvider.currentUser!.id!);
          Navigator.pop(context);
        },
      );
    }
  }

  void showCalender() async {
    var showData = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );
    selectData = showData ?? selectData;
    setState(() {});
  }
}
