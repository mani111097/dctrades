import 'package:dctradesadmin/Pages/account.dart';
import 'package:dctradesadmin/Pages/investment.dart';
import 'package:dctradesadmin/Pages/loan.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

class Mainpage extends StatefulWidget {
  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  PageController page = PageController();

  @override
  Widget build(BuildContext context) {
    List<SideMenuItem> item = [
      SideMenuItem(
        priority: 0,
        title: 'Account',
        onTap: () {
          page.jumpToPage(0);
        },
        icon: Icons.account_circle_rounded,
      ),
      SideMenuItem(
          priority: 1,
          title: 'Investment',
          onTap: () {
            page.jumpToPage(1);
          },
          icon: Icons.local_activity_outlined),
      SideMenuItem(
        priority: 2,
        title: 'Loan',
        onTap: () {
          page.jumpToPage(2);
        },
        icon: Icons.file_copy_rounded,
      ),
      SideMenuItem(
        priority: 3,
        title: 'Products',
        onTap: () {
          page.jumpToPage(3);
        },
        icon: Icons.production_quantity_limits_outlined,
      ),
      SideMenuItem(
        priority: 4,
        title: 'Services',
        onTap: () {
          page.jumpToPage(4);
        },
        icon: Icons.settings,
      ),
      // SideMenuItem(
      //   priority: 6,
      //   title: 'Exit',
      //   onTap: () async {},
      //   icon: Icons.exit_to_app,
      // ),
    ];
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("DC Groups"),
      // ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
              controller: page,
              style: SideMenuStyle(

                  //hoverColor: Colors.amber[50],
                  selectedColor: Color.fromARGB(255, 6, 37, 53),
                  selectedTitleTextStyle: TextStyle(color: Colors.amber),
                  unselectedTitleTextStyle: TextStyle(color: Colors.white),
                  selectedIconColor: Colors.amber,
                  unselectedIconColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 6, 37, 53),
                  openSideMenuWidth: 200),
              title: Column(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 150,
                      maxWidth: 150,
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'images/dctechno.png',
                          color: Colors.white,
                        ),
                        Text(
                          "DC Groups",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    indent: 8.0,
                    endIndent: 8.0,
                  ),
                ],
              ),
              //
              items: item),
          Expanded(
            child: PageView(
              controller: page,
              children: [
                Account(),
                Investment(),
                Loan(),
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Coming Soon',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Coming Soon',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
