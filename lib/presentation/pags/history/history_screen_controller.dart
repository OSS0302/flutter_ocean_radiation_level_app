import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ocean_radiation_level/data/source/get_one_data_from_api.dart';
import 'package:flutter_ocean_radiation_level/data/source/local/ocean_radiation_level_dao.dart';
import 'package:flutter_ocean_radiation_level/data/source/local/ocean_radition_level_entity.dart';
import 'package:flutter_ocean_radiation_level/presentation/common/string_info_for_nuclear.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:intl/intl.dart';

class historyScreenController extends ChangeNotifier{
  final PanelController panelController = PanelController();
  String panelBodyText = nuclearInfo;
  final TextEditingController searchController = TextEditingController();
  final OceanRaditionLevelDao dao = OceanRaditionLevelDao();
  List<OceanRaditionLevelEntity> dataApi = [];
  List<OceanRaditionLevelEntity> dataApiFilter = [];
  OceanRaditionLevelEntity? selectedData;

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  /// TODO: 리스트 최근 첫번째 데이터 받아와서 저장후 뿌려주기
  Future<void> initHistory() async {
    await getOneDataFromApi(
        startDate: DateFormat('yyyyMMdd').format(DateTime(DateTime.now().year, DateTime.now().month - 1, DateTime.now().day)),
        endDate: DateFormat('yyyyMMdd').format(DateTime.now()))
        .then((value) {
      if (value.isNotEmpty) {
        value.sort((a, b) => b.gathDt.compareTo(a.gathDt));
        dataApi.addAll(value);
        dataApiFilter.addAll(value);
        selectedData = value[0];
      }
    });

    _isLoading = false;
    notifyListeners();
  }

  Future<void> openPanel({required OceanRaditionLevelEntity data }) async {
    selectedData = data;
    notifyListeners();

    if(panelController.isPanelClosed){
      // pannel 을 해당되는 사이즈로 오픈
      panelController.animatePanelToPosition(0.5);
      // // pannel max 로 오픈
      //panelController.open();
    }
  }

  Future<void> filteredDate(String? searchVal) async {
    if(searchVal != null && searchVal != ''){
      dataApiFilter = [];
      notifyListeners();
      dataApi.forEach((element) {
        print(element.itmNm);
        if(element.itmNm.contains(searchVal)){
          dataApiFilter.add(element);
          notifyListeners();
        }
      });
    } else {
      dataApiFilter = [];
      dataApiFilter.addAll(dataApi);
      notifyListeners();
    }
  }
}
