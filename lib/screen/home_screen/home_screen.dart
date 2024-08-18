import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/login/login_screen.dart';
import 'package:todo_app/provider/auth_user_provider.dart';
import '../../provider/my_provider.dart';
import '../../resoures/color/color_app.dart';
import '../floating_action_button_screen/floating_action_button_screen.dart';
import '../list_screen/list_screen.dart';
import '../setting_screen/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'Home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  List<Widget> listData = [
    const ListScreen(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var authUserProvider = Provider.of<AuthUserProvider>(context);
    var listProvider = Provider.of<ListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('To DO List ${authUserProvider.currentUser!.name!}',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: ColorApp.cWhiteColor)),
        actions: [
          IconButton(
              onPressed: () {
                listProvider.listTask = [];
                authUserProvider.currentUser = null;
                Navigator.of(context).pushNamedAndRemoveUntil(
                  LoginScreen.routeName,
                  (route) => false,
                );
              },
              icon: Icon(
                Icons.logout,
                color: ColorApp.cWhiteColor,
              ))
        ],
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorApp.cPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
          side: BorderSide(
            color: provider.isLight()
                ? ColorApp.cWhiteColor
                : ColorApp.cBlackColor,
            width: 4,
          ),
        ),
        onPressed: () {
          showDetialsDailog(context);
        },
        child: Icon(
          Icons.add,
          color:
              provider.isLight() ? ColorApp.cWhiteColor : ColorApp.cBlackColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: MediaQuery.of(context).size.height * 0.09,
        notchMargin: 10,
        padding: EdgeInsets.zero,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          onTap: (value) {
            currentIndex = value;
            setState(() {});
          },
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list_rounded),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: '',
            ),
          ],
        ),
      ),
      body: Column(
        children: [Expanded(child: listData[currentIndex])],
      ),
    );
  }

  void showDetialsDailog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const FloatingActionButtonScreen(),
    );
  }
}
