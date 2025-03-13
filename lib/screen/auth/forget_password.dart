import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/screen/auth/authentication_code.dart';
import 'package:lms/screen/auth/widgets/elevated_button_widget.dart';
import 'package:lms/utils/app_consts.dart';
import 'package:lms/widgets/custom_text.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40.h,
              ),
              CustomText(
                text: 'نسيت كلمة المرور',
                color: AppColors.title,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                height: 0,
              ),
              SizedBox(
                height: 54.h,
              ),
              Center(
                child: Image.asset(
                  'assets/auth_image/foget_pass_img.png',
                  height: 200.h,
                  width: 241.sp,
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              const CustomText(
                text:
                    'اختر طريقة الاتصال التي يجب استخدامها\nلإعادة تعيين كلمة المرور.',
              ),
              SizedBox(
                height: 40.h,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.primary),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.h),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/auth_image/chat_vector.png',
                        height: 50.h,
                        width: 50.w,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "عبر الرسائل القصيرة",
                            color: AppColors.body,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: 4.sp,
                          ),
                          CustomText(
                            text: "+633 *** ****36",
                            color: AppColors.title,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 12.sp,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.border),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.h),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/auth_image/send_vector.png',
                        height: 50.h,
                        width: 50.w,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "عبر البريد الإلكتروني",
                            color: AppColors.body,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: 4.sp,
                          ),
                          CustomText(
                            text: "jerry***@gmail.com",
                            color: AppColors.title,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 45.h,
              ),
              ElevatedbuttonWidget(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthenticationCodeScreen(),
                      ));
                },
                text: "متابعة",
              )
            ],
          ),
        ),
      )),
    );
  }
}
