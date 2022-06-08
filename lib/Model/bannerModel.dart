class BannerModels {
  int status;
  String message;
  List<Data> data;

  BannerModels({this.status, this.message, this.data});

  BannerModels.fromJson(Map<String, dynamic> json) {
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
  int bannerId;
  String bannerImage;
  String bannerHeading;
  String bannerText;

  Data({this.bannerId, this.bannerImage, this.bannerHeading, this.bannerText});

  Data.fromJson(Map<String, dynamic> json) {
    bannerId = json['bannerId'];
    bannerImage = json['bannerImage'];
    bannerHeading = json['bannerHeading'];
    bannerText = json['bannerText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bannerId'] = this.bannerId;
    data['bannerImage'] = this.bannerImage;
    data['bannerHeading'] = this.bannerHeading;
    data['bannerText'] = this.bannerText;
    return data;
  }
}