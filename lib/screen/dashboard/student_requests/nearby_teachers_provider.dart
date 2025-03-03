import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lms/data/dio_service/api_service.dart';
import 'package:lms/data/model/teacher_request/nearby_teachers_response.dart';
import 'package:lms/data/model/teacher_request/create_request_response.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NearbyTeachersProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Teacher> _teachers = [];
  List<Teacher> get teachers => _teachers;

  // للبحث
  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<Teacher> get filteredTeachers {
    if (_searchQuery.isEmpty) {
      return _teachers;
    }
    return _teachers.where((teacher) {
      return teacher.name?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false;
    }).toList();
  }

  // جلب قائمة المدرسين القريبين
  Future<void> getNearbyTeachers() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await ApiService.getDio()!.get(
        'https://lms.null-safety.com/api/v1/student/nearby-teachers',
      ).timeout(const Duration(seconds: 30));

      // Extra safety
      if (response.data == null) {
        _teachers = [];
        _isLoading = false;
        notifyListeners();
        return;
      }

      final nearbyTeachersResponse = NearbyTeachersResponse.fromJson(response.data);
      _teachers = nearbyTeachersResponse.data?.teachers?.data ?? [];
      
      debugPrint('Parsed Teachers Length: ${_teachers.length}');

    } catch (e) {
      _teachers = [];
      debugPrint('Error getting nearby teachers: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // إرسال طلب جديد لمدرس
  Future<bool> createRequest({
    required String title,
    required String reason,
    required String subject,
    required int teacherId,
  }) async {
    try {
      // إرسال الطلب باستخدام formData بدلاً من queryParameters
      final formData = {
        'title': title,
        'reason': reason,
        'subject': subject,
        'teacher': teacherId.toString(),
      };

      final response = await ApiService.getDio()!.post(
        'https://lms.null-safety.com/api/v1/student/requests',
        data: formData, // استخدام data بدلاً من queryParameters
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          Fluttertoast.showToast(
            msg: 'انتهت مهلة الاتصال، يرجى المحاولة مرة أخرى',
            backgroundColor: Colors.red,
          );
          throw TimeoutException('Request timeout');
        },
      );

      debugPrint('Create Request Response: ${response.data}');

      if (response.data != null) {
        final createRequestResponse = CreateRequestResponse.fromJson(response.data);
        
        if (createRequestResponse.status == true) {
          Fluttertoast.showToast(
            msg: createRequestResponse.message ?? 'تم إرسال الطلب بنجاح',
            backgroundColor: Colors.green,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
          );
          return true;
        } else {
          Fluttertoast.showToast(
            msg: createRequestResponse.message ?? 'حدث خطأ أثناء إرسال الطلب',
            backgroundColor: Colors.red,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
          );
          return false;
        }
      } else {
        Fluttertoast.showToast(
          msg: 'لم يتم استلام رد من الخادم',
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
        return false;
      }
    } on DioException catch (e) {
      debugPrint('Dio Error: ${e.message}');
      debugPrint('Dio Error Response: ${e.response?.data}');
      
      String errorMessage = 'حدث خطأ أثناء إرسال الطلب';
      if (e.response?.data != null && e.response?.data['message'] != null) {
        errorMessage = e.response?.data['message'];
      }
      
      Fluttertoast.showToast(
        msg: errorMessage,
        backgroundColor: Colors.red,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    } catch (e) {
      debugPrint('Error creating request: $e');
      Fluttertoast.showToast(
        msg: 'حدث خطأ غير متوقع',
        backgroundColor: Colors.red,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    }
  }
} 