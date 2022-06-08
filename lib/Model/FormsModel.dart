class FormsModel {
  int status;
  String message;
  List<Data> data;

  FormsModel({this.status, this.message, this.data});

  FormsModel.fromJson(Map<String, dynamic> json) {
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
  int formId;
  String formName;

  Data({this.formId, this.formName});

  Data.fromJson(Map<String, dynamic> json) {
    formId = json['formId'];
    formName = json['formName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['formId'] = this.formId;
    data['formName'] = this.formName;
    return data;
  }
}
