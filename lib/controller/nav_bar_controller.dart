import 'package:codejam/view/homeview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBarController extends GetxController {
  RxInt currentIndex = 0.obs;

  @override
  onInit() {
    _currentScreen = const HomeView(
        // userName: currentLoginedName ?? box.read("currentloginedName")

        );
    currentIndex(0);
    super.onInit();
  }

  void onclose() {
    super.onClose();
  }

  Widget _currentScreen = const HomeView(
      // userName: box.read("currentloginedName") ?? "User"
      );

  Widget get currentScreen => _currentScreen;

  void changeScreen(int index) {
    currentIndex(index);
    switch (index) {
      case 0:
        _currentScreen = const HomeView();
        break;
      // case 1:
      //   _currentScreen = const TrackLocationView();
      //   break;
      // case 2:
      //   _currentScreen = FavouriteView();
      //   break;

      // case 3:
      //   _currentScreen = const ProfileView();
      //   break;
      default:
        break;
    }

    update();
  }
}
