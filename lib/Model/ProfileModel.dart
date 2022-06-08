class ProfileModel {
  int status;
  String message;
  Data data;

  ProfileModel({this.status, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int userId;
  String name;
  String emailAddress;
  String phoneNumber;
  String profileImage;
  String address;

  Data(
      {this.userId,
        this.name,
        this.emailAddress,
        this.phoneNumber,
        this.profileImage,
        this.address});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    name = json['name'];
    emailAddress = json['emailAddress'];
    phoneNumber = json['phoneNumber'];
    profileImage = json['profileImage'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['name'] = this.name;
    data['emailAddress'] = this.emailAddress;
    data['phoneNumber'] = this.phoneNumber;
    data['profileImage'] = this.profileImage;
    data['address'] = this.address;
    return data;
  }
}
