import 'dart:convert';
import 'dart:developer';
import 'package:flutter_ocean_radiation_level/data/keys.dart';
import 'package:flutter_ocean_radiation_level/data/source/local/ocean_radiation_level_dao.dart';
import 'package:flutter_ocean_radiation_level/data/source/local/ocean_radition_level_entity.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml2json/xml2json.dart';

class OceanRaditionLevelApi {
  final http.Client client;

  OceanRaditionLevelApi(this.client);

  Future fetchXmlDataApi({required String startDate, required endDate}) async {
    try {
      // 원하는 API URL로 요청
      String url = 'http://www.nfqs.go.kr/hpmg/front/api/smp_ra_api.do?'
          'cert_key=$certKey&start_dt=$startDate&end_dt=$endDate';
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

        final Map<String, dynamic> data = json.decode(jsonData);

        if (data["response"]["header"]["resultCode"] == "00") {
          print('ok');
          (data["response"]["body"]["items"]["item"] as List)
              .forEach((element) async {
                // print(element["smpNo"]);
            await OceanRaditionLevelDao()
                .insertraditionLevel(OceanRaditionLevelEntity(
              smpNo: element["smpNo"],
              gathMchnCd: element["gathMchnCd"],
              gathMchnNm: element["gathMchnNm"],
              itmCd: element["itmCd"],
              itmNm: element["itmNm"],
              survLocCd: element["survLocCd"],
              survLocNm: element["survLocNm"],
              gathDt: element["gathDt"],
              ogLoc: element["ogLoc"] ?? '',
              analRqstDt: element["analRqstDt"],
              analStDt: element["analStDt"],
              analEndDt: element["analEndDt"],
              survCiseCd: element["survCiseCd"],
              survCiseNm: element["survCiseNm"],
              dtldSurvCiseNm: element["dtldSurvCiseNm"],
              inspKdCd: element["inspKdCd"],
              inspKdNm: element["inspKdNm"],
              numAnalRsltVal: element["numAnalRsltVal"] ?? '',
              charAnalRsltVal: element["charAnalRsltVal"],
              charPsngVal: element["charPsngVal"],
              charUnPsngVal: element["charUnPsngVal"] ?? '',
              numPsngMinVal: element["numPsngMinVal"],
              numPsngMaxVal: element["numPsngMaxVal"],
              itmFtnsYn: element["itmFtnsYn"],
              ciseFtnsYn: element["ciseFtnsYn"],
              analMchnCd: element["analMchnCd"],
              analMchnNm: element["analMchnNm"],
              analDevia: element["analDevia"] ?? '',
              mda: element["mda"] ?? '',
              survUnitCd: element["survUnitCd"],
              survUnitNm: element["survUnitNm"],
            ));
          });
        }

        //테스트
        // // 테스트
        // OceanRaditionLevelDao().insertraditionLevel(
        //   OceanRaditionLevelEntity(smpNo: '1111'),
        // );
        // if (data["response"]["header"]["resultCode"] == "00") {
        //   print('hok');
        //   (data["response"]["body"]["items"]["item"] as List)
        //       .forEach((element) async {
        //     await OceanRaditionLevelDao()
        //         .getAllRaditionLevel(OceanRaditionLevelEntity(
        //       smpNo: element["smpNo"],
        //       gathMchnCd: element["gathMchnCd"],
        //       gathMchnNm: element["gathMchnNm"],
        //       itmCd: element["itmCd"],
        //       itmNm: element["itmNm"],
        //       survLocCd: element["survLocCd"],
        //       survLocNm: element["survLocNm"],
        //       gathDt: element["gathDt"],
        //       ogLoc: element["ogLoc"] ?? '',
        //       analRqstDt: element["analRqstDt"],
        //       analStDt: element["analStDt"],
        //       analEndDt: element["analEndDt"],
        //       survCiseCd: element["survCiseCd"],
        //       survCiseNm: element["survCiseNm"],
        //       dtldSurvCiseNm: element["dtldSurvCiseNm"],
        //       inspKdCd: element["inspKdCd"],
        //       inspKdNm: element["inspKdNm"],
        //       numAnalRsltVal: element["numAnalRsltVal"] ?? '',
        //       charAnalRsltVal: element["charAnalRsltVal"],
        //       charPsngVal: element["charPsngVal"],
        //       charUnPsngVal: element["charUnPsngVal"] ?? '',
        //       numPsngMinVal: element["numPsngMinVal"],
        //       numPsngMaxVal: element["numPsngMaxVal"],
        //       itmFtnsYn: element["itmFtnsYn"],
        //       ciseFtnsYn: element["ciseFtnsYn"],
        //       analMchnCd: element["analMchnCd"],
        //       analMchnNm: element["analMchnNm"],
        //       analDevia: element["analDevia"] ?? '',
        //       mda: element["mda"] ?? '',
        //       survUnitCd: element["survUnitCd"],
        //       survUnitNm: element["survUnitNm"],
        //     ));
        //   });
        // }
       // 테스트
        //List<OceanRaditionLevelEntity> dataT = await OceanRaditionLevelDao().getAllRaditionLevel(OceanRaditionLevelEntity(smpNo: '0772023-1810'));

        //log('dataT ${dataT.length}, smpNo: ${dataT[0].smpNo}');
       // log('jsonData: ${data["response"]["body"]["items"]["item"]["smpNo"].toString()}');




        // Json 데이터를 저장
        await saveJsonData(jsonData);
      } else {
        throw Exception('Failed to load XML data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> saveJsonData(String jsonData) async {
    try {
      // SharedPreferences 인스턴스 생성
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // JSON 데이터를 'jsonData' 키에 저장
      await prefs.setString('jsonData', jsonData);
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<http.Response> saveJsonDatagetOceanRaditionLevelListings(
      {String certKey = certKey,
      required String startDate,
      required String endDate}) async {
    return await client.get(
      Uri.parse('http://www.nfqs.go.kr/hpmg/front/api/smp_ra_api.do?'
          'cert_key=$certKey&start_dt=$startDate&end_dt=$endDate'),
    );

  }
}
