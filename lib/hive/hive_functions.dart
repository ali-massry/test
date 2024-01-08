// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:capef/hive/hive_boxes.dart';
import 'package:capef/models/error_response.dart';
import 'package:capef/models/legal_entity_info.dart';
import 'package:capef/models/user_info_model.dart';
import 'package:capef/screens-cubits/agri-flow-screens/model/add_agri_member_model.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/model/add_breeding_member_model.dart';
import 'package:capef/screens-cubits/fishing-flow-screens/model/add_fishing_member_model.dart';
import 'package:capef/screens-cubits/forest-flow-screens/model/add_forest_member_model.dart';

class HiveFunctions {
  static Map<String, dynamic> saveToMembers(
      {UserInfo? userInfo, LegalEntityInfo? legalEntityInfo}) {
    if (legalEntityInfo == null) {
      hiveBoxName(boxName: membersBox).get('members');

      if (hiveBoxName(boxName: membersBox).get('members') == null) {
        hiveBoxName(boxName: membersBox).put('members', [jsonEncode(userInfo)]);
        var t = hiveBoxName(boxName: membersBox).get('members');
        print(t);

        return {
          "memberid": -1,
          "onlineid": "",
          "offlineid": userInfo?.offlineId,
          "photocnifronturl": userInfo?.photocnifront?.path,
          "photocnibackurl": userInfo?.photocniback?.path,
          "photomemberurl": userInfo?.photomember?.path,
          "status": {
            "isValid": true,
            "message": "Success",
            "devmessage": "No error",
            "code": 0,
          },
        };
      } else {
        List<String> existingMembers =
            hiveBoxName(boxName: membersBox).get('members') ?? [];

        existingMembers.add(jsonEncode(userInfo));
        hiveBoxName(boxName: membersBox).put('members', existingMembers);
        var t = hiveBoxName(boxName: membersBox).get('members');
        print(t);
        return {
          "memberid": -1,
          "onlineid": "",
          "offlineid": userInfo?.offlineId,
          "photocnifronturl": userInfo?.photocnifront?.path,
          "photocnibackurl": userInfo?.photocniback?.path,
          "photomemberurl": userInfo?.photomember?.path,
          "status": {
            "isValid": true,
            "message": "Success",
            "devmessage": "No error",
            "code": 0,
          },
        };
      }
    } else {
      hiveBoxName(boxName: membersBox).get('members');

      if (hiveBoxName(boxName: membersBox).get('members') == null) {
        hiveBoxName(boxName: membersBox)
            .put('members', [jsonEncode(legalEntityInfo)]);
        var t = hiveBoxName(boxName: membersBox).get('members');
        print(t);

        return {
          "memberid": -1,
          "onlineid": "",
          "offlineid": legalEntityInfo.offlineId,
          "photoregistrationurl": legalEntityInfo.photoRegistration?.path,
          "status": {
            "isValid": true,
            "message": "Success",
            "devmessage": "No error",
            "code": 0,
          },
        };
      } else {
        List<String> existingMembers =
            hiveBoxName(boxName: membersBox).get('members') ?? [];

        existingMembers.add(jsonEncode(legalEntityInfo));
        hiveBoxName(boxName: membersBox).put('members', existingMembers);
        var t = hiveBoxName(boxName: membersBox).get('members');
        print(t);
        return {
          "memberid": -1,
          "onlineid": "",
          "offlineid": legalEntityInfo.offlineId,
          "photoregistrationurl": legalEntityInfo.photoRegistration?.path,
          "status": {
            "isValid": true,
            "message": "Success",
            "devmessage": "No error",
            "code": 0,
          },
        };
      }
    }
  }

