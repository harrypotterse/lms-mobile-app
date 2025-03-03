import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lms/screen/dashboard/student_requests/student_requests_provider.dart';
import 'package:lms/screen/dashboard/teacher_requests/chat_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/utils/app_consts.dart';
import 'package:lms/data/model/teacher_request/student_requests_response.dart';

class StudentRequestsScreen extends StatefulWidget {
  const StudentRequestsScreen({Key? key}) : super(key: key);

  @override
  State<StudentRequestsScreen> createState() => _StudentRequestsScreenState();
}

class _StudentRequestsScreenState extends State<StudentRequestsScreen> {
  @override
  void initState() {
    super.initState();
    // جلب الطلبات عند فتح الشاشة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StudentRequestsProvider>().getStudentRequests();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'طلباتي',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              context.read<StudentRequestsProvider>().getStudentRequests();
            },
          ),
        ],
      ),
      body: Consumer<StudentRequestsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.requests.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    size: 70.r,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16.h),
                  const Text(
                    'لا توجد طلبات حالياً',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  const Text(
                    'قم بإنشاء طلب جديد من شاشة المدرسين القريبين',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.r),
            itemCount: provider.requests.length,
            itemBuilder: (context, index) {
              final request = provider.requests[index];
              return _buildRequestCard(context, request);
            },
          );
        },
      ),
    );
  }

  // بناء كارت الطلب
  Widget _buildRequestCard(BuildContext context, StudentRequest request) {
    return ExpansionTile(
      collapsedBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      title: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request.title ?? '',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'الأستاذ: ${request.teacherName ?? ''}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 6.h,
            ),
            decoration: BoxDecoration(
              color: _getStatusColor(request.approved).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: _getStatusColor(request.approved).withOpacity(0.5),
                width: 1,
              ),
            ),
            child: Text(
              _getStatusText(request.approved),
              style: TextStyle(
                color: _getStatusColor(request.approved),
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      children: [
        Container(
          padding: EdgeInsets.all(16.r),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow('الموضوع', request.subject ?? ''),
              SizedBox(height: 8.h),
              if (request.reason != null && request.reason!.isNotEmpty)
                _buildInfoRow('السبب', request.reason ?? ''),
              SizedBox(height: 8.h),
              _buildInfoRow('تاريخ الطلب', request.date ?? ''),
              SizedBox(height: 16.h),
              
              // زر الدردشة (يظهر فقط إذا كان الطلب مقبول)
              if (request.approved == 1)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (request.id != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              requestId: request.id!,
                            ),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.chat),
                    label: const Text('الذهاب إلى المحادثة'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  // صف بيانات الطلب
  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[700],
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  // الحصول على نص حالة الطلب
  String _getStatusText(int? status) {
    switch (status) {
      case 1:
        return 'تمت الموافقة';
      case 0:
        return 'قيد الانتظار';
      default:
        return 'غير معروف';
    }
  }

  // الحصول على لون حالة الطلب
  Color _getStatusColor(int? status) {
    switch (status) {
      case 1:
        return Colors.green;
      case 0:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
} 