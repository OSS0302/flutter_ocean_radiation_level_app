

import 'package:flutter_ocean_radiation_level/data/source/local/ocean_radition_level_entity.dart';
import 'package:flutter_ocean_radiation_level/domain/model/ocean_radiation_level_list.dart';

extension ToOceanRadiationList on OceanRaditionLevelEntity {
  OceanRadiationLevelList toOceanRadiationList() {
    return OceanRadiationLevelList(
      smpNo: smpNo, //1.시료번호
      gathMchnCd: gathMchnCd, //2.시료수거지원코드
      gathMchnNm: gathMchnNm, //3.시료수거지원명
      itmCd: itmCd, //4.품목코드
      itmNm: itmNm, //5.품목명
      survLocCd:survLocCd, //6.조사점 코드
      survLocNm: survLocNm,//7.조사명 코드명
      gathDt: gathDt, // 8.채취일자
      ogLoc:ogLoc, // 9.원산지
      analRqstDt:analRqstDt, //10.분석의뢰일자
      analStDt: analStDt, //11. 분석시작일자
      analEndDt:analEndDt, //12.분석종료일자
      survCiseCd:survCiseCd, //13.조사항목코드
      survCiseNm: survCiseNm, //14.조사항목명
      dtldSurvCiseNm: dtldSurvCiseNm,//15.조사항목명 상세
      inspKdCd : inspKdCd, //16.검사종류코드
      inspKdNm: inspKdNm, //17.검사종류명
      numAnalRsltVal :numAnalRsltVal, //18.숫자분석결과값
      charAnalRsltVal : charAnalRsltVal, //19.문자분석결과값
      charPsngVal :charPsngVal, //20.문자합격값
      charUnPsngVal :charUnPsngVal, //21.문자불합격값
      numPsngMinVal : numPsngMinVal, //22.숫자합격최소값
      numPsngMaxVal : numPsngMaxVal, //23.숫자합격최대값
      itmFtnsYn : itmFtnsYn, //24.품목적합여부
      ciseFtnsYn : ciseFtnsYn, //25.항목적합여부
      analMchnCd : analMchnCd, //26.분석지원코드
      analMchnNm : analMchnNm, //27.분석지원명
      analDevia : analDevia, //28.분석결과편차
      mda :mda, //29.MDA
      survUnitCd :survUnitCd, //30.조사단위코드
      survUnitNm :survUnitNm, //31.조사단위코드명

    );
  }
}

extension ToOceanRaditionLevelEntity on OceanRadiationLevelList {
  OceanRaditionLevelEntity toOceanRaditionLevelEntity() {
    return OceanRaditionLevelEntity(
      //1.시료번호
      smpNo: smpNo,
      //2.시료수거지원코드
      gathMchnCd: gathMchnCd,
      //3.시료수거지원명
      gathMchnNm: gathMchnNm,
      //4.품목코드
      itmCd: itmCd,
      //5.품목명
      itmNm: itmNm,
      //6.조사점 코드
      survLocCd:survLocCd,
      //7.조사명 코드명
      survLocNm: survLocNm,
      // 8.채취일자
      gathDt: gathDt,
      //9. 원산지
      ogLoc:ogLoc,
      //10.분석의뢰일자
      analRqstDt:analRqstDt,
      //11.분석시작일자
      analStDt: analStDt,
      //12.분석종료일자
      analEndDt:analEndDt,
      //13.조사항목코드
      survCiseCd:survCiseCd,
      //14.조사항목명
      survCiseNm: survCiseNm,
      //15.조사항목명 상세
      dtldSurvCiseNm: dtldSurvCiseNm,
      //16.검사종류코드
      inspKdCd : inspKdCd,
      //17.검사종류명
      inspKdNm: inspKdNm,
      //18.숫자분석결과값
      numAnalRsltVal :numAnalRsltVal,
      //19.문자분석결과값
      charAnalRsltVal : charAnalRsltVal,
      //20.문자합격값
      charPsngVal :charPsngVal,
      //21.문자불합격값
      charUnPsngVal :charUnPsngVal,
      //22.숫자합격최소값
      numPsngMinVal : numPsngMinVal,
      //23.숫자합격최대값
      numPsngMaxVal : numPsngMaxVal,
      //24.품목적합여부
      itmFtnsYn : itmFtnsYn,
      //25.항목적합여부
      ciseFtnsYn : ciseFtnsYn,
      //26.분석지원코드
      analMchnCd : analMchnCd,
      //27.분석지원명
      analMchnNm : analMchnNm,
      //28.분석결과편차
      analDevia : analDevia,
      //29.MDA
      mda :mda,
      //30.조사단위코드
      survUnitCd :survUnitCd,
      //31.조사단위코드명
      survUnitNm :survUnitNm,
    );
  }
}