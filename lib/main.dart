import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/login/login_screen.dart';
import 'package:todo_app/auth/register/register_screen.dart';
import 'package:todo_app/provider/auth_user_provider.dart';
import 'package:todo_app/provider/my_provider.dart';
import 'package:todo_app/resoures/theme/theme_app.dart';
import 'package:todo_app/screen/edit_task/edit_task.dart';
import 'screen/home_screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyCj5uQR2EydHCU6sQFZWNWj2XBJ1HVQmPo',
              appId: 'com.example.todo_app',
              messagingSenderId: '1089834875276',
              projectId: 'todo-app-ee82a'),
        )
      : await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyProvider()),
        ChangeNotifierProvider(create: (context) => ListProvider()),
        ChangeNotifierProvider(create: (context) => AuthUserProvider()),
      ],
      child: const MyApp(),
    ),
  );
  // await FirebaseFirestore.instance.disableNetwork();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return MaterialApp(
      theme: provider.isLight() ? ThemeApp.themeLight : ThemeApp.themeDark,
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        EditTask.routeName: (context) => EditTask(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
      },
    );
  }
}
