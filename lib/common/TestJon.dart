class TestJon {
  String? message;
  List<AssessmentList>? assessmentList;
  bool? hasPages;
  int? total;
  int? perPage;
  Null? nextPageUrl;
  Null? prevPageUrl;
  int? currentPage;

  TestJon(
      {this.message,
        this.assessmentList,
        this.hasPages,
        this.total,
        this.perPage,
        this.nextPageUrl,
        this.prevPageUrl,
        this.currentPage});

  TestJon.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['assessmentList'] != null) {
      assessmentList = <AssessmentList>[];
      json['assessmentList'].forEach((v) {
        assessmentList!.add(new AssessmentList.fromJson(v));
      });
    }
    hasPages = json['has_pages'];
    total = json['total'];
    perPage = json['per_page'];
    nextPageUrl = json['next_page_url'];
    prevPageUrl = json['prev_page_url'];
    currentPage = json['current_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.assessmentList != null) {
      data['assessmentList'] =
          this.assessmentList!.map((v) => v.toJson()).toList();
    }
    data['has_pages'] = this.hasPages;
    data['total'] = this.total;
    data['per_page'] = this.perPage;
    data['next_page_url'] = this.nextPageUrl;
    data['prev_page_url'] = this.prevPageUrl;
    data['current_page'] = this.currentPage;
    return data;
  }
}

class AssessmentList {
  int? id;
  int? assessmentRequestId;
  String? webId;
  String? email;
  String? assignedDate;
  String? firstName;
  String? lastName;
  String? address;
  String? island;
  String? phoneNumber;
  Null? alterPhoneNumber;

  AssessmentList(
      {this.id,
        this.assessmentRequestId,
        this.webId,
        this.email,
        this.assignedDate,
        this.firstName,
        this.lastName,
        this.address,
        this.island,
        this.phoneNumber,
        this.alterPhoneNumber});

  AssessmentList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    assessmentRequestId = json['assessment_request_id'];
    webId = json['web_id'];
    email = json['email'];
    assignedDate = json['assigned_date'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    address = json['address'];
    island = json['island'];
    phoneNumber = json['phone_number'];
    alterPhoneNumber = json['alter_phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['assessment_request_id'] = this.assessmentRequestId;
    data['web_id'] = this.webId;
    data['email'] = this.email;
    data['assigned_date'] = this.assignedDate;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['address'] = this.address;
    data['island'] = this.island;
    data['phone_number'] = this.phoneNumber;
    data['alter_phone_number'] = this.alterPhoneNumber;
    return data;
  }
}