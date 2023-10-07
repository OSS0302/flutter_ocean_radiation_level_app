import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ocean_radiation_level/data/source/local/ocean_radiation_level_dao.dart';
import 'package:flutter_ocean_radiation_level/data/source/local/ocean_radition_level_entity.dart';

import 'package:flutter_ocean_radiation_level/presentation/common/string_info_for_nuclear.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScreenController extends ChangeNotifier{
  final PanelController panelController = PanelController();
  String panelBodyText = nuclearInfo;
  final OceanRaditionLevelDao dao = OceanRaditionLevelDao();
  




  bool _isLoading = true;

  bool get isLoading => _isLoading;

  final List<Map<String, dynamic>> data = [
    {
      'title': nuclearInfoTitle,
      'backgroundColor': Colors.grey,
    },
    {
      'title': nuclearAffectTitle,
      'backgroundColor': Colors.red,
    },
    {
      'title': nuclearChartTitle,
      'backgroundColor': Colors.yellow,
    },
  ];

  /// TODO: 리스트 최근 첫번째 데이터 받아와서 저장후 뿌려주기
  Future<void> initHome() async {

    dao.searchRaditionLevel('오징어');
    _isLoading = false;

    notifyListeners();
  }

  Future<void> openPanel({required String title}) async {
    if(title.contains('영향')){
      panelBodyText = nuclearAffectT;
      notifyListeners();
    } else if(title.contains('수치')){
      panelBodyText = nuclearChart;
      notifyListeners();
    } else {
      panelBodyText = nuclearInfo;
      notifyListeners();
    }
    if(panelController.isPanelClosed){
      // pannel 을 해당되는 사이즈로 오픈
      panelController.animatePanelToPosition(0.5);
      // // pannel max 로 오픈
      // panelController.open();
    }
  }

}