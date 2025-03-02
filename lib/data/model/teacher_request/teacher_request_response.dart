// Model for teacher requests list response
import 'dart:convert';

TeacherRequestResponse teacherRequestResponseFromJson(String str) =>
    TeacherRequestResponse.fromJson(json.decode(str));

class TeacherRequestResponse {
  bool? status;
  String? message;
  List<TeacherRequest>? data;

  TeacherRequestResponse({
    this.status,
    this.message,
    this.data,
  });

  factory TeacherRequestResponse.fromJson(Map<String, dynamic> json) =>
      TeacherRequestResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<TeacherRequest>.from(
                json["data"]!.map((x) => TeacherRequest.fromJson(x))),
      );
}

class TeacherRequest {
  int? id;
  String? title;
  String? reason;
  String? subject;
  String? teacher;
  String? date;
  String? createdAt;
  String? updatedAt;
  int? userId;
  int? approved;
  int? studentId;
  String? studentName;
  String? studentEmail;
  String? studentImage;

  TeacherRequest({
    this.id,
    this.title,
    this.reason,
    this.subject,
    this.teacher,
    this.date,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.approved,
    this.studentId,
    this.studentName,
    this.studentEmail,
    this.studentImage,
  });

  factory TeacherRequest.fromJson(Map<String, dynamic> json) => TeacherRequest(
        id: json["id"],
        title: json["title"],
        reason: json["reason"],
        subject: json["subject"],
        teacher: json["teacher"],
        date: json["date"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        userId: json["user_id"],
        approved: json["approved"],
        studentId: json["student_id"],
        studentName: json["student_name"],
        studentEmail: json["student_email"],
        studentImage: json["student_image"],
      );
} 