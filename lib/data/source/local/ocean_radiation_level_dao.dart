// import 'package:flutter_ocean_radiation_level/data/keys.dart';
// import 'package:flutter_ocean_radiation_level/data/source/local/ocean_radition_level_entity.dart';
// import 'package:hive/hive.dart';
//
// class OceanRaditionLevelDao {
//   // 데이터 추가
//   Future<void> insertraditionLevel(
//       OceanRaditionLevelEntity caditionListingEntities) async {
//     final box = await Hive.openBox<OceanRaditionLevelEntity>(db);
//     await box.add(caditionListingEntities);
//   }
//
//   // 검색
//   Future<List<OceanRaditionLevelEntity>> searchRaditionLevel(
//      String query) async {
//     final box = await Hive.openBox<OceanRaditionLevelEntity>(db);
//     final List<OceanRaditionLevelEntity> OceanRadiationList =
//     box.values.toList();
//
//     return OceanRadiationList.where((e) =>
//     e.itmNm.toLowerCase().contains(query.toLowerCase()) ||
//         query.toUpperCase() == e.analStDt ||
//         query.toUpperCase() == e.analEndDt).toList();
//   }
//
//   // 검색
//   Future<List<OceanRaditionLevelEntity>> getAllRaditionLevel(OceanRaditionLevelEntity oceanRaditionLevelEntity) async {
//     final box = await Hive.openBox<OceanRaditionLevelEntity>(db);
//     final List<OceanRaditionLevelEntity> OceanRadiationList = box.values.toList();
//     // print(box.keys);
//     return OceanRadiationList;
//   }
//
//   // 클리어
//   Future<void> deleteradition_level(OceanRaditionLevelEntity smpnoIndex) async {
//     final box = await Hive.openBox<OceanRaditionLevelEntity>(db);
//     int? key = box.values
//         .firstWhere((element) =>
//     element.smpNo == smpnoIndex.smpNo &&
//         element.smpNo.toString() == smpnoIndex.smpNo.toString())
//         .key;
//
//     if (key != null) {
//       box.delete(key);
//     } else {
//       box.delete(smpnoIndex);
//     }
//   }
//
//   // 클리어
//   Future<void> clearRaditionLevel() async {
//     clearRaditionLevel();
//     final box = await Hive.openBox<OceanRaditionLevelEntity>(db);
//     box.clear();
//   }
// }


import 'package:flutter_ocean_radiation_level/data/source/local/ocean_radition_level_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OceanRaditionLevelDao {
  final box = Hive.box('db');

  // 추가 캐쉬를 위해서사용한다.
  Future<void> insertOceanRaditionLevel(
      List<OceanRaditionLevelEntity> OceanRaditionLevelListEntity ())async{
        await box.put('OceanRaditionLevelList',OceanRaditionLevelListEntity);
  }

  // 클리어 캐쉬
  Future<void> clearOceanRaditionLevel() async{
        await box.clear();
  }
    // 검색
  Future<List<OceanRaditionLevelEntity>?> searchOceanRaditionLevel(String query) async{
      final List<OceanRaditionLevelEntity> OceanRaditionLevelList = box.get('OceanRaditionLevelList', defaultValue: []);
      return OceanRaditionLevelList.where((e) =>
        e.gathMchnCd.contains(query) ||query == e.gathMchnCd ||  // 시료수거지원명 지역
        e.itmNm.contains(query) || query == e.itmNm ).toList(); // 품목명
  }
}
