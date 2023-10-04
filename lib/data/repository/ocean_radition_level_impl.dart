import 'package:flutter_ocean_radiation_level/data/mapper/ocean_radition_level_mapper.dart';
import 'package:flutter_ocean_radiation_level/data/source/local/ocean_radiation_level_dao.dart';
import 'package:flutter_ocean_radiation_level/data/source/ocean_radiation_level_api.dart';
import 'package:flutter_ocean_radiation_level/data/source/result.dart';
import 'package:flutter_ocean_radiation_level/domain/model/ocean_radiation_level_list.dart';
import 'package:flutter_ocean_radiation_level/domain/repository/ocean_radition_level_repository.dart';

class OceanRaditionLevelImpl extends OceanRaditionLevelRepository {
  final OceanRaditionLevelDao _dao;
  final OceanRaditionLevelApi _api;

  OceanRaditionLevelImpl(this._dao, this._api);

  @override
  Future<Result<List<OceanRadiationLevelList>>> getOceanRaditionLevelList(
      bool fetchFromRemote, String query) async {
    // 캐시에서 찾기
    final localOceanRaditionLevelListings =
        await _dao.searchOceanRaditionLevel(query);
    // 데이터가  없다면
    final isDbEmpty = localOceanRaditionLevelListings!.isEmpty && query.isEmpty;
    // 캐쉬로 부터 로드 를 해야한다.
    final shouldJustLoadFromCache = !isDbEmpty && !fetchFromRemote;
    // 캐쉬에서 가져온 경우
    if (shouldJustLoadFromCache) {
      return Result.success(localOceanRaditionLevelListings
          .map((e) => e.toOceanRadiationList( ))
          .toList());
    }
    // 리모트
    try{
      final response = await _api.saveJsonDatagetOceanRaditionLevelListings( startDate: '20230912', endDate: '20230913');



      // 캐시 비우기
      await _dao.clearOceanRaditionLevel();
      // TODO: 캐시 추가하기


      return Result.success([]);   // TODO: 데이터를 넣을 수없다 .모르겠다. 몰 넣어야할지 그래서 일단 빈리스트

    }catch (e){
        return Result.error(Exception('데이터 로드 실패'));

    }

  }
}
