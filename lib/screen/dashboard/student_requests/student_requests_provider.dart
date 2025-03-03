import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lms/data/dio_service/api_service.dart';
import 'package:lms/data/model/teacher_request/student_requests_response.dart';
import 'package:lms/data/model/teacher_request/request_details_response.dart';

class StudentRequestsProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<StudentRequest> _requests = [];
  List<StudentRequest> get requests => _requests;

  // تفاصيل الطلب الحالي والرسائل
  RequestDetails? _currentRequestDetails;
  RequestDetails? get currentRequestDetails => _currentRequestDetails;

  // حالة تحميل الرسائل
  bool _isLoadingMessages = false;
  bool get isLoadingMessages => _isLoadingMessages;

  // جلب قائمة طلبات الطالب
  Future<void> getStudentRequests() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await ApiService.getDio()!
          .get('https://lms.null-safety.com/api/v1/student/requests');

      debugPrint('Student Requests API Response: ${response.data}');
      
      final studentRequestsResponse = StudentRequestsResponse.fromJson(response.data);
      _requests = studentRequestsResponse.data ?? [];
      
      debugPrint('Parsed Requests Length: ${_requests.length}');

    } catch (e) {
      debugPrint('Error getting student requests: $e');
      debugPrint('Error Stack Trace: ${e is DioException ? e.response?.data : ""}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب تفاصيل الطلب والرسائل
  Future<void> getRequestDetails(int requestId) async {
    try {
      _isLoadingMessages = true;
      notifyListeners();

      final response = await ApiService.getDio()!
          .get('https://lms.null-safety.com/api/v1/student/requests/$requestId');

      final detailsResponse = RequestDetailsResponse.fromJson(response.data);
      _currentRequestDetails = detailsResponse.data;

    } catch (e) {
      debugPrint('Error getting request details: $e');
    } finally {
      _isLoadingMessages = false;
      notifyListeners();
    }
  }

  // إرسال رسالة جديدة
  Future<bool> sendMessage(int requestId, String message) async {
    try {
      final response = await ApiService.getDio()!
          .post('https://lms.null-safety.com/api/v1/student/requests/$requestId/message?message=$message');

      // تحديث الرسائل بعد الإرسال
      await getRequestDetails(requestId);
      return true;
    } catch (e) {
      debugPrint('Error sending message: $e');
      return false;
    }
  }

  // تنظيف البيانات عند الخروج
  void clearCurrentRequest() {
    _currentRequestDetails = null;
    notifyListeners();
  }
} 