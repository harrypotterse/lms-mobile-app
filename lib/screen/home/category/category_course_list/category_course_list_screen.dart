import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/screen/home/category/category_course_list/category_course_list_provider.dart';
import 'package:lms/screen/home/course_details/course_details_screen/course_details_screen.dart';
import 'package:lms/screen/home/widgets/enrole_now_button.dart';
import 'package:lms/utils/app_consts.dart';
import 'package:lms/utils/nav_utail.dart';
import 'package:lms/widgets/custom_app_bar.dart';
import 'package:lms/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class CategoryCourseListPage extends StatelessWidget {
  final int? categoryId;

  const CategoryCourseListPage({Key? key, this.categoryId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CategoryCourseListProvider(categoryId),
      child: Consumer<CategoryCourseListProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(70.h),
              child: CustomAppBar(
                  appBarName:
                      '${provider.categoryDetailsResponse?.data?.category?.title ?? ''} Courses'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: GridView.builder(
                        itemCount: provider.categoryDetailsResponse?.data
                                ?.courses?.length ??
                            0,
                        itemBuilder: (context, index) {
                          var coursesData = provider
                              .categoryDetailsResponse?.data?.courses?[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CourseDetailsScreen(
                                          id: coursesData?.id)));
                            },
                            child: Card(
                              elevation: 0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: CachedNetworkImage(
                                        height: 140.h,
                                        fit: BoxFit.cover,
                                        imageUrl: coursesData?.image ?? "",
                                        placeholder: (context, url) => Center(
                                          child: Image.asset(
                                              "assets/home_page/ic_no_image.png"),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                                "assets/home_page/ic_no_image.png"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: coursesData?.title ?? "",
                                          color: AppColors.title,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          maxLine: 1,
                                        ),
                                        SizedBox(
                                          height: 12.h,
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/trending_courses/star_vector.png',
                                              height: 13.h,
                                            ),
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                            CustomText(
                                              text: coursesData?.rate
                                                  ?.toStringAsFixed(2),
                                              color: AppColors.title,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            SizedBox(
                                              width: 6.w,
                                            ),
                                            CustomText(
                                              text:
                                                  '(${coursesData?.rate?.toStringAsFixed(2)} Reviews)',
                                              color: AppColors.body,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Row(
                                        children: [
                                          CustomText(
                                            text:
                                                coursesData?.price.toString() ??
                                                    "",
                                            color: AppColors.title,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          const Spacer(),
                                          // settingProvider.baseSettingsResponse?.data
                                          //             ?.paymentGateway ==
                                          //         "1"
                                          //     ?
                                          EnroleNowButton(
                                            onTouch: () {
                                              NavUtil.navigateScreen(
                                                  context,
                                                  CourseDetailsScreen(
                                                    id: coursesData?.id,
                                                  ));
                                            },
                                          )
                                          // : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisExtent: 290.h,
                            mainAxisSpacing: 24),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
