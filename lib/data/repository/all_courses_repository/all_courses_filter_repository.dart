import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lms/data/dio_service/api_service.dart';
import 'package:lms/data/response_structure/api_response.dart';

import '../../model/all_courses_response/all_courses_filter_response.dart';

class AllCoursesFilterRepository {
  static Future<ApiResponse<AllCoursesFilterResponse>> getAllCoursesFilterRepositoryData() async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/courses/search");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = allCoursesFilterResponseFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            message: obj.status,
            data: obj);
      } else {
        var obj = allCoursesFilterResponseFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            message: obj.status,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.unknown) {
        EasyLoading.dismiss();
        var obj = allCoursesFilterResponseFromJson(e.response.toString());

        return ApiResponse(
          httpCode: e.response!.statusCode,
          message: e.response!.data["status"],
          error: obj,
        );
      } else {
        EasyLoading.dismiss();
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }
}
