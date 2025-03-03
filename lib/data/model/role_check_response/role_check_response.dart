// To parse this JSON data, do
//
//     final roleCheckResponse = roleCheckResponseFromJson(jsonString);

import 'dart:convert';

RoleCheckResponse roleCheckResponseFromJson(String str) => RoleCheckResponse.fromJson(json.decode(str));

String roleCheckResponseToJson(RoleCheckResponse data) => json.encode(data.toJson());

class RoleCheckResponse {
    bool? success;
    Data? data;

    RoleCheckResponse({
        this.success,
        this.data,
    });

    factory RoleCheckResponse.fromJson(Map<String, dynamic> json) => RoleCheckResponse(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
    };
}

class Data {
    String? role;
    int? roleId;
    User? user;

    Data({
        this.role,
        this.roleId,
        this.user,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        role: json["role"],
        roleId: json["role_id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "role": role,
        "role_id": roleId,
        "user": user?.toJson(),
    };
}

class User {
    int? id;
    String? name;
    String? email;
    String? phone;
    String? username;
    int? status;
    String? cityName;
    String? provinceName;
    String? nationCity;
    DateTime? createdAt;
    DateTime? updatedAt;

    User({
        this.id,
        this.name,
        this.email,
        this.phone,
        this.username,
        this.status,
        this.cityName,
        this.provinceName,
        this.nationCity,
        this.createdAt,
        this.updatedAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        username: json["username"],
        status: json["status"],
        cityName: json["city_name"],
        provinceName: json["province_name"],
        nationCity: json["nation_city"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "username": username,
        "status": status,
        "city_name": cityName,
        "province_name": provinceName,
        "nation_city": nationCity,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
} 