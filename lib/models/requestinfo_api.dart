class requestinfoapi {
  String? message;
  List<AssessorNameList>? assessorNameList;

  requestinfoapi({this.message, this.assessorNameList});

  requestinfoapi.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['assessment_details'] != null) {
      assessorNameList = <AssessorNameList>[];
      json['assessment_details'].forEach((v) {
        assessorNameList!.add(new AssessorNameList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.assessorNameList != null) {
      data['assessment_details'] =
          this.assessorNameList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AssessorNameList {
  int? id;
  String? webId;
  String? name;
  String? lastName;
  String? address;
  String? island;
  String? email;
  String? homeNumber;
  String? settlement;
  int? status;
  String? type;
  String? callnumber;
  String? alterPhoneNumber;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  AssessorNameList(
      {this.id,
        this.webId,
        this.name,
        this.lastName,
        this.address,
        this.island,
        this.email,
        this.homeNumber,
        this.settlement,
        this.status,
        this.type,
        this.callnumber,
        this.alterPhoneNumber,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  AssessorNameList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    webId = json['web_id'];
    name = json['name'];
    lastName = json['last_name'];
    address = json['street_address'];
    island = json['island'];
    email = json['email_address'];
    homeNumber = json['home_number'];
    settlement = json['settlement'];
    status = json['status'];
    type = json['type'];
    callnumber = json['call_number'];
    alterPhoneNumber = json['alter_phone_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['web_id'] = this.webId;
    data['name'] = this.name;
    data['last_name'] = this.lastName;
    data['street_address'] = this.address;
    data['island'] = this.island;
    data['email_address'] = this.email;
    data['home_number'] = this.homeNumber;
    data['settlement'] = this.settlement;
    data['status'] = this.status;
    data['type'] = this.type;
    data['call_number'] = this.callnumber;
    data['alter_phone_number'] = this.alterPhoneNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}