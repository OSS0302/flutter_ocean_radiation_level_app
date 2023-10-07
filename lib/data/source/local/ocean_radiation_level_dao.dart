import 'package:flutter_ocean_radiation_level/data/keys.dart';
import 'package:flutter_ocean_radiation_level/data/source/local/ocean_radition_level_entity.dart';
import 'package:hive/hive.dart';

class OceanRaditionLevelDao {
  // 데이터 추가
  Future<void> insertraditionLevel(
      OceanRaditionLevelEntity caditionListingEntities) async {
    final box = await Hive.openBox<OceanRaditionLevelEntity>(db);
    await box.add(caditionListingEntities);
  }

  // 검색
  Future<List<OceanRaditionLevelEntity>> searchRaditionLevel(
     String query) async {
    final box = await Hive.openBox<OceanRaditionLevelEntity>(db);
    final List<OceanRaditionLevelEntity> OceanRadiationList =
    box.values.toList();

    return OceanRadiationList.where((e) =>
    e.gathMchnCd.contains(query) ||query == e.gathMchnCd ||  // 시료수거지원명 지역
       e.itmNm.contains(query) || query == e.itmNm ).toList(); // 품목명
  }

  // 검색
  Future<List<OceanRaditionLevelEntity>> getAllRaditionLevel(OceanRaditionLevelEntity oceanRaditionLevelEntity) async {
    final box = await Hive.openBox<OceanRaditionLevelEntity>(db);
    final List<OceanRaditionLevelEntity> OceanRadiationList = box.values.toList();
    // print(box.keys);
    return OceanRadiationList;
  }



  // 클리어
  Future<void> clearRaditionLevel() async {
    clearRaditionLevel();
    final box = await Hive.openBox<OceanRaditionLevelEntity>(db);
    box.clear();
  }
}


// import 'package:flutter_ocean_radiation_level/data/source/local/ocean_radition_level_entity.dart';
// import 'package:hive_flutter/hive_flutter.dart';
//
// class OceanRaditionLevelDao {
//   final openbox = Hive.box('db');
//
//   // 추가 캐쉬를 위해서사용한다.
//   Future<void> insertOceanRaditionLevel(
//       List<OceanRaditionLevelEntity> OceanRaditionLevelListEntity)async{
//         await openbox.put('OceanRaditionLevelList',OceanRaditionLevelListEntity);
//   }
//
//   // 클리어 캐쉬
//   Future<void> clearOceanRaditionLevel() async{
//         await openbox.clear();
//   }
//     // 검색
//   Future<List<OceanRaditionLevelEntity>> searchOceanRaditionLevel(String query) async{
//       final List<OceanRaditionLevelEntity> OceanRaditionLevelList = openbox.get('OceanRaditionLevelList', defaultValue: []);
//       return OceanRaditionLevelList.where((e) =>
//         e.gathMchnCd.contains(query) ||query == e.gathMchnCd ||  // 시료수거지원명 지역
//         e.itmNm.contains(query) || query == e.itmNm ).toList(); // 품목명
//   }

