import 'dart:convert';

class DataModel {
  int? id;
  String? formValue, name, email, cnic, dsn;

  DataModel({this.id, this.formValue});

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    formValue = jsonEncode(json['formValue']);
    name = json["name"];
    email = json['email'];
    cnic = json["cnic"];
    dsn = json["designation"] == 0 ? "Student" : "Employee";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['formValue'] = formValue;
    return data;
  }
}
