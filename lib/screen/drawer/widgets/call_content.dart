import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/utils/app_consts.dart';
import 'package:lms/widgets/custom_text.dart';

class CallContent extends StatelessWidget {
  const CallContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          CallCart(),
          SizedBox(
            height: 16,
          ),
          CallCart(),
          SizedBox(
            height: 16,
          ),
          CallCart(),
          SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}

class CallCart extends StatelessWidget {
  const CallCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/mentors/message_icon.png',
              height: 48.h,
            ),
            SizedBox(
              width: 12.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8.h,
                ),
                CustomText(
                  text: 'Darlene Steward',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/mentors/incoming_icon.png',
                      height: 13,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    CustomText(
                      text: '04.30 PM',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.body,
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Image.asset(
              'assets/mentors/call_vector.png',
              height: 18.h,
            )
          ],
        ),
      ],
    );
  }
}
