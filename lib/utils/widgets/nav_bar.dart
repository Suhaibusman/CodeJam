import 'package:codejam/controller/nav_bar_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:codejam/utils/themes/color_theme.dart';

class MyBottomNavbar extends StatelessWidget {
  final BottomNavBarController _bottomNavigationBarController =
      Get.put(BottomNavBarController());

  MyBottomNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: GetBuilder<BottomNavBarController>(
          builder: (context) {
            debugPrint(
                "index====>${_bottomNavigationBarController.currentIndex.value}");
            return PageStorage(
              bucket: PageStorageBucket(),
              child: _bottomNavigationBarController.currentScreen,
            );
          },
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: primarycolor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: GNav(
            backgroundColor: primarycolor,
            selectedIndex: _bottomNavigationBarController.currentIndex.value,
            onTabChange: (index) {
              _bottomNavigationBarController.changeScreen(index);
            },
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
            tabBorderRadius: 10,
            color: lightPrimaryTextColor,
            activeColor: btnPrimaryColor,
            tabBackgroundColor: white,
            gap: 8,
            tabMargin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            tabs: [
              GButton(
                onPressed: () {},
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                onPressed: () {
                },
                icon: Icons.location_on,
                text: 'Location',
              ),
              GButton(
                onPressed: () {
                },
                icon: CupertinoIcons.shopping_cart,
                text: 'Products',
              ),
              GButton(
                onPressed: () {
                },
                icon: CupertinoIcons.exclamationmark_shield_fill,
                text: 'Complaint',
              ),
              GButton(
                onPressed: () {},
                icon: Icons.person_2,
                text: 'Profile',
              ),
            ],
          ),
        ),
      );
    });
  }
}
