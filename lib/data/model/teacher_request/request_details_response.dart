// Model for request details and chat messages
import 'dart:convert';

RequestDetailsResponse requestDetailsResponseFromJson(String str) =>
    RequestDetailsResponse.fromJson(json.decode(str));

class RequestDetailsResponse {
  bool? status;
  String? message;
  RequestDetails? data;

  RequestDetailsResponse({
    this.status,
    this.message,
    this.data,
  });

  factory RequestDetailsResponse.fromJson(Map<String, dynamic> json) =>
      RequestDetailsResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : RequestDetails.fromJson(json["data"]),
      );
}

class RequestDetails {
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
  int? teacherId;
  String? teacherName;
  String? teacherEmail;
  String? teacherImage;
  int? studentId;
  String? studentName;
  String? studentEmail;
  String? studentImage;
  List<Message>? messages;

  RequestDetails({
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
    this.teacherId,
    this.teacherName,
    this.teacherEmail,
    this.teacherImage,
    this.studentId,
    this.studentName,
    this.studentEmail,
    this.studentImage,
    this.messages,
  });

  factory RequestDetails.fromJson(Map<String, dynamic> json) => RequestDetails(
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
        teacherId: json["teacher_id"],
        teacherName: json["teacher_name"],
        teacherEmail: json["teacher_email"],
        teacherImage: json["teacher_image"],
        studentId: json["student_id"],
        studentName: json["student_name"],
        studentEmail: json["student_email"],
        studentImage: json["student_image"],
        messages: json["messages"] == null
            ? []
            : List<Message>.from(
                json["messages"]!.map((x) => Message.fromJson(x))),
      );
}

class Message {
  int? id;
  int? requestId;
  int? senderId;
  int? receiverId;
  String? message;
  int? isRead;
  String? createdAt;
  String? updatedAt;
  int? userId;
  String? userName;
  String? userEmail;
  String? userImage;
  String? senderType;
  String? date;

  Message({
    this.id,
    this.requestId,
    this.senderId,
    this.receiverId,
    this.message,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.userName,
    this.userEmail,
    this.userImage,
    this.senderType,
    this.date,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        requestId: json["request_id"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        message: json["message"],
        isRead: json["is_read"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        userId: json["user_id"],
        userName: json["user_name"],
        userEmail: json["user_email"],
        userImage: json["user_image"],
        senderType: json["sender_type"],
        date: json["date"],
      );
} 