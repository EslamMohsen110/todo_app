import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/resoures/model/my_user.dart';

import '../../resoures/model/title_model.dart';

class FirebaseUtils {
  late TaskModels taskModels;

  static CollectionReference<TaskModels> getTaskCollection(String uId) {
    return getUserCollection()
        .doc(uId)
        .collection(TaskModels.nameCollection)
        .withConverter<TaskModels>(
          fromFirestore: (snapshot, options) =>
              TaskModels.fromFireStore(snapshot.data()!),
          toFirestore: (task, options) => task.toFireStore(),
        );
  }

  static Future<void> addTaskToFireStore(TaskModels task, String uId) async {
    // return getTaskCollection().doc(task.id).set(task);
    var taskCollection = getTaskCollection(uId); // collection
    DocumentReference<TaskModels> taskDoc = taskCollection.doc(); // document
    task.id = taskDoc.id; //set model "id"
    return await taskDoc.set(task);
  }

  static Future<void> deleteTaskFromFirebase(
      TaskModels taskModels, String uId) {
    return getTaskCollection(uId).doc(taskModels.id).delete();
  }

  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFireStore(snapshot.data()!),
          toFirestore: (myUser, options) => myUser.toFireStore(),
        );
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUserCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFirebase(String uId) async {
    var querySnapShot = await getUserCollection().doc(uId).get();
    return querySnapShot.data();
  }

  static updataTaskFromFirebase(String uId) {
    getTaskCollection(uId).doc(uId).update({});
  }
// static updateTaskFromFirebase(TaskModels taskModels) {
//   return getTaskCollection().doc(taskModels.id).update({
//     'title': taskModels.title,
//     'description': taskModels.description,
//   });
// }
}
//   static CollectionReference<TaskModel> getTaskCollection() {
//     return FirebaseFirestore.instance.collection(TaskModel.collectionTask).withConverter<TaskModel>(
//             fromFirestore: (snapshot, options) =>TaskModel.fromJson(snapshot.data()!),
//             toFirestore: (task, options) => task.jsonTo());
//   }
//   static Future<void> addTaskToFirebase(TaskModel taskModel) ***************** {
//     var taskCollection = getTaskCollection();
//     DocumentReference<TaskModel> taskDocumentReference = taskCollection.doc();
//     taskModel.id = taskDocumentReference.id;
//     return ************ taskDocumentReference.set(taskModel);
//   }
// }
