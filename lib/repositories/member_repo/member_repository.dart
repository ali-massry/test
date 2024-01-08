// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:capef/hive/hive_functions.dart';
import 'package:capef/models/add_individual_member_success.dart';
import 'package:capef/models/add_legal_entity_success.dart';
import 'package:capef/models/detailed_member_model.dart';
import 'package:capef/models/legal_entity_info.dart';
import 'package:capef/models/update_individual_member_model.dart';
import 'package:capef/models/user_info_model.dart';
import 'package:capef/models/user_info_to_be_edited_model.dart';
import 'package:capef/services/network_service.dart';
import 'package:capef/utils/functions.dart';
import 'package:http/http.dart' as http;
import 'package:capef/utils/constant.dart';

class MemberRepository {
  static Future<dynamic> getMemberById(
      {required String jwttoken, required String memberId}) async {
    String url = '$apiUrl/Members/GetMemberByID';

    Map<String, String> body = {"memberid": memberId};

    final response = await NetworkService.httpPostRequest(
        url: url, body: body, jwtToken: jwttoken);

    DetailedMemberModel detailedMemberModel =
        DetailedMemberModel.fromJson(response);

    return detailedMemberModel;
  }

  static Future<dynamic> addIndividualMember(
      {required UserInfo? userInfo, required String? jwtToken}) async {
    String url = '$apiUrl/Members/addindividualmember';
    if (!await GlobalFunctions.hasNetwork()) {
      return HiveFunctions.saveToMembers(userInfo: userInfo);

      // print('object');
      // Hive.box('offlineData').put('members', jsonEncode(userInfo));
      // var t = jsonDecode(Hive.box('localStorage').get('members'));
      // print(t);
    } else {
      var stream = http.ByteStream(userInfo!.photomember!.openRead());
      stream.cast();
      var length = await userInfo.photomember!.length();
      var multiportPhoto = http.MultipartFile('photomember', stream, length,
          filename: userInfo.photomember!.path.split("/").last);
      var streamBack = http.ByteStream(userInfo.photocniback!.openRead());
      streamBack.cast();
      var versoLength = await userInfo.photocniback!.length();
      var multiportVersoPhoto = http.MultipartFile(
          'photocniback', streamBack, versoLength,
          filename: userInfo.photocniback!.path.split("/").last);
      var streamFront = http.ByteStream(userInfo.photocnifront!.openRead());
      streamFront.cast();
      var rectoLength = await userInfo.photocnifront!.length();
      var multiportRectoPhoto = http.MultipartFile(
          'photocnifront', streamFront, rectoLength,
          filename: userInfo.photocnifront!.path.split("/").last);

      Map<String, String> headers = {
        if (jwtToken != null) 'Authorization': 'Bearer $jwtToken'
      };

      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);
      // Map<String, dynamic> body = {
      request.fields['firstname'] = userInfo.firstname;
      request.fields['lastname'] = userInfo.lastname;
      request.fields['offlineid'] = userInfo.offlineId;
      request.fields['materialstatusid'] = userInfo.meterialStatusid;
      request.fields["pin"] = userInfo.pin.toString();
      request.fields["secanswer"] = userInfo.secanswer.toString();
      request.fields["securityqstid"] = userInfo.securityqstid;
      request.fields["pobox"] = userInfo.pobox;
      request.fields["latitude"] = userInfo.latitude;
      request.fields["longitude"] = userInfo.longitude;
      request.fields["mainactivityid"] = userInfo.mainactivityid;
      if (userInfo.secondaryactivityid != 'null') {
        request.fields["secondaryactivityid"] = userInfo.secondaryactivityid;
      }
      request.fields["civilityid"] = userInfo.civilityid;
      request.fields["genderid"] = userInfo.genderid;
      request.fields["dob"] = userInfo.dob;
      request.fields["placeofbirth"] = userInfo.placeofbirth;
      request.fields["phone1"] = userInfo.phone1;
      request.fields["phone2"] = userInfo.phone2;
      request.fields["email"] = userInfo.email;
      request.fields["op"] = userInfo.op;
      request.fields["cninumber"] = userInfo.cni;
      request.fields["villageid"] = userInfo.villageid;
      request.fields["seasonpayment"] = userInfo.seasonpayment;
      request.fields["subscriptionpayment"] = userInfo.subscriptionpayment;
      request.files.add(multiportPhoto);
      request.files.add(multiportVersoPhoto);
      request.files.add(multiportRectoPhoto);

      var response = await request.send();
      final data = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(data);
        var r = AddIndividualMemberSuccess.fromJson(decodedData);
        // var r = (decodedData as AddIndividualMemberSuccess).status;
        print(r);
        return decodedData;
      } else {
        return response;
      }
    }
  }

  static Future<dynamic> updateIndividualMember(
      {UserInfo? userInfo,
      required String? jwtToken,
      UserInfoEdited? userInfoEdited}) async {
    String url = '$apiUrl/Members/UpdateIndividualMember';

    Map<String, String> headers = {
      if (jwtToken != null) 'Authorization': 'Bearer $jwtToken'
    };

    final request = http.MultipartRequest('POST', Uri.parse(url));
    if (userInfoEdited?.photomember != null) {
      var stream = http.ByteStream(userInfoEdited!.photomember!.openRead());
      stream.cast();
      var length = await userInfoEdited.photomember!.length();
      var multiportPhoto = http.MultipartFile('photomember', stream, length,
          filename: userInfoEdited.photomember!.path.split("/").last);
      request.files.add(multiportPhoto);
    }
    if (userInfoEdited?.photocniback != null) {
      var streamBack =
          http.ByteStream(userInfoEdited!.photocniback!.openRead());
      streamBack.cast();
      var versoLength = await userInfoEdited.photocniback!.length();
      var multiportVersoPhoto = http.MultipartFile(
          'photocniback', streamBack, versoLength,
          filename: userInfoEdited.photocniback!.path.split("/").last);
      request.files.add(multiportVersoPhoto);
    }

    if (userInfoEdited?.photocnifront != null) {
      var streamFront =
          http.ByteStream(userInfoEdited!.photocnifront!.openRead());
      streamFront.cast();
      var rectoLength = await userInfoEdited.photocnifront!.length();
      var multiportRectoPhoto = http.MultipartFile(
          'photocnifront', streamFront, rectoLength,
          filename: userInfoEdited.photocnifront!.path.split("/").last);
      request.files.add(multiportRectoPhoto);
    }
    request.headers.addAll(headers);
    // Map<String, dynamic> body = {
    if (userInfoEdited?.firstname != null) {
      request.fields['firstname'] = userInfoEdited!.firstname;
    }
    if (userInfoEdited?.lastname != null) {
      request.fields['lastname'] = userInfoEdited!.lastname;
    }
    if (userInfo == null) {
      if (userInfoEdited?.onlineId != '') {
        request.fields['onlineid'] = userInfoEdited!.onlineId;
      }
    } else {
      if (userInfo.offlineId != '') {
        request.fields['onlineid'] = userInfo.offlineId;
      }
    }
    if (userInfoEdited?.meterialStatusid != null) {
      request.fields['materialstatusid'] = userInfoEdited!.meterialStatusid;
    }
    if (userInfo?.pobox != null) request.fields["pobox"] = userInfo!.pobox;
    if (userInfo?.latitude != null) {
      request.fields["latitude"] = userInfo!.latitude;
    }
    if (userInfo?.longitude != null) {
      request.fields["longitude"] = userInfo!.longitude;
    }
    if (userInfoEdited?.civilityid != null) {
      request.fields["titleid"] = userInfoEdited!.civilityid;
    }
    if (userInfoEdited?.genderid != null) {
      request.fields["genderid"] = userInfoEdited!.genderid;
    }
    if (userInfoEdited?.dob != null) {
      request.fields["dob"] = userInfoEdited!.dob;
    }
    if (userInfoEdited?.placeofbirth != null) {
      request.fields["placeofbirth"] = userInfoEdited!.placeofbirth;
    }
    if (userInfoEdited?.phone1 != null) {
      request.fields["phone1"] = userInfoEdited!.phone1;
    }
    if (userInfoEdited?.phone2 != null) {
      request.fields["phone2"] = userInfoEdited!.phone2;
    }

    if (userInfoEdited?.email != null) {
      request.fields["email"] = userInfoEdited!.email;
    }
    if (userInfoEdited?.op != null) {
      request.fields["op"] = userInfoEdited!.op;
    }
    if (userInfoEdited?.cni != null) {
      request.fields["cninumber"] = userInfoEdited!.cni;
    }
    if (userInfo?.villageid != null) {
      request.fields["villageid"] = userInfo!.villageid;
    }

    var response = await request.send();
    final data = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(data);
      var r = UpdateLIndividualMemberModel.fromJson(decodedData);
      // var r = (decodedData as AddIndividualMemberSuccess).status;
      print(r);
      return decodedData;
    } else {
      return response;
    }
  }

  static Future<dynamic> addlegalEntityMember(
      {required LegalEntityInfo? legalEntityInfo,
      required String? jwtToken}) async {
    String url = '$apiUrl/Members/addlegalentitymember';
    if (!await GlobalFunctions.hasNetwork()) {
      print('NO INTERNET');
      return HiveFunctions.saveToMembers(legalEntityInfo: legalEntityInfo);
    } else {
      var stream =
          http.ByteStream(legalEntityInfo!.photoRegistration!.openRead());
      stream.cast();
      var length = await legalEntityInfo.photoRegistration!.length();
      var multiportPhoto = http.MultipartFile(
          'photoregistration', stream, length,
          filename: legalEntityInfo.photoRegistration!.path.split("/").last);

      Map<String, String> headers = {
        if (jwtToken != null) 'Authorization': 'Bearer $jwtToken'
      };

      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);
      // Map<String, dynamic> body = {
      request.fields['offlineid'] = legalEntityInfo.offlineId ?? '';
      request.fields['legalentitycategoryid'] =
          legalEntityInfo.legalentitycategoryid ?? '';
      request.fields['turnoverid'] = legalEntityInfo.turnoverid ?? '';
      request.fields['name'] = legalEntityInfo.name ?? '';
      request.fields['regnumber'] = legalEntityInfo.regnumber ?? '';
      request.fields['certificatedate'] = legalEntityInfo.certificatedate ?? '';
      request.fields['pin'] = legalEntityInfo.pin ?? '';
      request.fields['secanswer'] = legalEntityInfo.secanswer ?? '';
      request.fields['securityqstid'] = legalEntityInfo.securityqstid ?? '';
      request.fields['phone1'] = legalEntityInfo.phone1 ?? '';
      request.fields['phone2'] = legalEntityInfo.phone2 ?? '';
      request.fields['email'] = legalEntityInfo.email ?? '';
      request.fields['website'] = legalEntityInfo.website ?? '';
      request.fields['noofmembers'] = legalEntityInfo.noofmembers ?? '';
      request.fields['women'] = legalEntityInfo.women ?? '';
      request.fields['villageid'] = legalEntityInfo.villageid ?? '';
      request.fields['seasonpayment'] = legalEntityInfo.seasonpayment ?? '';
      request.fields['subscriptionpayment'] =
          legalEntityInfo.subscriptionpayment ?? '';
      request.fields['pobox'] = legalEntityInfo.pobox ?? '';
      request.fields['mainactivityid'] = legalEntityInfo.mainactivityid ?? '';
      request.fields['secondaryactivityid'] =
          legalEntityInfo.secondaryactivityid ?? '';
      request.fields['representatives'] =
          legalEntityInfo.representativesJson ?? '';
      request.fields['latitude'] = legalEntityInfo.lat ?? '';
      request.fields['longitude'] = legalEntityInfo.long ?? '';
      request.files.add(multiportPhoto);
      var response = await request.send();
      final data = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(data);
        var r = AddLegalEntitySuccessModel.fromJson(decodedData);
        // var r = (decodedData as AddIndividualMemberSuccess).status;
        print(r);
        return decodedData;
      } else {
        var s = jsonDecode(data);
        return s;
      }
    }
  }

  static Future<dynamic> updateLegalEntityMember(
      {LegalEntityInfo? legalEntityInfo, required String? jwtToken}) async {
    String url = '$apiUrl/Members/UpdateLegalEntityMember';

    Map<String, String> headers = {
      if (jwtToken != null) 'Authorization': 'Bearer $jwtToken'
    };

    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    if (legalEntityInfo!.photoRegistration != null) {
      var stream =
          http.ByteStream(legalEntityInfo.photoRegistration!.openRead());
      stream.cast();
      var length = await legalEntityInfo.photoRegistration!.length();
      var multiportPhoto = http.MultipartFile(
          'photoregistration', stream, length,
          filename: legalEntityInfo.photoRegistration!.path.split("/").last);
      request.files.add(multiportPhoto);
    }
    // Map<String, dynamic> body = {
    if (legalEntityInfo.offlineId != null) {
      request.fields['onlineid'] = legalEntityInfo.offlineId ?? '';
    }
    if (legalEntityInfo.legalentitycategoryid != null) {
      request.fields['legalentitycategoryid'] =
          legalEntityInfo.legalentitycategoryid ?? '';
    }
    if (legalEntityInfo.turnoverid != null ||
        legalEntityInfo.turnoverid != '') {
      request.fields['turnoverid'] = legalEntityInfo.turnoverid ?? '';
    }
    if (legalEntityInfo.pobox != null) {
      request.fields['pobox'] = legalEntityInfo.pobox ?? '';
    }
    if (legalEntityInfo.name != null) {
      request.fields['name'] = legalEntityInfo.name ?? '';
    }
    if (legalEntityInfo.regnumber != null) {
      request.fields['regnumber'] = legalEntityInfo.regnumber ?? '';
    }
    if (legalEntityInfo.certificatedate != null) {
      request.fields['certificatedate'] = legalEntityInfo.certificatedate ?? '';
    }
    if (legalEntityInfo.phone1 != null) {
      request.fields['phone1'] = legalEntityInfo.phone1 ?? '';
    }
    if (legalEntityInfo.phone2 != null) {
      request.fields['phone2'] = legalEntityInfo.phone2 ?? '';
    }
    if (legalEntityInfo.email != null) {
      request.fields['email'] = legalEntityInfo.email ?? '';
    }
    if (legalEntityInfo.website != null) {
      request.fields['website'] = legalEntityInfo.website ?? '';
    }
    if (legalEntityInfo.noofmembers != null) {
      request.fields['noofmembers'] = legalEntityInfo.noofmembers ?? '';
    }
    if (legalEntityInfo.women != null) {
      request.fields['women'] = legalEntityInfo.women ?? '';
    }
    if (legalEntityInfo.villageid != null) {
      request.fields['villageid'] = legalEntityInfo.villageid ?? '';
    }
    if (legalEntityInfo.long != null) {
      request.fields['longitude'] = legalEntityInfo.long ?? '';
    }
    if (legalEntityInfo.lat != null) {
      request.fields['latitude'] = legalEntityInfo.lat ?? '';
    }
    var response = await request.send();
    final data = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(data);
      var r = UpdateLIndividualMemberModel.fromJson(decodedData);
      // var r = (decodedData as AddIndividualMemberSuccess).status;
      print(r);
      return decodedData;
    } else {
      return response;
    }
  }
}
