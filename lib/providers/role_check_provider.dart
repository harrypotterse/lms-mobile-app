import 'package:flutter/material.dart';
import 'package:lms/data/model/role_check_response/role_check_response.dart';
import 'package:lms/data/repository/role_check_repository/role_check_repository.dart';

class RoleCheckProvider extends ChangeNotifier {
  RoleCheckResponse? roleCheckResponse;
  bool isLoading = false;
  String? error;

  Future<void> getRoleCheck() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await RoleCheckRepository.getRoleCheck();
      if (response.success == true) {
        roleCheckResponse = response.data;
      } else {
        error = response.message;
      }
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  bool get isStudent => roleCheckResponse?.data?.role == "student";
  bool get isTeacher => roleCheckResponse?.data?.role == "teacher";
} 