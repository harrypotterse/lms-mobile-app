class CreateRequestResponse {
  bool? status;
  String? message;
  CreateRequestData? data;

  CreateRequestResponse({this.status, this.message, this.data});

  CreateRequestResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? CreateRequestData.fromJson(json['data']) : null;
  }
}

class CreateRequestData {
  int? requestId;

  CreateRequestData({this.requestId});

  CreateRequestData.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
  }
} 