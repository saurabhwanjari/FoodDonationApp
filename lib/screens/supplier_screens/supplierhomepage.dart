import 'package:donation_app/demo/test.dart';
import 'package:donation_app/screens/ngo_screens/supplier/supplier_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:donation_app/controllers/supplier_controllers/supplier_home_page_controller.dart';
import 'package:donation_app/screens/supplier_screens/dashboard_screen.dart';
import 'package:donation_app/screens/supplier_screens/history/history_screen.dart';
import 'package:donation_app/screens/supplier_screens/ngo/ngo_list_screen.dart';
import 'package:donation_app/screens/supplier_screens/profile/supplier_profile.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:get/get.dart';

class SupplierHomePage extends StatelessWidget {
  late BuildContext appContext;
  //
  SupplierHomePage({Key? key}) : super(key: key);

  //Alert Exit Confirm Function
  Future<bool> exitConfirm() async {
    Future<bool> value = Future.value(false);

    AlertDialog alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
      title: AppText(
        'Are your sure to exit?',
        isBold: true,
        textAlign: TextAlign.center,
        size: 20,
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Yes
            Container(
              width: 100,
              margin: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: Get.theme.colorScheme.primary, width: 1),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(appContext);
                  value = Future.value(true);
                },
                child: AppText(
                  "Yes",
                  textType: TextType.normal,
                  isBold: true,
                  textColor: Get.theme.colorScheme.primary,
                ),
              ),
            ),

            //No
            Container(
              width: 100,
              margin: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: Get.theme.colorScheme.primary, width: 1),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(appContext);
                  value = Future.value(false);
                },
                child: AppText(
                  "No",
                  textType: TextType.normal,
                  isBold: true,
                  textColor: Get.theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        )
      ],
    );

    await showDialog(
        context: appContext, builder: (BuildContext context) => alertDialog);

    return value;
  }

  final SupplierHomePageController homePageController =
      Get.put(SupplierHomePageController());

  //
  final List<Widget> pages = [
    DashboardScreen(),
    HistorySCreen(), // -------------------------> Main Pages to be loaded
    NGOListScreen(), // -------------------------> Main Pages to be loaded
    //TestPage(),
    SupplierProfile(),
    // TestPage(),
    // TestPage(),
    // TestPage(),
  ];

  //
  @override
  Widget build(BuildContext context) {
    appContext = context;
    //
    return Obx(
      () => WillPopScope(
        onWillPop: exitConfirm,
        child: Scaffold(
          //-----------------------------------
          body: pages[homePageController.currentIndex.value],
      
          //
          //
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
              //
              backgroundColor: Colors.white,
              //fixedColor: Colors.white,
      
              //
              elevation: 5,
              //
              currentIndex: homePageController.currentIndex.value,
      
              //
              selectedItemColor: Get.theme.colorScheme.primary,
              unselectedItemColor: Get.theme.colorScheme.onSecondary,
              selectedFontSize: 13,
              unselectedFontSize: 13,
              showUnselectedLabels: true,
      
              //
              type: BottomNavigationBarType.fixed,
      
              //
              onTap: homePageController.onBottomOptionTap,
              // itemPadding:
              //     EdgeInsets.only(left: 20, right: 20, top: 6, bottom: 6),
              //
              items: [
                //TabData(icon: Icons.home,title: ),
      
                getBottomBarItem(
                    Icon(
                      Icons.handshake_outlined,
                      size: 22,
                    ),
                    label: 'Donation'),
                getBottomBarItem(
                    Icon(
                      Icons.calendar_month_outlined,
                      size: 22,
                    ),
                    label: 'History'),
                getBottomBarItem(
                    Icon(
                      Icons.people_outline,
                      size: 22,
                    ),
                    label: 'NGOs'),
                getBottomBarItem(
                    Icon(
                      Icons.person_outlined,
                      size: 22,
                    ),
                    label: 'Profile'),
                // getBottomBarItem('food.jpg', 'Donations'),
                // getBottomBarItem('history.png', 'Menus'),
                // getBottomBarItem('ngo1.png', 'Staff'),
                // getBottomBarItem('profile.png', 'Records'),
              ],
            ),
          ),
      
          //
          //
        ),
      ),
    );

    //
  }

  //
  BottomNavigationBarItem getBottomBarItem(Widget icon, {label}) {
    return BottomNavigationBarItem(icon: icon, label: label);
  }
}
