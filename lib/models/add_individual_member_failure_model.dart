import 'package:capef/models/error_response.dart';

class AddIndividualMemberFailureModel {
  Errors? errors;
  String? type;
  String? title;
  Status? status;
  String? traceId;

  AddIndividualMemberFailureModel(
      {this.errors, this.type, this.title, this.status, this.traceId});

  AddIndividualMemberFailureModel.fromJson(Map<String, dynamic> json) {
    errors = json["errors"] == null ? null : Errors.fromJson(json["errors"]);
    type = json["type"];
    title = json["title"];
    status = json["status"] == null ? null : Status.fromJson(json["status"]);
    traceId = json["traceId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (errors != null) {
      data["errors"] = errors?.toJson();
    }
    if (status != null) {
      data["status"] = status?.toJson();
    }
    data["type"] = type;
    data["title"] = title;
    data["traceId"] = traceId;
    return data;
  }
}

class Errors {
  List<String>? firstname;

  Errors({this.firstname});

  Errors.fromJson(Map<String, dynamic> json) {
    firstname =
        json["firstname"] == null ? null : List<String>.from(json["firstname"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (firstname != null) {
      data["firstname"] = firstname;
    }
    return data;
  }
}
