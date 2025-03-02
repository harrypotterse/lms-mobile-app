import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lms/screen/dashboard/teacher_requests/teacher_requests_provider.dart';
import 'package:lms/screen/dashboard/teacher_requests/chat_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/utils/app_consts.dart';
import 'package:lms/data/model/teacher_request/teacher_request_response.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class TeacherRequestsScreen extends StatefulWidget {
  const TeacherRequestsScreen({Key? key}) : super(key: key);

  @override
  State<TeacherRequestsScreen> createState() => _TeacherRequestsScreenState();
}

class _TeacherRequestsScreenState extends State<TeacherRequestsScreen> {
  @override
  void initState() {
    super.initState();
    // جلب الطلبات عند فتح الشاشة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TeacherRequestsProvider>().getTeacherRequests();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('طلبات الطلاب'),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<TeacherRequestsProvider>().getTeacherRequests();
            },
          ),
        ],
      ),
      body: Consumer<TeacherRequestsProvider>(
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
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.r),
            itemCount: provider.requests.length,
            itemBuilder: (context, index) {
              final request = provider.requests[index];
              return RequestCard(request: request);
            },
          );
        },
      ),
    );
  }
}

class RequestCard extends StatelessWidget {
  final TeacherRequest request;

  const RequestCard({Key? key, required this.request}) : super(key: key);

  String _getStatusText(int? status) {
    switch (status) {
      case 0:
        return 'في انتظار الرد';
      case 1:
        return 'تمت الموافقة';
      case 2:
        return 'تم الرفض';
      default:
        return 'غير معروف';
    }
  }

  Color _getStatusColor(int? status) {
    switch (status) {
      case 0:
        return Colors.orange;
      case 1:
        return Colors.green;
      case 2:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Future<void> _showStatusChangeDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تغيير حالة الطلب'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.check_circle, color: Colors.green),
                title: const Text('موافقة'),
                onTap: () async {
                  Navigator.pop(context);
                  await _updateStatus(context, 1);
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel, color: Colors.red),
                title: const Text('رفض'),
                onTap: () async {
                  Navigator.pop(context);
                  await _updateStatus(context, 2);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _updateStatus(BuildContext context, int status) async {
    EasyLoading.show(status: 'جاري التحديث...');
    final success = await context
        .read<TeacherRequestsProvider>()
        .updateRequestStatus(request.id!, status);
    EasyLoading.dismiss();

    if (success && status == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(requestId: request.id!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 16.r),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: Text(
                    request.studentName?.substring(0, 1).toUpperCase() ?? 'S',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.title ?? '',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        request.studentName ?? '',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(request.approved).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    _getStatusText(request.approved),
                    style: TextStyle(
                      color: _getStatusColor(request.approved),
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الموضوع: ${request.subject ?? ''}',
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(height: 8.h),
                Text(
                  'السبب: ${request.reason ?? ''}',
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _showStatusChangeDialog(context),
                      icon: const Icon(Icons.edit_note),
                      label: const Text('تغيير الحالة'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                      ),
                    ),
                    if (request.approved == 1)
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChatScreen(requestId: request.id!),
                            ),
                          );
                        },
                        icon: const Icon(Icons.chat),
                        label: const Text('المحادثة'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 