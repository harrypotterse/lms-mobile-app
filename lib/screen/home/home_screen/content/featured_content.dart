import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/screen/home/category/featured_category.dart';
import 'package:lms/screen/home/home_screen/home_provider.dart';
import 'package:lms/utils/app_consts.dart';
import 'package:lms/widgets/custom_text.dart';

import '../../../../data/model/home_response/home_response.dart';

class FeaturedContent extends StatelessWidget {
  final HomeProvider? provider;

  const FeaturedContent({super.key, this.provider});

  @override
  Widget build(BuildContext context) {

    var mainCategoriesList = [12, 13, 14, 213, 214, 215, 216];

    List<Category> otherCatList = <Category>[];

    for (int i = 0; i < provider!.categories!.length; i++){
      if (provider!.categories![i].subcategories!.isEmpty){
          otherCatList.add(provider!.categories![i]);
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
      child: Column(
        children: [
          for (int i = 0; i < provider!.categories!.length; i++)
            if (mainCategoriesList.contains(provider?.categories![i].id))
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomText(
                          text:
                              // provider.categories?.title ??
                              //"Featured Category",
                              provider?.categories?[i].title,
                          color: AppColors.title,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        const Spacer(),
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => const SeeAllCategory(),
                        //         ));
                        //   },
                        //   child: CustomText(
                        //     text: "See all",
                        //     color: AppColors.body,
                        //     fontSize: 14.sp,
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        // )
                      ],
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    FeaturedCategory(
                      categories: provider?.categories![i].subcategories,
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                  ],
                ),
              ),

              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomText(
                          text:
                          // provider.categories?.title ??
                          "Other Categories",
                          color: AppColors.title,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        const Spacer(),
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => const SeeAllCategory(),
                        //         ));
                        //   },
                        //   child: CustomText(
                        //     text: "See all",
                        //     color: AppColors.body,
                        //     fontSize: 14.sp,
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        // )
                      ],
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    FeaturedCategory(
                      categories: otherCatList,
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}
