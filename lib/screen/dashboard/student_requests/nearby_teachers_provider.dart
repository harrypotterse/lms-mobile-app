import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lms/data/dio_service/api_service.dart';
import 'package:lms/data/model/teacher_request/nearby_teachers_response.dart';
import 'package:lms/data/model/teacher_request/create_request_response.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';  // Add this import at the top

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
      final dio = ApiService.getDio()!;
      
      // استخدام FormData
      final formData = FormData.fromMap({
        'title': title,
        'reason': reason,
        'subject': subject,
        'teacher': teacherId,
      });

      final response = await dio.post(
        'https://lms.null-safety.com/api/v1/student/requests',
        data: formData,
      );

      debugPrint('Create Request Response: ${response.data}');
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        Fluttertoast.showToast(
          msg: 'تم إرسال الطلب بنجاح',
          backgroundColor: Colors.green,
          toastLength: Toast.LENGTH_LONG,
        );
        return true;
      } else {
        Fluttertoast.showToast(
          msg: 'فشل إرسال الطلب',
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_LONG,
        );
        return false;
      }
    } catch (e) {
      debugPrint('Error creating request: $e');
      Fluttertoast.showToast(
        msg: 'حدث خطأ أثناء إرسال الطلب',
        backgroundColor: Colors.red,
        toastLength: Toast.LENGTH_LONG,
      );
      return false;
    }
  }
} 