import 'package:flutter_ocean_radiation_level/data/keys.dart';
import 'package:flutter_ocean_radiation_level/data/source/local/ocean_radition_level_entity.dart';
import 'package:flutter_ocean_radiation_level/domain/model/ocean_radiation_level_list.dart';
import 'package:hive/hive.dart';

class OceanRaditionLevelDao {
  // 데이터 추가
  Future<void> insertraditionLevel(
      OceanRaditionLevelEntity ocaditionListingEntities) async {
    final box = await Hive.openBox<OceanRaditionLevelEntity>(db);
    await box.add(ocaditionListingEntities);
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
  Future<List<OceanRaditionLevelEntity>> getAllRaditionLevel() async {
    final box = await Hive.openBox<OceanRaditionLevelEntity>(db);
    final List<OceanRaditionLevelEntity> OceanRadiationList = box.values.toList();
     print(box.keys);
    return OceanRadiationList;
  }


// 삭제
  Future<void> deleteData(OceanRaditionLevelEntity oceanRaditionLevelIndex) async {
    final box = await Hive.openBox<OceanRaditionLevelEntity>(db);
    int? key = box.values
        .singleWhere((element) =>
    element.smpNo == oceanRaditionLevelIndex.smpNo &&
        element.smpNo.toString() == oceanRaditionLevelIndex.smpNo.toString())
        .key;

    if (key != null) {
      box.delete(key);
    } else {
      box.delete(oceanRaditionLevelIndex);
    }
  }

  // 클리어
  Future<void> clearRaditionLevel() async {
    clearRaditionLevel();
    final box = await Hive.openBox<OceanRaditionLevelEntity>(db);
    box.clear();
  }
}




