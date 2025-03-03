import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lms/screen/dashboard/student_requests/nearby_teachers_provider.dart';
import 'package:lms/screen/dashboard/student_requests/create_request_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/utils/app_consts.dart';
import 'package:lms/data/model/teacher_request/nearby_teachers_response.dart';
import 'package:lms/screen/dashboard/student_requests/student_requests_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lms/screen/dashboard/student_requests/student_requests_provider.dart';

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
            _showCreateRequestModal(context, teacher);
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

  void _showCreateRequestModal(BuildContext parentContext, Teacher teacher) {
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    final subjectController = TextEditingController();
    final reasonController = TextEditingController();

    final nearbyTeachersProvider = Provider.of<NearbyTeachersProvider>(parentContext, listen: false);
    final studentRequestsProvider = Provider.of<StudentRequestsProvider>(parentContext, listen: false);

    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              ),
              child: Row(
                children: [
                  Text(
                    'إنشاء طلب جديد',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            
            // Form
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.r),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // معلومات المدرس
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primary,
                          child: Text(
                            teacher.name?.substring(0, 1).toUpperCase() ?? 'T',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(teacher.name ?? ''),
                        subtitle: Text(teacher.email ?? ''),
                      ),
                      SizedBox(height: 24.h),
                      
                      // حقول الإدخال
                      TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                          labelText: 'عنوان الطلب',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        validator: (value) => value?.isEmpty == true 
                            ? 'يرجى إدخال عنوان الطلب' 
                            : null,
                      ),
                      SizedBox(height: 16.h),
                      
                      TextFormField(
                        controller: subjectController,
                        decoration: InputDecoration(
                          labelText: 'الموضوع',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        validator: (value) => value?.isEmpty == true 
                            ? 'يرجى إدخال الموضوع' 
                            : null,
                      ),
                      SizedBox(height: 16.h),
                      
                      TextFormField(
                        controller: reasonController,
                        decoration: InputDecoration(
                          labelText: 'سبب الطلب',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        maxLines: 3,
                        validator: (value) => value?.isEmpty == true 
                            ? 'يرجى إدخال سبب الطلب' 
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // زر الإرسال
            Padding(
              padding: EdgeInsets.all(16.r),
              child: SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  onPressed: () async {
                    if (formKey.currentState?.validate() == true) {
                      try {
                        EasyLoading.show(status: 'جاري إرسال الطلب...');
                        
                        final success = await nearbyTeachersProvider.createRequest(
                          title: titleController.text.trim(),
                          reason: reasonController.text.trim(),
                          subject: subjectController.text.trim(),
                          teacherId: teacher.id!,
                        );
                        
                        if (success) {
                          await studentRequestsProvider.getStudentRequests();
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                            msg: 'تم إرسال الطلب بنجاح',
                            backgroundColor: Colors.green,
                            toastLength: Toast.LENGTH_LONG,
                          );
                        }
                      } finally {
                        EasyLoading.dismiss();
                      }
                    }
                  },
                  child: Text(
                    'إرسال الطلب',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 