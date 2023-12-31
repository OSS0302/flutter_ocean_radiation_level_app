import 'dart:convert';
import 'dart:developer';
import 'package:flutter_ocean_radiation_level/data/keys.dart';
import 'package:flutter_ocean_radiation_level/data/source/local/ocean_radition_level_entity.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml2json/xml2json.dart';

Future getOneDataFromApi({required String startDate, required endDate}) async {
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
      List<OceanRaditionLevelEntity> listResult = [];
      if (data["response"]["header"]["resultCode"] == "00") {
        print('ok');
        (data["response"]["body"]["items"]["item"] as List)
            .forEach((element) async {
         // print(element["smpNo"]);

          listResult.add(element);
          //print(listResult).toString();

          // await OceanRaditionLevelDao()
          //     .insertraditionLevel(OceanRaditionLevelEntity(
          //   smpNo: element["smpNo"],
          //   gathMchnCd: element["gathMchnCd"],
          //   gathMchnNm: element["gathMchnNm"],
          //   itmCd: element["itmCd"],
          //   itmNm: element["itmNm"],
          //   survLocCd: element["survLocCd"],
          //   survLocNm: element["survLocNm"],
          //   gathDt: element["gathDt"],
          //   ogLoc: element["ogLoc"] ?? '',
          //   analRqstDt: element["analRqstDt"],
          //   analStDt: element["analStDt"],
          //   analEndDt: element["analEndDt"],
          //   survCiseCd: element["survCiseCd"],
          //   survCiseNm: element["survCiseNm"],
          //   dtldSurvCiseNm: element["dtldSurvCiseNm"],
          //   inspKdCd: element["inspKdCd"],
          //   inspKdNm: element["inspKdNm"],
          //   numAnalRsltVal: element["numAnalRsltVal"] ?? '',
          //   charAnalRsltVal: element["charAnalRsltVal"],
          //   charPsngVal: element["charPsngVal"],
          //   charUnPsngVal: element["charUnPsngVal"] ?? '',
          //   numPsngMinVal: element["numPsngMinVal"],
          //   numPsngMaxVal: element["numPsngMaxVal"],
          //   itmFtnsYn: element["itmFtnsYn"],
          //   ciseFtnsYn: element["ciseFtnsYn"],
          //   analMchnCd: element["analMchnCd"],
          //   analMchnNm: element["analMchnNm"],
          //   analDevia: element["analDevia"] ?? '',
          //   mda: element["mda"] ?? '',
          //   survUnitCd: element["survUnitCd"],
          //   survUnitNm: element["survUnitNm"],
          // ));

        });
      }

  // 테스트
      //List<OceanRaditionLevelEntity > DatalistResult= await getOneDataFromApi( startDate: '20230912', endDate: '20230913'.toString());
      //List<OceanRaditionLevelEntity> dataT = await OceanRaditionLevelDao().getAllRaditionLevel(OceanRaditionLevelEntity(smpNo: '0772023-1810'));



      log('jsonData: ${data["response"]["body"]["items"]["item"]["smpNo"].toString()}');

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
Future<void> saveJsonData(String jsonData) async {
  SharedPreferences prefs = await SharedPreferences.getInstance(); //
  // 값을 저장하기 위해
  prefs.setString('key', 'value');
  // 값을 가져오기 위해
  String? value = prefs.getString('key');

}
