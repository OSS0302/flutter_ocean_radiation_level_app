import 'package:flutter_ocean_radiation_level/data/source/result.dart';
import 'package:flutter_ocean_radiation_level/domain/model/ocean_radiation_level_list.dart';

abstract class  OceanRaditionLevelRepository{
  Future<Result<List<OceanRadiationLevelList>>> getOceanRaditionLevelList(
      bool fetchFromRemote,
      String qurey,
      );

}