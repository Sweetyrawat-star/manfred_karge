class GetManFredServices {
  int status;
  String message;
  List<Data> data;

  GetManFredServices({this.status, this.message, this.data});

  GetManFredServices.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
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