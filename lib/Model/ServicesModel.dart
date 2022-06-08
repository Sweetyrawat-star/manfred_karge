class ServicesModel {
  int status;
  String message;
  Data data;

  ServicesModel({this.status, this.message, this.data});

  ServicesModel.fromJson(Map<String, dynamic> json) {
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
  int serviceId;
  String serviceName;
  String serviceIcon;
  String serviceDescription;

  Data(
      {this.serviceId,
        this.serviceName,
        this.serviceIcon,
        this.serviceDescription});

  Data.fromJson(Map<String, dynamic> json) {
    serviceId = json['serviceId'];
    serviceName = json['serviceName'];
    serviceIcon = json['serviceIcon'];
    serviceDescription = json['serviceDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceId'] = this.serviceId;
    data['serviceName'] = this.serviceName;
    data['serviceIcon'] = this.serviceIcon;
    data['serviceDescription'] = this.serviceDescription;
    return data;
  }
}
