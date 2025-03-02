import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lms/data/dio_service/api_service.dart';
import 'package:lms/data/model/teacher_request/request_details_response.dart';
import 'package:lms/data/model/teacher_request/teacher_request_response.dart';

class TeacherRequestsProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<TeacherRequest> _requests = [];
  List<TeacherRequest> get requests => _requests;

  RequestDetails? _currentRequestDetails;
  RequestDetails? get currentRequestDetails => _currentRequestDetails;

  // حالة تحميل الرسائل
  bool _isLoadingMessages = false;
  bool get isLoadingMessages => _isLoadingMessages;

  // جلب قائمة الطلبات
  Future<void> getTeacherRequests() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await ApiService.getDio()!
          .get('https://lms.null-safety.com/api/v1/teachers/my-requests');

      debugPrint('Teacher Requests API Response: ${response.data}');
      
      final teacherRequestResponse = TeacherRequestResponse.fromJson(response.data);
      _requests = teacherRequestResponse.data ?? [];
      
      debugPrint('Parsed Requests Length: ${_requests.length}');
      debugPrint('First Request: ${_requests.isNotEmpty ? _requests.first.title : "No requests"}');

    } catch (e) {
      debugPrint('Error getting teacher requests: $e');
      debugPrint('Error Stack Trace: ${e is DioException ? e.response?.data : ""}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // تحديث حالة الطلب (قبول/رفض)
  Future<bool> updateRequestStatus(int requestId, int status) async {
    try {
      final response = await ApiService.getDio()!
          .post('https://lms.null-safety.com/api/v1/teachers/requests/$requestId/status?status=$status');
      
      // تحديث القائمة المحلية
      if (response.statusCode == 200) {
        await getTeacherRequests();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error updating request status: $e');
      return false;
    }
  }

  // جلب تفاصيل الطلب والرسائل
  Future<void> getRequestDetails(int requestId) async {
    try {
      _isLoadingMessages = true;
      notifyListeners();

      final response = await ApiService.getDio()!
          .get('https://lms.null-safety.com/api/v1/teachers/requests/$requestId');

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
          .post('https://lms.null-safety.com/api/v1/teachers/requests/$requestId/message?message=$message');

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