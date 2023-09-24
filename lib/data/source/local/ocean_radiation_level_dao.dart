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
    e.itmNm.toLowerCase().contains(query.toLowerCase()) ||
        query.toUpperCase() == e.analStDt ||
        query.toUpperCase() == e.analEndDt).toList();
  }

  // 검색
  Future<List<OceanRaditionLevelEntity>> getAllRaditionLevel() async {
    final box = await Hive.openBox<OceanRaditionLevelEntity>(db);
    final List<OceanRaditionLevelEntity> OceanRadiationList =
    box.values.toList();
    print(box.keys);
    return OceanRadiationList;
  }

  // 클리어
  Future<void> deleteradition_level(OceanRaditionLevelEntity smpnoIndex) async {
    final box = await Hive.openBox<OceanRaditionLevelEntity>(db);
    int? key = box.values
        .firstWhere((element) =>
    element.smpNo == smpnoIndex.smpNo &&
        element.smpNo.toString() == smpnoIndex.smpNo.toString())
        .key;

    if (key != null) {
      box.delete(key);
    } else {
      box.delete(smpnoIndex);
    }
  }

  // 클리어
  Future<void> clearRaditionLevel() async {
    final box = await Hive.openBox<OceanRaditionLevelEntity>(db);
    box.clear();
  }
}
