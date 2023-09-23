
import 'package:flutter_ocean_radiation_level/data/source/result.dart';
import 'package:flutter_ocean_radiation_level/domain/model/ocean_radiation_list.dart';

abstract class OceanRaditionLevelRepository{
  Future<Result<List<OceanRadiationList>>> getAllRaditionLevelList();

  Future<Result<List<OceanRadiationList>>> getRaditonLevelList(
      String query,
      );
}