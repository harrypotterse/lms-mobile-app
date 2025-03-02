import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lms/screen/dashboard/teacher_requests/teacher_requests_provider.dart';
import 'package:lms/screen/dashboard/teacher_requests/chat_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/utils/app_consts.dart';
import 'package:lms/data/model/teacher_request/teacher_request_response.dart';

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
      ),
      body: Consumer<TeacherRequestsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.requests.isEmpty) {
            return const Center(child: Text('لا توجد طلبات'));
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

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.r),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              request.title ?? '',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text('الطالب: ${request.studentName ?? ''}'),
            Text('الموضوع: ${request.subject ?? ''}'),
            Text('السبب: ${request.reason ?? ''}'),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (request.approved == 0) ...[
                  ElevatedButton(
                    onPressed: () async {
                      final success = await context
                          .read<TeacherRequestsProvider>()
                          .updateRequestStatus(request.id!, 1);
                      
                      if (success) {
                        // فتح شاشة الدردشة بعد الموافقة
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(requestId: request.id!),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('موافقة'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<TeacherRequestsProvider>()
                          .updateRequestStatus(request.id!, 2);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('رفض'),
                  ),
                ] else if (request.approved == 1) ...[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(requestId: request.id!),
                        ),
                      );
                    },
                    child: const Text('فتح المحادثة'),
                  ),
                ] else ...[
                  const Text(
                    'تم رفض الطلب',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
} 