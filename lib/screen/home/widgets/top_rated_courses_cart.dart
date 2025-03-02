import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/utils/app_consts.dart';
import 'package:lms/widgets/custom_text.dart';

class TopRatedCourses extends StatelessWidget {
  final String? image, title, subTitle, rate;
  final int? reviewsCount, amount;
  final Function()? onTap;

  const TopRatedCourses(
      {Key? key,
      this.image,
      this.amount,
      this.onTap,
      this.title,
      this.subTitle,
      this.rate,
      this.reviewsCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary.withOpacity(0.1)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                height: 100.0,
                fit: BoxFit.cover,
                imageUrl: image ?? "",
                placeholder: (context, url) => Center(
                  child: Image.asset("assets/home_page/ic_no_image.png"),
                ),
                errorWidget: (context, url, error) =>
                    Image.asset("assets/home_page/ic_no_image.png"),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: title ?? "",
                    color: AppColors.title,
                    fontSize: 14.sp,
                    maxLine: 1,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: 'by',
                        color: AppColors.body,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Expanded(
                        child: CustomText(
                          text: subTitle ?? "",
                          color: AppColors.body,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          maxLine: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Row(
                children: [
                  CustomText(
                    text: "\$ ${amount.toString()}",
                    color: AppColors.body,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  const Spacer(),
                  CustomText(
                    text: 'See Details',
                    color: AppColors.primary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
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
