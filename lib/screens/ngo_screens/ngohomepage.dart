import 'package:donation_app/screens/ngo_screens/accepted_donation/accepted_donation_screen.dart';
import 'package:donation_app/screens/ngo_screens/supplier/supplier_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:donation_app/controllers/ngo_controllers/ngo_home_page_controller.dart';
import 'package:donation_app/screens/ngo_screens/dashboard_screen.dart';
import 'package:donation_app/screens/ngo_screens/history/history_screen.dart';
import 'package:donation_app/screens/ngo_screens/profile/ngo_profile.dart';
import 'package:donation_app/screens/ngo_screens/supplier/supplier_list_screen.dart';
import 'package:get/get.dart';
import 'package:donation_app/widgets/app_text.dart';

import '../../demo/test.dart';

class NGOHomePage extends StatelessWidget {
  late BuildContext appContext;
  //
  NGOHomePage({Key? key}) : super(key: key);

  
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
  final NGOHomePageController homePageController =
      Get.put(NGOHomePageController());

  //
  final List<Widget> pages = [
    DashboardScreen(),
    //AcceptedDonationScreen(),
    HistorySCreen(),
    SupplierListScreen(),
    NGOProfile(),
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
      
                //
                // getBottomBarItem(
                //     Icon(
                //       Icons.check_box_outlined,
                //       size: 22,
                //     ),
                //     label: 'Accepted'),
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
                    label: 'Suppliers'),
                getBottomBarItem(
                    Icon(
                      Icons.person_outlined,
                      size: 22,
                    ),
                    label: 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );

    //
  }

/*
bottomNavigationBar: Obx(
        () => SalomonBottomBar(
          //
          currentIndex: dashboardController.currentIndex.value,
          //
          onTap: dashboardController.onBottomOptionTap,
          itemPadding: EdgeInsets.only(left: 20, right: 20, top: 6, bottom: 6),
          //
          items: [
            getBottomBarItem('clock.png', 'Dashboard'),
            getBottomBarItem('menu.png', 'Menus'),
            getBottomBarItem('chef.png', 'Staff'),
            getBottomBarItem('records.png', 'Records'),
          ],
        ),
      ),
*/
  //
  BottomNavigationBarItem getBottomBarItem(Widget icon, {label}) {
    return BottomNavigationBarItem(
        // icon: Image.asset(
        //   'images/$icon',
        //   height: 30,
        // ),
        icon: icon,
        label: label

        //label: text,
        // backgroundColor: Get.theme.colorScheme.onPrimary,

        //textColor: Get.theme.colorScheme.primary,

        //selectedColor: Colors.purple,
        );
  }
}
