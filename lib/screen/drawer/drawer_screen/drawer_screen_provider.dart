import 'package:flutter/material.dart';
import 'package:lms/utils/shared_preferences.dart';

class DrawerScreenProvider extends ChangeNotifier {
  String? userName;
  String? userAvatar;
  String? userJoinDate;
  String? userEmail;
  String? roleName;
  String? userId;

  DrawerScreenProvider() {
    getUserData();
  }

  void getUserData() async {
    userName = await SPUtill.getValue(SPUtill.keyName);
    userAvatar = await SPUtill.getValue(SPUtill.keyAvatar);
    userJoinDate = await SPUtill.getValue(SPUtill.keyJoinDate);
    userEmail = await SPUtill.getValue(SPUtill.keyEmail);
    userId = await SPUtill.getValue(SPUtill.keyUserId);
    roleName = await SPUtill.getValue(SPUtill.keyRoleName);

    notifyListeners();
  }
}
