class AboutUsModelPage {
  String status;
  String message;
  Data data;

  AboutUsModelPage({this.status, this.message, this.data});

  AboutUsModelPage.fromJson(Map<String, dynamic> json) {
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
  int aboutUsId;
  String aboutUsContent;

  Data({this.aboutUsId, this.aboutUsContent});

  Data.fromJson(Map<String, dynamic> json) {
    aboutUsId = json['aboutUsId'];
    aboutUsContent = json['aboutUsContent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aboutUsId'] = this.aboutUsId;
    data['aboutUsContent'] = this.aboutUsContent;
    return data;
  }
}
