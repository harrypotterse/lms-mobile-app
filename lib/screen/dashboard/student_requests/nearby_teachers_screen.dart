import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lms/screen/dashboard/student_requests/nearby_teachers_provider.dart';
import 'package:lms/screen/dashboard/student_requests/create_request_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/utils/app_consts.dart';
import 'package:lms/data/model/teacher_request/nearby_teachers_response.dart';
import 'package:lms/screen/dashboard/student_requests/student_requests_screen.dart';

class NearbyTeachersScreen extends StatefulWidget {
  const NearbyTeachersScreen({Key? key}) : super(key: key);

  @override
  State<NearbyTeachersScreen> createState() => _NearbyTeachersScreenState();
}

class _NearbyTeachersScreenState extends State<NearbyTeachersScreen> {
  @override
  void initState() {
    super.initState();
    // جلب المدرسين عند فتح الشاشة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NearbyTeachersProvider>().getNearbyTeachers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // خلفية رمادية فاتحة
      appBar: AppBar(
        title: const Text(
          'المدرسين القريبين',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StudentRequestsScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              context.read<NearbyTeachersProvider>().getNearbyTeachers();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // حقل البحث
          Padding(
            padding: EdgeInsets.all(16.r),
            child: TextField(
              onChanged: (value) {
                context.read<NearbyTeachersProvider>().setSearchQuery(value);
              },
              decoration: InputDecoration(
                hintText: 'ابحث عن مدرس...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
          
          // قائمة المدرسين
          Expanded(
            child: Consumer<NearbyTeachersProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.filteredTeachers.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_search,
                          size: 70.r,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16.h),
                        const Text(
                          'لا يوجد مدرسين حاليًا',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.all(16.r),
                  itemCount: provider.filteredTeachers.length,
                  itemBuilder: (context, index) {
                    final teacher = provider.filteredTeachers[index];
                    return TeacherCard(teacher: teacher);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TeacherCard extends StatelessWidget {
  final Teacher teacher;

  const TeacherCard({Key? key, required this.teacher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (teacher.id == null) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 16.r),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        onTap: () {
          if (teacher.id != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateRequestScreen(teacher: teacher),
              ),
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: AppColors.primary,
                child: Text(
                  teacher.name?.substring(0, 1).toUpperCase() ?? 'T',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      teacher.name ?? '',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      teacher.email ?? '',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                    if (teacher.cityName != null || teacher.provinceName != null)
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Text(
                          [
                            teacher.nationCity,
                            teacher.provinceName,
                            teacher.cityName
                          ].where((item) => item != null && item.isNotEmpty).join(' - '),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    if (teacher.distanceText != null && teacher.distanceText != '0 km')
                      Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: Text(
                          'المسافة: ${teacher.distanceText}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 20.r,
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 