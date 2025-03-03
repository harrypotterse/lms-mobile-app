class NearbyTeachersResponse {
  bool? status;
  String? message;
  NearbyTeachersData? data;

  NearbyTeachersResponse({this.status, this.message, this.data});

  NearbyTeachersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? NearbyTeachersData.fromJson(json['data']) : null;
  }
}

class NearbyTeachersData {
  Teachers? teachers;

  NearbyTeachersData({this.teachers});

  NearbyTeachersData.fromJson(Map<String, dynamic> json) {
    teachers = json['teachers'] != null ? Teachers.fromJson(json['teachers']) : null;
  }
}

class Teachers {
  int? currentPage;
  List<Teacher>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Teachers({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  Teachers.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Teacher>[];
      json['data'].forEach((v) {
        data!.add(Teacher.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class Teacher {
  int? id;
  String? name;
  String? username;
  String? email;
  String? phone;
  int? gender;
  dynamic imageId;
  int? status;
  String? latitude;
  String? longitude;
  String? cityName;
  String? provinceName;
  String? nationCity;
  dynamic type;
  double? distance;
  String? distanceText;

  Teacher({
    this.id,
    this.name,
    this.username,
    this.email,
    this.phone,
    this.gender,
    this.imageId,
    this.status,
    this.latitude,
    this.longitude,
    this.cityName,
    this.provinceName,
    this.nationCity,
    this.type,
    this.distance,
    this.distanceText,
  });

  Teacher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    imageId = json['image_id'];
    status = json['status'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    cityName = json['city_name'];
    provinceName = json['province_name'];
    nationCity = json['nation_city'];
    type = json['Type'];
    distance = json['distance'] is int ? 
        (json['distance'] as int).toDouble() : 
        json['distance'];
    distanceText = json['distance_text'];
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }
} 