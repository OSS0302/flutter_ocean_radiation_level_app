import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ocean_radiation_level_list.freezed.dart';

part 'ocean_radiation_level_list.g.dart';

@freezed
class OceanRadiationLevelList with _$OceanRadiationLevelList {
  factory OceanRadiationLevelList({
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
    //12.분석종료일자
    required String analEndDt,
    //13.조사항목코드
    required String survCiseCd,
    //14.조사항목명
    required String survCiseNm,
    //15.조사항목명 상세
    required String dtldSurvCiseNm,
    //16.검사종류코드
    required String inspKdCd,
    //17.검사종류명
    required String inspKdNm,
    //18.숫자분석결과값
    required String numAnalRsltVal,
    //19.문자분석결과값
    required String charAnalRsltVal,
    //20.문자합격값
    required String charPsngVal,
    //21.문자불합격값
    required String charUnPsngVal,
    //22.숫자합격최소값
    required String numPsngMinVal,
    //23.숫자합격최대값
    required String numPsngMaxVal,
    //24.품목적합여부
    required String itmFtnsYn,
    //25.항목적합여부
    required String ciseFtnsYn,
    //26.분석지원코드
    required String analMchnCd,
    //27.분석지원명
    required String analMchnNm,
    //28.분석결과편차
    required String analDevia,
    //29.MDA
    required String mda,
    //30.조사단위코드
    required String survUnitCd,
    //31.조사단위코드명
    required String survUnitNm,
  }) = _OceanRadiationLevelList;
  
  factory OceanRadiationLevelList.fromJson(Map<String, dynamic> json) =>
      _$OceanRadiationLevelListFromJson(json);
}

