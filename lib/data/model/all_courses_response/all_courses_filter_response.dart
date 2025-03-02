// To parse this JSON data, do
//
//     final allCoursesResponse = allCoursesResponseFromJson(jsonString);

import 'dart:convert';


AllCoursesFilterResponse allCoursesFilterResponseFromJson(String str) =>
    AllCoursesFilterResponse.fromJson(json.decode(str));

String allCoursesFilterResponseToJson(AllCoursesFilterResponse data) =>
    json.encode(data.toJson());

class AllCoursesFilterResponse {
  String? status;
  Data? data;

  AllCoursesFilterResponse({
    this.status,
    this.data,
  });

  factory AllCoursesFilterResponse.fromJson(Map<String, dynamic> json) =>
      AllCoursesFilterResponse(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
      };
}

class Data {
  List<Instructors>? instructors;
  List<Categories>? categories;
  List<Languages>? languages;
  String? title;

  Data({this.instructors, this.categories, this.languages, this.title});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['instructors'] != null) {
      instructors = <Instructors>[];
      json['instructors'].forEach((v) {
        instructors!.add(Instructors.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(Languages.fromJson(v));
      });
    }
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (instructors != null) {
      data['instructors'] = instructors!.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    if (languages != null) {
      data['languages'] = languages!.map((v) => v.toJson()).toList();
    }
    data['title'] = title;
    return data;
  }
}

class Instructors {
  int? createdBy;
  Instructor? instructor;

  Instructors({this.createdBy, this.instructor});

  Instructors.fromJson(Map<String, dynamic> json) {
    createdBy = json['created_by'];
    instructor = json['instructor'] != null
        ? Instructor.fromJson(json['instructor'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_by'] = createdBy;
    if (instructor != null) {
      data['instructor'] = instructor!.toJson();
    }
    return data;
  }
}

class Instructor {
  int? id;
  String? name;
  String? latitude;
  String? longitude;
  int? distance;
  bool? isChecked = false;

  Instructor(
      {this.id, this.name, this.latitude, this.longitude, this.distance});

  Instructor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['distance'] = distance;
    return data;
  }
}

class Categories {
  int? courseCategoryId;
  Category? category;

  Categories({this.courseCategoryId, this.category});

  Categories.fromJson(Map<String, dynamic> json) {
    courseCategoryId = json['course_category_id'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['course_category_id'] = courseCategoryId;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? title;
  bool? isChecked = false;

  Category({this.id, this.title});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}

class Languages {
  String? language;
  Lang? lang;

  Languages({this.language, this.lang});

  Languages.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    lang = json['lang'] != null ? Lang.fromJson(json['lang']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['language'] = language;
    if (lang != null) {
      data['lang'] = lang!.toJson();
    }
    return data;
  }
}

class Lang {
  String? name;
  String? code;
  bool? isChecked = false;

  Lang({this.name, this.code});

  Lang.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    return data;
  }
}
