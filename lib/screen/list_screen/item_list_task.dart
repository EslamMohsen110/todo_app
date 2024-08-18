import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase/firebase_utils/firebase_utils.dart';
import 'package:todo_app/provider/auth_user_provider.dart';
import 'package:todo_app/provider/my_provider.dart';
import 'package:todo_app/screen/edit_task/edit_task.dart';
import '../../resoures/color/color_app.dart';
import '../../resoures/model/title_model.dart';

class ItemListTask extends StatelessWidget {
  TaskModels taskModel;

  ItemListTask({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var authUserProvider = Provider.of<AuthUserProvider>(context);
    return Column(
      children: [
        Slidable(
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.25,
            children: [
              SlidableAction(
                borderRadius: BorderRadius.circular(20),
                onPressed: (context) {
                  FirebaseUtils.deleteTaskFromFirebase(
                          taskModel, authUserProvider.currentUser!.id!)
                      .then((value) =>

                          ///Delete Task
                          listProvider.getAllTasksFromFireStore(
                              authUserProvider.currentUser!.id!))
                      .timeout(
                    Duration.zero,
                    onTimeout: () {
                      ///Delete Task
                      listProvider.getAllTasksFromFireStore(
                          authUserProvider.currentUser!.id!);
                    },
                  );
                },
                backgroundColor: ColorApp.cRedColor,
                foregroundColor: ColorApp.cWhiteColor,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(EditTask.routeName);
            },
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * 0.11,
                    width: MediaQuery.of(context).size.width * 0.01,
                    decoration: BoxDecoration(
                      color: ColorApp.cPrimaryColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(taskModel.title),
                        Text(
                          taskModel.description,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.check,
                        size: 26,
                      ),
                      color: ColorApp.cWhiteColor,
                      style: IconButton.styleFrom(
                        backgroundColor: ColorApp.cPrimaryColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(10),
                            left: Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
