import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/screen/dashboard/dashboard_screen_provider.dart';
import 'package:lms/screen/dashboard/widgets/account_balance_cart.dart';
import 'package:lms/screen/dashboard/widgets/summary_cart.dart';
import 'package:lms/screen/drawer/widgets/all_assignment_list_cart.dart';
import 'package:lms/screen/dashboard/teacher_requests/teacher_requests_screen.dart';
import 'package:lms/screen/dashboard/student_requests/nearby_teachers_screen.dart';
import 'package:lms/utils/app_consts.dart';
import 'package:lms/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:lms/screen/dashboard/student_requests/nearby_teachers_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardScreenProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SummaryCart(
                          image: "assets/home_page/dash_one.png",
                          total: provider.dashboardResponse?.data?.courseCount
                                  .toString() ??
                              '',
                          type: "Courses",
                          title: "Courses Count",
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: SummaryCart(
                          image: "assets/home_page/dash_two.png",
                          total: provider
                                  .dashboardResponse?.data?.purchaseAmounts
                                  .toString() ??
                              '',
                          type: "Purchase",
                          title: "Purchase Count",
                        ),
                      ),
                    ],
                  ),
                  // SummaryContent(
                  //     dashboardResponse: provider.dashboardResponse),
                  SizedBox(
                    height: 20.h,
                  ),
                  AccountBalanceCart(
                      dashboardResponse: provider.dashboardResponse),
                  SizedBox(
                    height: 34.h,
                  ),
                  CustomText(
                    text: "Assignment",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.title,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        provider.dashboardResponse?.data?.assignments?.length ??
                            0,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 3,
                    ),
                    itemBuilder: (context, index) {
                      final data =
                          provider.dashboardResponse?.data?.assignments?[index];
                      return AllAssignmentListCart(
                        title: data?.title,
                        details: data?.details,
                        status: data?.status,
                        deadline: data?.deadline,
                      );
                    },
                  ),
                  // زر طلبات الطلاب
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.assignment,
                        color: AppColors.primary,
                        size: 30.r,
                      ),
                      title: Text(
                        'طلبات الطلاب',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text('إدارة طلبات الطلاب والدردشة معهم'),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 20.r,
                        color: AppColors.primary,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TeacherRequestsScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  // زر البحث عن مدرسين (للطلاب)
                  SizedBox(height: 12.h),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.people,
                        color: AppColors.primary,
                        size: 30.r,
                      ),
                      title: Text(
                        'البحث عن مدرسين',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text('ابحث عن مدرسين قريبين وأرسل طلبات المساعدة'),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 20.r,
                        color: AppColors.primary,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                              create: (context) => NearbyTeachersProvider(),
                              child: const NearbyTeachersScreen(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
