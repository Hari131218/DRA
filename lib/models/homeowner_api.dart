class homeownerlist {
  String? message;
  List<AssessorNameList>? assessorNameList;

  homeownerlist({this.message, this.assessorNameList});

  homeownerlist.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['assessorNameList'] != null) {
      assessorNameList = <AssessorNameList>[];
      json['assessorNameList'].forEach((v) {
        assessorNameList!.add(new AssessorNameList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.assessorNameList != null) {
      data['assessorNameList'] =
          this.assessorNameList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AssessorNameList {
  int? id;
  String? webId;
  String? firstName;
  String? lastName;
  String? address;
  String? island;
  String? email;
  String? homeNumber;
  String? settlement;
  int? status;
  String? type;
  String? phoneNumber;
  String? alterPhoneNumber;
  String? createdAt;
  String? updatedAt;
  String? scheduledAt;

  AssessorNameList(
      {this.id,
      this.webId,
      this.firstName,
      this.lastName,
      this.address,
      this.island,
      this.email,
      this.homeNumber,
      this.settlement,
      this.status,
      this.type,
      this.phoneNumber,
      this.alterPhoneNumber,
      this.createdAt,
      this.updatedAt,
      this.scheduledAt});

  AssessorNameList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    webId = json['web_id'];
    firstName = json['name'];
    lastName = json['last_name'];
    address = json['address'];
    island = json['island'];
    email = json['email'];
    homeNumber = json['home_number'];
    settlement = json['settlement'];
    status = json['status'];
    type = json['type'];
    phoneNumber = json['phone_number'];
    alterPhoneNumber = json['alter_phone_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    scheduledAt = json['scheduled_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['web_id'] = this.webId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['address'] = this.address;
    data['island'] = this.island;
    data['email'] = this.email;
    data['home_number'] = this.homeNumber;
    data['settlement'] = this.settlement;
    data['status'] = this.status;
    data['type'] = this.type;
    data['phone_number'] = this.phoneNumber;
    data['alter_phone_number'] = this.alterPhoneNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['scheduled_at'] = this.scheduledAt;
    return data;
  }
}
