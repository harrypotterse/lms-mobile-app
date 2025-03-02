import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/data/model/course_details_response/course_details_response.dart';
import 'package:lms/screen/home/course_details/course_details_screen/content/course_details_content.dart';
import 'package:lms/screen/home/course_details/course_details_screen/content/details_button_content.dart';
import 'package:lms/screen/home/course_details/course_details_screen/course_details_provider.dart';
import 'package:lms/screen/home/home_screen/content/home_shimmer.dart';
import 'package:lms/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class CourseDetailsScreen extends StatelessWidget {
  final int? id;

  const CourseDetailsScreen({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CourseDetailsProvider(id),
      child: Consumer<CourseDetailsProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(70.h),
              child: const CustomAppBar(appBarName: 'Details'),
            ),
            body: FutureBuilder<CourseDetailsResponse?>(
                future: provider.courseDetailsApi(id),
                builder: (context, state) {
                  if (state.hasData) {
                    return Column(
                      children: [
                        CourseDetailsContent(
                            id: id, provider: provider, state: state),
                        DetailsButtonContent(
                          provider: provider,
                        )
                      ],
                    );
                  } else {
                    return const HomeShimmer();
                  }
                }),
          );
        },
      ),
    );
  }
}
