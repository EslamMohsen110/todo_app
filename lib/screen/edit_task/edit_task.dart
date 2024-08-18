import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase/firebase_utils/firebase_utils.dart';
import 'package:todo_app/provider/my_provider.dart';

import '../../resoures/color/color_app.dart';

class EditTask extends StatefulWidget {
  static const String routeName = 'EditTask';

  EditTask({super.key});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final globalKey = GlobalKey<FormState>();

  var selectData = DateTime.now();
  String title = '';
  String description = '';
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    Provider.of<ListProvider>(context);
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('To DO List',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: ColorApp.cWhiteColor)),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  color: ColorApp.cPrimaryColor,
                  height: height * 0.14,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  height: height * 0.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorApp.cWhiteColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        onChanged: (text) {
                          title = text;
                          setState(() {});
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
                          hintText: 'This is title',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (text) {
                          description = text;
                          setState(() {});
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
                          hintText: 'Task details',
                        ),
                      ),
                      Text('Select time',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                            '${selectData.day}/${selectData.month}/${selectData.year}',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelSmall),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          FirebaseUtils.updataTaskFromFirebase(title);
                          Navigator.pop(context);
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
