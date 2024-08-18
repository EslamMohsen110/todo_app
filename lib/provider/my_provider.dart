import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase/firebase_utils/firebase_utils.dart';
import '../resoures/model/title_model.dart';

class MyProvider extends ChangeNotifier {
  ThemeData themelight = ThemeData.light();
  String languageselected = 'en';

  changeTheme(ThemeData newTheme) {
    if (themelight == newTheme) {
      return;
    }

    themelight = newTheme;
    notifyListeners();
  }

  changelanguage(String newlanguage) {
    if (languageselected == newlanguage) {
      return;
    }

    languageselected = newlanguage;
    notifyListeners();
  }

  bool isLight() {
    return themelight == ThemeData.light();
  }
}

class ListProvider extends ChangeNotifier {
  List<TaskModels> listTask = [];
  DateTime selectDate = DateTime.now();

  void getAllTasksFromFireStore(String uId) async {
    QuerySnapshot<TaskModels> querySnapshot =
        await FirebaseUtils.getTaskCollection(uId).get();
    listTask = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    /// filter all task => select date.
    /// 30/7/2024
    listTask = listTask.where(
      (task) {
        if (selectDate.day == task.dateTime.day &&
            selectDate.month == task.dateTime.month &&
            selectDate.year == task.dateTime.year) {
          return true;
        }
        return false;
      },
    ).toList();

    /// Sorting Tasks
    listTask.sort(
      (TaskModels task1, TaskModels task2) {
        return task1.dateTime.compareTo(task2.dateTime);
      },
    );
    notifyListeners();
  }

  void changeDateTime(DateTime newSelectDataTime, String uId) {
    selectDate = newSelectDataTime;
    getAllTasksFromFireStore(uId);
  }
}
