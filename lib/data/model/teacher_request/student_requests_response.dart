class StudentRequestsResponse {
  bool? status;
  String? message;
  List<StudentRequest>? data;

  StudentRequestsResponse({this.status, this.message, this.data});

  StudentRequestsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StudentRequest>[];
      json['data'].forEach((v) {
        data!.add(StudentRequest.fromJson(v));
      });
    }
  }
}

class StudentRequest {
  int? id;
  String? title;
  String? subject;
  String? date;
  int? approved;
  String? teacherName;
  String? reason;

  StudentRequest({
    this.id,
    this.title,
    this.subject,
    this.date,
    this.approved,
    this.teacherName,
    this.reason,
  });

  StudentRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subject = json['subject'];
    date = json['date'];
    approved = json['approved'];
    teacherName = json['teacher_name'];
    reason = json['reason']; // قد لا يكون موجوداً في بعض الاستجابات
  }
} 