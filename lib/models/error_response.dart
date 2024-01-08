class Status {
  bool? isValid;
  String? message;
  String? devmessage;
  int? code;

  Status({this.isValid, this.message, this.devmessage, this.code});

  Status.fromJson(Map<String, dynamic> json) {
    isValid = json["isValid"];
    message = json["message"];
    devmessage = json["devmessage"];
    code = json["code"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["isValid"] = isValid;
    data["message"] = message;
    data["devmessage"] = devmessage;
    data["code"] = code;
    return data;
  }
}
