class FormDetailScreenModel {
  int status;
  String message;
  Data data;

  FormDetailScreenModel({this.status, this.message, this.data});

  FormDetailScreenModel.fromJson(Map<String, dynamic> json) {
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
  int formId;
  String formName;
  String pdfLink;

  Data({this.formId, this.formName, this.pdfLink});

  Data.fromJson(Map<String, dynamic> json) {
    formId = json['formId'];
    formName = json['formName'];
    pdfLink = json['pdfLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['formId'] = this.formId;
    data['formName'] = this.formName;
    data['pdfLink'] = this.pdfLink;
    return data;
  }
}
