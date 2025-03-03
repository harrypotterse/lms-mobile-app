import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lms/screen/dashboard/student_requests/nearby_teachers_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/utils/app_consts.dart';
import 'package:lms/data/model/teacher_request/nearby_teachers_response.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lms/screen/dashboard/student_requests/student_requests_screen.dart';

class CreateRequestScreen extends StatefulWidget {
  final Teacher teacher;
  
  const CreateRequestScreen({Key? key, required this.teacher}) : super(key: key);

  @override
  State<CreateRequestScreen> createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _subjectController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  // إرسال الطلب
  Future<void> _submitRequest() async {
    if (_formKey.currentState!.validate()) {
      try {
        EasyLoading.show(status: 'جاري إرسال الطلب...');
        
        final success = await context.read<NearbyTeachersProvider>().createRequest(
          title: _titleController.text.trim(),
          reason: _reasonController.text.trim(),
          subject: _subjectController.text.trim(),
          teacherId: widget.teacher.id!,
        );
        
        if (success && mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) => StudentRequestsProvider(),
                child: const StudentRequestsScreen(),
              ),
            ),
          );
        }
      } catch (e) {
        debugPrint('Error in submit request: $e');
      } finally {
        EasyLoading.dismiss();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'إنشاء طلب جديد',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // معلومات المدرس
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25.r,
                          backgroundColor: AppColors.primary,
                          child: Text(
                            widget.teacher.name?.substring(0, 1).toUpperCase() ?? 'T',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.teacher.name ?? '',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                widget.teacher.email ?? '',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 24.h),
                Text(
                  'تفاصيل الطلب',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16.h),
                
                // حقل العنوان
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'عنوان الطلب',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال عنوان الطلب';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                
                // حقل الموضوع
                TextFormField(
                  controller: _subjectController,
                  decoration: InputDecoration(
                    labelText: 'الموضوع',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال موضوع الطلب';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                
                // حقل السبب
                TextFormField(
                  controller: _reasonController,
                  decoration: InputDecoration(
                    labelText: 'سبب الطلب',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال سبب الطلب';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 32.h),
                
                // زر إرسال الطلب
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: _submitRequest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'إرسال الطلب',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 