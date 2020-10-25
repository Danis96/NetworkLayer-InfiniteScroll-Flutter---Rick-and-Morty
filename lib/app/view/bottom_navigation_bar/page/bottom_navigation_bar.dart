import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBarView.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';
import 'package:rickAndMorty/app/view/home/pages/home_page.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  @override
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget>
    with TickerProviderStateMixin {
  MotionTabController _tabController;

  List<String> items = <String>[
    'Profile',
    'Home',
    'Dashboard',
  ];

  List<IconData> icons = <IconData>[
    Icons.account_box,
    Icons.home,
    Icons.menu,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = MotionTabController(
      initialIndex: 1,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MotionTabBar(
        labels: items,
        initialSelectedTab: 'Home',
        tabIconColor: Colors.black,
        tabSelectedColor: Colors.black,
        onTabItemSelected: (int value) {
          setState(() {
            _tabController.index = value;
          });
        },
        icons: icons,
        textStyle: const TextStyle(color: Colors.red),
      ),
      body: MotionTabBarView(
        controller: _tabController,
        children: <Widget>[
          Container(
            child: Center(
              child: Text("Account"),
            ),
          ),
          Home(),
          Container(
            child: Center(
              child: Text("Dashboard"),
            ),
          ),
        ],
      ),
    );
  }
}
