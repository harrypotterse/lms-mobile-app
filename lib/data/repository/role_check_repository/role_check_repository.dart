import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lms/data/dio_service/api_service.dart';
import 'package:lms/data/model/role_check_response/role_check_response.dart';
import 'package:lms/data/response_structure/api_response.dart';

class RoleCheckRepository {
  static Future<ApiResponse<RoleCheckResponse>> getRoleCheck() async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/role/check");
      EasyLoading.dismiss();
      
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = roleCheckResponseFromJson(response.toString());
        return ApiResponse(
          httpCode: response.statusCode,
          success: obj.success,
          message: "Success",
          data: obj
        );
      } else {
        var obj = roleCheckResponseFromJson(response.toString());
        return ApiResponse(
          httpCode: response.statusCode,
          success: obj.success,
          message: "Error",
          data: obj
        );
      }
    } on DioException catch (e) {
      EasyLoading.dismiss();
      if (kDebugMode) {
        print(e.message);
      }
      return ApiResponse(
        httpCode: -1,
        message: "Connection error ${e.message}"
      );
    }
  }
} 