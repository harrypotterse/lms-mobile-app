import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lms/screen/dashboard/student_requests/student_requests_provider.dart';
import 'package:lms/screen/dashboard/teacher_requests/chat_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/utils/app_theme.dart';
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
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          'طلباتي',
          style: AppTheme.headingMedium.copyWith(color: Colors.white),
        ),
        backgroundColor: AppTheme.primary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () => context.read<StudentRequestsProvider>().getStudentRequests(),
          ),
        ],
      ),
      body: Consumer<StudentRequestsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary),
              ),
            );
          }

          if (provider.requests.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    size: 70.r,
                    color: AppTheme.textSecondary,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'لا توجد طلبات حالياً',
                    style: AppTheme.bodyLarge.copyWith(
                      color: AppTheme.textSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'يمكنك إرسال طلب جديد من صفحة المدرسين القريبين',
                    style: AppTheme.bodyMedium,
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
              return RequestCard(request: request);
            },
          );
        },
      ),
    );
  }
}

class RequestCard extends StatelessWidget {
  final StudentRequest request;

  const RequestCard({Key? key, required this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.r),
      decoration: AppTheme.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // رأس البطاقة
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: _getStatusColor(request.approved).withOpacity(0.1),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            ),
            child: Row(
              children: [
                Icon(
                  _getStatusIcon(request.approved),
                  color: _getStatusColor(request.approved),
                  size: 24.r,
                ),
                SizedBox(width: 8.w),
                Text(
                  _getStatusText(request.approved),
                  style: AppTheme.bodyLarge.copyWith(
                    color: _getStatusColor(request.approved),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // محتوى البطاقة
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('المدرس', request.teacherName ?? ''),
                SizedBox(height: 8.h),
                _buildInfoRow('العنوان', request.title ?? ''),
                SizedBox(height: 8.h),
                _buildInfoRow('الموضوع', request.subject ?? ''),
                SizedBox(height: 8.h),
                _buildInfoRow('التاريخ', request.date ?? ''),
                if (request.reason != null) ...[
                  SizedBox(height: 8.h),
                  _buildInfoRow('السبب', request.reason!),
                ],
              ],
            ),
          ),

          // زر المحادثة (إذا تمت الموافقة)
          if (request.approved == 1)
            Padding(
              padding: EdgeInsets.all(16.r),
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
                style: AppTheme.primaryButton,
                icon: const Icon(Icons.chat),
                label: const Text('الذهاب إلى المحادثة'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: AppTheme.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTheme.bodyLarge,
          ),
        ),
      ],
    );
  }

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

  Color _getStatusColor(int? status) {
    switch (status) {
      case 1:
        return AppTheme.success;
      case 0:
        return AppTheme.warning;
      default:
        return AppTheme.textSecondary;
    }
  }

  IconData _getStatusIcon(int? status) {
    switch (status) {
      case 1:
        return Icons.check_circle;
      case 0:
        return Icons.access_time;
      default:
        return Icons.help;
    }
  }
} 