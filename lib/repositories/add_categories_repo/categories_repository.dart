// ignore_for_file: avoid_print

import 'package:capef/hive/hive_functions.dart';
import 'package:capef/models/error_response.dart';
import 'package:capef/screens-cubits/agri-flow-screens/model/add_agri_member_model.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/model/add_breeding_member_model.dart';
import 'package:capef/screens-cubits/fishing-flow-screens/model/add_fishing_member_model.dart';
import 'package:capef/screens-cubits/forest-flow-screens/model/add_forest_member_model.dart';
import 'package:capef/services/network_service.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/functions.dart';

class CategoriesRepository {
  static Future<dynamic> addFishingMember(
      {required AddFishingMemberModel addFishingMemberModel,
      final String? jwtToken}) async {
    String url = '$apiUrl/Members/AddFishingMemberCategory';
    Map<String, dynamic> body = {
      "id": addFishingMemberModel.offOnId,
      "regionid": addFishingMemberModel.regionId,
      "districtid": addFishingMemberModel.districtId,
      "areaid": addFishingMemberModel.areaId,
      "villageid": addFishingMemberModel.villageId,
      "linkids": addFishingMemberModel.linkids,
      "fishings": addFishingMemberModel.fishings
    };

    if (!await (GlobalFunctions.hasNetwork())) {
      return HiveFunctions.saveCategoryToMember(
          addFishingMemberModel: addFishingMemberModel);
    }

    final response = await NetworkService.httpPostRequest(
        url: url, body: body, jwtToken: jwtToken);

    Status status = Status.fromJson(response['status']);
    return status;
  }

  static Future<dynamic> addAgricultureMember(
      {required AddAgriMemberModel addAgriMemberModel,
      final String? jwtToken}) async {
    String url = '$apiUrl/Members/AddAgriMemberCategory';
    Map<String, dynamic> body = {
      "id": addAgriMemberModel.id,
      "regionid": addAgriMemberModel.regionid,
      "districtid": addAgriMemberModel.districtid,
      "areaid": addAgriMemberModel.areaid,
      "villageid": addAgriMemberModel.villageid,
      "linkids": addAgriMemberModel.linkids,
      "lands": addAgriMemberModel.lands
    };
    if (!await (GlobalFunctions.hasNetwork())) {
      return HiveFunctions.saveCategoryToMember(
          addAgriMemberModel: addAgriMemberModel);
    }

    final response = await NetworkService.httpPostRequest(
        url: url, body: body, jwtToken: jwtToken);

    Status status = Status.fromJson(response['status']);
    return status;
  }

  static Future<dynamic> addBreedingMember(
      {required AddBreedingMemberModel addBreedingMemberModel,
      final String? jwtToken}) async {
    String url = '$apiUrl/Members/AddBreedingMemberCategory';
    Map<String, dynamic> body = {
      "id": addBreedingMemberModel.id,
      "regionid": addBreedingMemberModel.region,
      "districtid": addBreedingMemberModel.district,
      "areaid": addBreedingMemberModel.area,
      "villageid": addBreedingMemberModel.village,
      "linkids": addBreedingMemberModel.linkids,
      "breedings": addBreedingMemberModel.breedings
    };

    if (!await (GlobalFunctions.hasNetwork())) {
      return HiveFunctions.saveCategoryToMember(
          addBreedingMemberModel: addBreedingMemberModel);
    }

    final response = await NetworkService.httpPostRequest(
        url: url, body: body, jwtToken: jwtToken);

    Status status = Status.fromJson(response['status']);
    return status;
  }

  static Future<dynamic> addForestMember(
      {required AddForestMemberModel addForestMemberModel,
      String? jwtToken}) async {
    print(jwtToken);
    // print(
    //     'ADD FOREST MODEL ${jsonEncode(addForestMemberModel.forests.toString)}');

    String url = '$apiUrl/Members/AddForestMemberCategory';
    Map<String, dynamic> body = {
      "id": addForestMemberModel.id,
      "regionid": addForestMemberModel.regionid,
      "districtid": addForestMemberModel.districtid,
      "areaid": addForestMemberModel.areaid,
      "villageid": addForestMemberModel.villageid,
      "linkids": addForestMemberModel.linkids,
      "forests": addForestMemberModel.forests,
    };

    if (!await (GlobalFunctions.hasNetwork())) {
      return HiveFunctions.saveCategoryToMember(
          addForestMemberModel: addForestMemberModel);
    }

    final response = await NetworkService.httpPostRequest(
        url: url, body: body, jwtToken: jwtToken);

    Status status = Status.fromJson(response['status']);
    return status;
  }

  static Future<dynamic> removeCategory(
      {required int? categoryId, String? jwtToken}) async {
    print(jwtToken);

    String url = '$apiUrl/Members/RemoveCategoryByID';
    Map<String, dynamic> body = {"membercatid": categoryId};

    final response = await NetworkService.httpPostRequest(
        url: url, body: body, jwtToken: jwtToken);

    Status status = Status.fromJson(response['status']);
    return status;
  }
}
