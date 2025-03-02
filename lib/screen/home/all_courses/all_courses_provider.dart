import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lms/data/model/all_courses_response/all_courses_response.dart';
import 'package:lms/data/repository/all_courses_repository/all_courses_filter_repository.dart';
import 'package:lms/data/repository/all_courses_repository/all_courses_repository.dart';

import '../../../data/model/all_courses_response/all_courses_filter_response.dart';

class AllCoursesProvider extends ChangeNotifier {
  AllCoursesResponse? allCoursesResponse;
  AllCoursesFilterResponse? allCoursesFilterResponse;
  String search = "";
  Timer? timeHandle;

  AllCoursesProvider() {
    mentorsScreenApi(search);
  }

  void getSearchValue(String? searchCode) {
    search = searchCode ?? "";
    if (timeHandle != null) {
      timeHandle!.cancel();
    }

    timeHandle = Timer(const Duration(seconds: 1), () {
      mentorsScreenApi(search);
      notifyListeners();
    });

    //print("controller page $searchCode");
  }

  void mentorsScreenApi(String? search) async {
    var apiCoursesResponse =
        await AllCoursesRepository.getAllCoursesRepositoryData(search);

    var apiCourseFiltersResponse =
        await AllCoursesFilterRepository.getAllCoursesFilterRepositoryData();

    if (apiCourseFiltersResponse.httpCode == 200) {
      allCoursesFilterResponse = apiCourseFiltersResponse.data;
    }

    if (apiCoursesResponse.success == true) {
      allCoursesResponse = apiCoursesResponse.data;
      notifyListeners();
    }
  }
}
