
class ProfilescreenApi {
  ProfilescreenApi({
      String? message, 
      List<UserProfile>? userProfile,}){
    _message = message;
    _userProfile = userProfile;
}

  ProfilescreenApi.fromJson(dynamic json) {
    _message = json['message'];
    if (json['userProfile'] != null) {
      _userProfile = [];
      json['userProfile'].forEach((v) {
        _userProfile?.add(UserProfile.fromJson(v));
      });
    }
  }
  String? _message;
  List<UserProfile>? _userProfile;
ProfilescreenApi copyWith({  String? message,
  List<UserProfile>? userProfile,
}) => ProfilescreenApi(  message: message ?? _message,
  userProfile: userProfile ?? _userProfile,
);
  String? get message => _message;
  List<UserProfile>? get userProfile => _userProfile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_userProfile != null) {
      map['userProfile'] = _userProfile?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class UserProfile {
  UserProfile({
      int? id, 
      String? email, 
      String? firstName, 
      String? lastName, 
      String? mobileNo,
      String? address, 
      String? state, 
      String? city, 
      int? pincode, 
      String? userPhoto,}){
    _id = id;
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _mobileNo = mobileNo;
    _address = address;
    _state = state;
    _city = city;
    _pincode = pincode;
    _userPhoto = userPhoto;
}

  UserProfile.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _mobileNo = json['mobile_no'];
    _address = json['address'];
    _state = json['state'];
    _city = json['city'];
    _pincode = json['pincode'];
    _userPhoto = json['user_photo'];
  }
  int? _id;
  String? _email;
  String? _firstName;
  String? _lastName;
  String? _mobileNo;
  String? _address;
  String? _state;
  String? _city;
  int? _pincode;
  String? _userPhoto;
UserProfile copyWith({  int? id,
  String? email,
  String? firstName,
  String? lastName,
  String? mobileNo,
  String? address,
  String? state,
  String? city,
  int? pincode,
  String? userPhoto,
}) => UserProfile(  id: id ?? _id,
  email: email ?? _email,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  mobileNo: mobileNo ?? _mobileNo,
  address: address ?? _address,
  state: state ?? _state,
  city: city ?? _city,
  pincode: pincode ?? _pincode,
  userPhoto: userPhoto ?? _userPhoto,
);
  int? get id => _id;
  String? get email => _email;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get mobileNo => _mobileNo;
  String? get address => _address;
  String? get state => _state;
  String? get city => _city;
  int? get pincode => _pincode;
  String? get userPhoto => _userPhoto;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['mobile_no'] = _mobileNo;
    map['address'] = _address;
    map['state'] = _state;
    map['city'] = _city;
    map['pincode'] = _pincode;
    map['user_photo'] = _userPhoto;
    return map;
  }

}