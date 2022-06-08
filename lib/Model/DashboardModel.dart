class DashboardModel {
  int status;
  String message;
  Data data;

  DashboardModel({this.status, this.message, this.data});

  DashboardModel.fromJson(Map<String, dynamic> json) {
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
  Banners banners;
  List<Services> services;
  List<Sidebar> sidebar;

  Data({this.banners, this.services, this.sidebar});

  Data.fromJson(Map<String, dynamic> json) {
    banners =
    json['banners'] != null ? new Banners.fromJson(json['banners']) : null;
    if (json['services'] != null) {
      services = new List<Services>();
      json['services'].forEach((v) {
        services.add(new Services.fromJson(v));
      });
    }
    if (json['sidebar'] != null) {
      sidebar = new List<Sidebar>();
      json['sidebar'].forEach((v) {
        sidebar.add(new Sidebar.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banners != null) {
      data['banners'] = this.banners.toJson();
    }
    if (this.services != null) {
      data['services'] = this.services.map((v) => v.toJson()).toList();
    }
    if (this.sidebar != null) {
      data['sidebar'] = this.sidebar.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  int bannerId;
  String bannerImage;

  Banners({this.bannerId, this.bannerImage});

  Banners.fromJson(Map<String, dynamic> json) {
    bannerId = json['bannerId'];
    bannerImage = json['bannerImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bannerId'] = this.bannerId;
    data['bannerImage'] = this.bannerImage;
    return data;
  }
}

class Services {
  int serviceId;
  String serviceName;
  String serviceIcon;

  Services({this.serviceId, this.serviceName, this.serviceIcon});

  Services.fromJson(Map<String, dynamic> json) {
    serviceId = json['serviceId'];
    serviceName = json['serviceName'];
    serviceIcon = json['serviceIcon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceId'] = this.serviceId;
    data['serviceName'] = this.serviceName;
    data['serviceIcon'] = this.serviceIcon;
    return data;
  }
}

class Sidebar {
  int id;
  String name;

  Sidebar({this.id, this.name});

  Sidebar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
