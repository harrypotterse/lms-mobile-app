import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lms/data/repository/all_courses_repository/all_courses_filter_repository.dart';

import '../../../data/model/all_courses_response/all_courses_filter_response.dart';

class AllCoursesFilterProvider extends ChangeNotifier {
  AllCoursesFilterResponse? allCoursesFilterResponse;
  String search = "";
  Timer? timeHandle;

  AllCoursesFilterProvider() {
    mentorsScreenApi();
  }

  void getSearchValue(String? searchCode) {
    search = searchCode ?? "";
    if (timeHandle != null) {
      timeHandle!.cancel();
    }

    timeHandle = Timer(const Duration(seconds: 1), () {
      mentorsScreenApi();
      notifyListeners();
    });

    //print("controller page $searchCode");
  }

  void mentorsScreenApi() async {
    var apiCourseFiltersResponse =
        await AllCoursesFilterRepository.getAllCoursesFilterRepositoryData();
    if (apiCourseFiltersResponse.success == true) {
      allCoursesFilterResponse = apiCourseFiltersResponse.data;
      notifyListeners();
    }
  }
}
