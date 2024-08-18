import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/my_provider.dart';
import '../../provider/auth_user_provider.dart';
import '../../resoures/color/color_app.dart';
import 'item_list_task.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var authUserProvider = Provider.of<AuthUserProvider>(context);
    if (listProvider.listTask.isEmpty) {
      listProvider.getAllTasksFromFireStore(authUserProvider.currentUser!.id!);
    }
    return Column(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              color: ColorApp.cPrimaryColor,
              height: MediaQuery.of(context).size.height * 0.14,
            ),
            EasyDateTimeLine(
              initialDate: listProvider.selectDate,
              onDateChange: (selectedDate) {
                listProvider.changeDateTime(
                    selectedDate, authUserProvider.currentUser!.id!);
              },
              activeColor: const Color(0xff00629b),
              headerProps: const EasyHeaderProps(
                monthPickerType: MonthPickerType.switcher,
                dateFormatter: DateFormatter.fullDateDMY(),
              ),
              dayProps: const EasyDayProps(
                activeDayStyle: DayStyle(
                  borderRadius: 32.0,
                ),
                inactiveDayStyle: DayStyle(
                  decoration: BoxDecoration(
                      color: ColorApp.cWhiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  borderRadius: 32.0,
                ),
              ),
              timeLineProps: const EasyTimeLineProps(
                hPadding: 16.0, // padding from left and right
                separatorPadding: 16.0, // padding between days
              ),
            )
          ],
        ),
        const SizedBox(height: 6),
        Expanded(
          child: ListView.builder(
            itemCount: listProvider.listTask.length,
            itemBuilder: (context, index) {
              return ItemListTask(taskModel: listProvider.listTask[index]);
            },
          ),
        ),
      ],
    );
  }
}
