import 'dart:convert';
import 'dart:developer';

import 'package:flutter_ocean_radiation_level/data/keys.dart';
import 'package:flutter_ocean_radiation_level/data/source/local/ocean_radiation_level_dao.dart';
import 'package:flutter_ocean_radiation_level/data/source/local/ocean_radition_level_entity.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

Future fetchXmlDataApi() async {
  try {
    // 원하는 API URL로 요청
    String url = 'http://www.nfqs.go.kr/hpmg/front/api/smp_ra_api.do?'
        'cert_key=$certKey&start_dt=20230920&end_dt=20230922';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // API로부터 응답을 가져옴
      String xmlData = response.body;

      // Xml 데이터를 Json으로 변환하기 위해 xml2json 객체 생성
      final Xml2Json xml2Json = Xml2Json();

      // Xml 데이터를 Json으로 변환
      xml2Json.parse(xmlData);
      var jsonData = xml2Json.toParker();
      // log('jsonData: ${jsonData.toString()}');

      // final Map<String, dynamic> data = json.decode(jsonData);
      //
      // if (data["response"]["header"]["resultCode"] == "00") {
      //   print('ok');
      //   (data["response"]["body"]["items"]["item"] as List)
      //       .forEach((element) async {
      //     print(element["smpNo"]);
      //     print(element["itmCd"]);
      //     print( element["gathMchnCd"]);
      //     print( element["gathMchnNm"]);


          // 제이슨 데이터 투 스트링 이렇게 하는거 맞는교???
         //print( jsonData.toString());

      //     try {
      //       await OceanRaditionLevelDao()
      //           .insertradition_level(OceanRaditionLevelEntity(
      //         smpNo: element["smpNo"]?? '',
      //         gathMchnCd: element["gathMchnCd"] ?? '',
      //         gathMchnNm: element["gathMchnNm"]?? '',
      //         itmCd: element["itmCd"] ?? '',
      //         itmNm: element["itmNm"] ?? '',
      //         survLocCd: element["survLocCd"] ?? '',
      //         survLocNm: element["survLocNm"] ?? '',
      //         gathDt: element["gathDt"] ?? '',
      //         ogLoc: element["ogLoc"] ?? '',
      //         analRqstDt: element["analRqstDt"] ?? '',
      //         analStDt: element["analStDt"] ?? '',
      //         analEndDt: element["analEndDt"] ?? '',
      //         survCiseCd: element["survCiseCd"] ?? '',
      //         survCiseNm: element["survCiseNm"] ?? '',
      //         dtldSurvCiseNm: element["dtldSurvCiseNm"] ?? '',
      //         inspKdCd: element["inspKdCd"] ?? '',
      //         inspKdNm: element["inspKdNm"] ?? '',
      //         numAnalRsltVal: element["numAnalRsltVal"] ?? '',
      //         charAnalRsltVal: element["charAnalRsltVal"] ?? '',
      //         charPsngVal: element["charPsngVal"] ?? '',
      //         charUnPsngVal: element["charUnPsngVal"] ?? '',
      //         numPsngMinVal: element["numPsngMinVal"] ?? '',
      //         numPsngMaxVal: element["numPsngMaxVal"] ?? '',
      //         itmFtnsYn: element["itmFtnsYn"] ?? '',
      //         ciseFtnsYn: element["ciseFtnsYn"] ?? '',
      //         analMchnCd: element["analMchnCd"] ?? '',
      //         analMchnNm: element["analMchnNm"] ?? '',
      //         analDevia: element["analDevia"] ?? '',
      //         mda: element["mda"] ?? '',
      //         survUnitCd: element["survUnitCd"] ?? '',
      //         survUnitNm: element["survUnitNm"] ?? '',
      //
      //       ));
      //     } catch (e) {
      //       log('에러!!!!!!!!!!!! $e');
      //     }
      //   });
      // }


       //log('jsonData: ${data["response"]["body"]["items"]["item"]["smpNo"].toString()}');

      // Json 데이터를 저장
      await saveJsonData(jsonData);
    } else {
      throw Exception('Failed to load XML data');
    }
  } catch (e) {
    print('Error: $e');
  }
}

// 하이브 로 변경하기
Future<void> saveJsonData(String jsonData) async {}
