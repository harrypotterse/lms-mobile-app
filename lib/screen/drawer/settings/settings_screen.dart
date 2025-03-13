import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/screen/auth/splash_screen/splash_screen.dart';
import 'package:lms/screen/drawer/settings/about_us/about_us.dart';
import 'package:lms/screen/profile/edit_profile_screen/edit_profile_screen.dart';
import 'package:lms/utils/app_consts.dart';
import 'package:lms/utils/nav_utail.dart';
import 'package:lms/utils/shared_preferences.dart';
import 'package:lms/widgets/custom_app_bar.dart';
import 'package:lms/widgets/custom_text.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: const CustomAppBar(appBarName: 'الإعدادات'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutUs(),
                    ));
              },
              child: Row(
                children: [
                  Image.asset(
                    'assets/home_page/about_us_icon.png',
                    height: 36.h,
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  CustomText(
                    text: 'معلومات عنا',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.body,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfileScreen(),
                    ));
              },
              child: Row(
                children: [
                  Image.asset(
                    'assets/home_page/about_us_icon.png',
                    height: 36.h,
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  CustomText(
                    text: 'تعديل الملف الشخصي',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.body,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              onTap: () {
                logOut(context);
              },
              child: Row(
                children: [
                  Image.asset(
                    'assets/home_page/logout_icon.png',
                    height: 36.h,
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  CustomText(
                    text: 'تسجيل الخروج',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.body,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void logOut(context) async {
  await SPUtill.deleteKey(
    SPUtill.keyAuthToken,
  );
  await SPUtill.deleteKey(
    SPUtill.keyName,
  );
  await SPUtill.deleteKey(
    SPUtill.keyEmail,
  );
  await SPUtill.deleteKey(
    SPUtill.keyMobile,
  );
  await SPUtill.deleteKey(
    SPUtill.keyAvatar,
  );
  await SPUtill.deleteKey(
    SPUtill.keyStatus,
  );
  await SPUtill.deleteKey(
    SPUtill.keyJoinDate,
  );
  await SPUtill.deleteKey(
    SPUtill.keyDateBirth,
  );
  NavUtil.pushAndRemoveUntil(context, const SplashScreen());
}
