import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ocean_radiation_list.freezed.dart';

part 'ocean_radiation_list.g.dart';

@freezed
class OceanRadiationList with _$OceanRadiationList {
  factory OceanRadiationList({
    //1.시료번호
    required String smpNo,
    //2.시료수거지원코드
    required  String gathMchnCd,
    //3.시료수거지원명
    required String gathMchnNm,
    //4.품목코드
    required String itmCd,
    //5.품목명
    required String itmNm,
    //6.조사점코드
    required String survLocCd,
    //7.조사점코드명
    required String survLocNm,
    //8.채취일자
    required String gathDt,
    //9.채취일자
    required String ogLoc,
    //10. 분석의뢰일자
    required String analRqstDt,
    //11.분석의뢰일자
    required String analStDt,

    required String analEndDt, //12.분석종료일자

    required String survCiseCd, //13.조사항목코드

    required String survCiseNm, //14.조사항목명

    required String dtldSurvCiseNm, //15.조사항목명 상세

    required String inspKdCd, //16.검사종류코드

    required String inspKdNm, //17.검사종류명

    required String numAnalRsltVal, //18.숫자분석결과값

    required String charAnalRsltVal, //19.문자분석결과값

    required String charPsngVal, //20.문자합격값

    required String charUnPsngVal, //21.문자불합격값

    required String numPsngMinVal, //22.숫자합격최소값

    required String numPsngMaxVal, //23.숫자합격최대값

    required String itmFtnsYn, //24.품목적합여부

    required String ciseFtnsYn, //25.항목적합여부

    required String analMchnCd, //26.분석지원코드

    required String analMchnNm, //27.분석지원명

    required String analDevia, //28.분석결과편차

    required String mda, //29.MDA
    //30.조사단위코드ㅑ
    required String survUnitCd,
    //31.조사단위코드명
    required String survUnitNm,
  }) = _OceanRadiationList;
  
  factory OceanRadiationList.fromJson(Map<String, dynamic> json) =>
      _$OceanRadiationListFromJson(json);
}