  static Status saveCategoryToMember({
    AddFishingMemberModel? addFishingMemberModel,
    AddAgriMemberModel? addAgriMemberModel,
    AddBreedingMemberModel? addBreedingMemberModel,
    AddForestMemberModel? addForestMemberModel,
  }) {
    if (addFishingMemberModel != null) {
      hiveBoxName(boxName: membersBox).get('categories');
      if (hiveBoxName(boxName: membersBox).get('categories') == null) {
        hiveBoxName(boxName: membersBox)
            .put('categories', [jsonEncode(addFishingMemberModel)]);

        var t = hiveBoxName(boxName: membersBox).get('categories');
        print(t);
        Status status = Status.fromJson({
          "isValid": true,
          "message": "Success",
          "devmessage": "No error",
          "code": 0,
        });
        return status;
      } else {
        List<String> existingCategories =
            hiveBoxName(boxName: membersBox).get('categories') ?? [];

        existingCategories.add(jsonEncode(addFishingMemberModel));

        hiveBoxName(boxName: membersBox).put('categories', existingCategories);
        var t = hiveBoxName(boxName: membersBox).get('categories');
        print(t);

        Status status = Status.fromJson({
          "isValid": true,
          "message": "Success",
          "devmessage": "No error",
          "code": 0,
        });
        return status;
      }
    }
    if (addAgriMemberModel != null) {
      hiveBoxName(boxName: membersBox).get('categories');
      if (hiveBoxName(boxName: membersBox).get('categories') == null) {
        hiveBoxName(boxName: membersBox)
            .put('categories', [jsonEncode(addAgriMemberModel)]);

        var t = hiveBoxName(boxName: membersBox).get('categories');
        print(t);

        Status status = Status.fromJson({
          "isValid": true,
          "message": "Success",
          "devmessage": "No error",
          "code": 0,
        });
        return status;
      } else {
        List<String> existingCategories =
            hiveBoxName(boxName: membersBox).get('categories') ?? [];

        existingCategories.add(jsonEncode(addAgriMemberModel));

        hiveBoxName(boxName: membersBox).put('categories', existingCategories);
        var t = hiveBoxName(boxName: membersBox).get('categories');
        print(t);

        Status status = Status.fromJson({
          "isValid": true,
          "message": "Success",
          "devmessage": "No error",
          "code": 0,
        });
        return status;
      }
    }
    if (addBreedingMemberModel != null) {
      hiveBoxName(boxName: membersBox).get('categories');
      if (hiveBoxName(boxName: membersBox).get('categories') == null) {
        hiveBoxName(boxName: membersBox)
            .put('categories', [jsonEncode(addBreedingMemberModel)]);

        var t = hiveBoxName(boxName: membersBox).get('categories');
        print(t);

        Status status = Status.fromJson({
          "isValid": true,
          "message": "Success",
          "devmessage": "No error",
          "code": 0,
        });
        return status;
      } else {
        List<String> existingCategories =
            hiveBoxName(boxName: membersBox).get('categories') ?? [];

        existingCategories.add(jsonEncode(addBreedingMemberModel));

        hiveBoxName(boxName: membersBox).put('categories', existingCategories);
        var t = hiveBoxName(boxName: membersBox).get('categories');
        print(t);

        Status status = Status.fromJson({
          "isValid": true,
          "message": "Success",
          "devmessage": "No error",
          "code": 0,
        });
        return status;
      }
    }
    if (addForestMemberModel != null) {
      hiveBoxName(boxName: membersBox).get('categories');
      if (hiveBoxName(boxName: membersBox).get('categories') == null) {
        hiveBoxName(boxName: membersBox)
            .put('categories', [jsonEncode(addForestMemberModel)]);

        var t = hiveBoxName(boxName: membersBox).get('categories');
        print(t);
        Status status = Status.fromJson({
          "isValid": true,
          "message": "Success",
          "devmessage": "No error",
          "code": 0,
        });
        return status;
      } else {
        List<String> existingCategories =
            hiveBoxName(boxName: membersBox).get('categories') ?? [];

        existingCategories.add(jsonEncode(addForestMemberModel));

        hiveBoxName(boxName: membersBox).put('categories', existingCategories);
        var t = hiveBoxName(boxName: membersBox).get('categories');
        print(t);

        Status status = Status.fromJson({
          "isValid": true,
          "message": "Success",
          "devmessage": "No error",
          "code": 0,
        });
        return status;
      }
    }

    Status status = Status.fromJson({
      "status": {
        "isValid": false,
        "message": "Critical Error Occured",
        "devmessage": "Critical Error Occured",
        "code": 5,
      }
    });
    return status;
  }
}
