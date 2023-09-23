import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class OceanRaditionLevelEntity extends HiveObject {
  @HiveField(0)
  String  smpNo; // 시료번호
  @HiveField(1)
  String gathMchnCd; // 시료수거지원코드
  @HiveField(2)
  String gathMchnNm; // 시료수거지원명
  @HiveField(3)
  String itmCd; // 품목코드
  @HiveField(4)
  String itmNm; // 품목명
  @HiveField(5)
  String survLocCd ; // 조사점 코드
  @HiveField(6)
  String survLocNm ; // 조사점 코드명
  @HiveField(7)
  String gathDt; // 채취 날짜
  @HiveField(8)
  String ogLoc; // 원산지
  @HiveField(9)
  String analRqstDt; //분석의뢰일자
  @HiveField(10)
  String analStDt; //분석시작일자
  @HiveField(11)
  String analEndDt; // 분석종료일자
  @HiveField(12)
  String survCiseCd ; // 조사항목코드
  @HiveField(13)
  String survCiseNm ; // 조사항목명
  @HiveField(14)
  String dtldSurvCiseNm; // 조사항목명 상세
  @HiveField(15)
  String inspKdCd; //검사종류코드
  @HiveField(16)
  String inspKdNm; // 검사종류명
  @HiveField(17)
  String numAnalRsltVal; // 숫자분석결과값
  @HiveField(18)
  String charAnalRsltVal; // 문자분석결과값
  @HiveField(19)
  String charPsngVal ; // 문자합격값
  @HiveField(20)
  String charUnPsngVal ; // 문자불합격값
  @HiveField(21)
  String numPsngMinVal; // 숫자합격최소값
  @HiveField(22)
  String numPsngMaxVal; // 숫자합격최대값
  @HiveField(23)
  String itmFtnsYn; //품목적합여부
  @HiveField(24)
  String ciseFtnsYn; //항목적합여부
  @HiveField(25)
  String analMchnCd; // 분석지원코드
  @HiveField(26)
  String analMchnNm ; // 분석지원명
  @HiveField(27)
  String analDevia ; // 분석결과편차
  @HiveField(28)
  String mda; //MDA
  @HiveField(29)
  String survUnitCd; //조사단위코드
  @HiveField(30)
  String survUnitNm; // 조사단위코드명



  OceanRaditionLevelEntity({
    //1. 시료번호
     required this.smpNo,
    //2. 시료수거지원코드
    required this.gathMchnCd,
    //3.시료수거지원명
    required this.gathMchnNm,
    //4. 품목코드
    required this.itmCd,
    //5. 품목명
    required this.itmNm,
    //6.조사점코드
    required this.survLocCd,
    //7. 조사점코드명
    required this.survLocNm,
    //8.채취일자
    required this.gathDt,
    // 9. 원산지
    required this.ogLoc,
    // 10. 원산지
    required this.analRqstDt,
    // 11.분석시작일자
    required this.analStDt,
    // 12. 분석종료일자
    required this.analEndDt,
    //13.조사항목코드
    required this.survCiseCd,
    //14.조사항목명
    required this.survCiseNm,
    //15. 조사항목명 상세
    required this.dtldSurvCiseNm,
    //16. 검사종류코드
    required this.inspKdCd,
    //17.검사종류명
    required this.inspKdNm,
    //18.숫자분석결과값
    required this.numAnalRsltVal,
    //19.문자분석결과값
    required this.charAnalRsltVal,
    //20.문자합격값
    required this.charPsngVal,
    //21.문자불합격값
    required this.charUnPsngVal,
    //22.숫자합격최소값
    required this.numPsngMinVal,
    //23.숫자합격최대값
    required this.numPsngMaxVal,
    //24.품목적합여부
    required this.itmFtnsYn,
    //25.항목적합여부
    required this.ciseFtnsYn,
    //26.분석지원코드
    required this.analMchnCd,
    //27.분석지원명
    required this.analMchnNm,
    //28.분석결과편차
    required this.analDevia,
    //29.MDA
    required this.mda,
    //30.조사단위코드
    required this.survUnitCd,
    //31.조사단위코드명
    required this.survUnitNm,
  });
}
