import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ocean_radiation_level/data/source/local/ocean_radition_level_entity.dart';
import 'package:flutter_ocean_radiation_level/presentation/pags/history/history_screen_controller.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:animation_list/animation_list.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);


  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final _focusNode = FocusScopeNode();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this, //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );
    Future.microtask(() {
      final historyViewModel = context.read<historyScreenController>();
      historyViewModel.initHistory().then((value) {
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final historyViewModel = context.watch<historyScreenController>();
    return FocusScope(
      node: _focusNode,
      child: Scaffold(
        // resizeToAvoidBottomInset : false,
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          title: const Text(
            '히스토리화면 ',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(child: Text('메인')),
              Tab(child: Text('즐겨찾기')),
            ],
          ),
        ),
        body: historyViewModel.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SlidingUpPanel(
                color: Theme.of(context).colorScheme.background,
                controller: historyViewModel.panelController,
                maxHeight: MediaQuery.of(context).size.height * 0.9,
                minHeight: 0,
                // minHeight: MediaQuery.of(context).size.height * 0.3,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                backdropEnabled: true,
                panel: _floatingPanel(),
                // collapsed: _floatingCollapsed(),
                body: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                              enableInteractiveSelection: false,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-z|A-Z|0-9|ㄱ-ㅎ|ㅏ-ㅣ|가-힣|]'))
                            ],
                            controller: historyViewModel.searchController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    10.0)), // 검색창 모서리 각도 10 둥글게 한다.
                              ),
                              suffixIcon: IconButton(
                                onPressed: () async {},
                                icon: const Icon(Icons.search),
                              ),
                            ),
                            onChanged: (String? value) {
                              print('onChanged value: 는 $value');
                              setState(() {
                                historyViewModel.filteredDate(value);
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: historyViewModel.dataApiFilter.isNotEmpty
                                ? AnimationList(
                                    duration: 2000,
                                    reBounceDepth: 30,
                                    children: historyViewModel.dataApiFilter
                                        .map((item) {
                                      return _buildTile(
                                          data: item, title: item.itmNm);
                                    }).toList())
                                : Container(),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    )
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildTile(
      {required OceanRaditionLevelEntity data,
      required String title,
      Color? backgroundColor = Colors.orange}) {
    final historyViewModel = context.watch<historyScreenController>();
    return InkWell(
      onTap: () {
        //print('title: $title');
        historyViewModel.openPanel(data: data);
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: backgroundColor,
        ),
        child: Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  title ?? '',
                  style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Text('채취일자: ${data.gathDt}'),
            IconButton(
              alignment: Alignment.topRight,
              onPressed: () {
              },
              icon: Icon(Icons.star_border_outlined),
            ),
          ],
        ),
      ),
    );
  }

  Widget _floatingPanel() {
    final historyViewModel = context.watch<historyScreenController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
              height: 10,
              width: 100,
              decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                borderRadius: BorderRadius.circular(50),
              )),
        ),
        Flexible(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    // historyViewModel.dataApi.toString(),
                    historyViewModel.selectedData != null
                        ? '시료번호 :${historyViewModel.selectedData!.smpNo} \n'
                            '시료수거지원코드 :${historyViewModel.selectedData!.gathMchnCd} \n'
                            '시료수거지원명 :${historyViewModel.selectedData!.gathMchnNm} \n'
                            '품목코드 :${historyViewModel.selectedData!.itmCd} \n'
                            '품목명 :${historyViewModel.selectedData!.itmNm} \n'
                            '조사점코드 :${historyViewModel.selectedData!.survLocCd} \n'
                            '조사점코드명 :${historyViewModel.selectedData!.survLocNm} \n'
                            '채취일자 :${historyViewModel.selectedData!.gathDt} \n'
                            '원산지 :${historyViewModel.selectedData!.ogLoc} \n'
                            '분석의뢰일자 :${historyViewModel.selectedData!.analRqstDt} \n'
                            '분석시작일자 :${historyViewModel.selectedData!.analStDt} \n'
                            '분석종료일자 :${historyViewModel.selectedData!.analEndDt} \n'
                            '조사항목코드 :${historyViewModel.selectedData!.survCiseCd} \n'
                            '조사항목명 :${historyViewModel.selectedData!.survCiseNm} \n'
                            '조사항목명 상세 :${historyViewModel.selectedData!.dtldSurvCiseNm} \n'
                            '검사종류코드: ${historyViewModel.selectedData!.inspKdCd} \n'
                            '검사종류명: ${historyViewModel.selectedData!.inspKdNm}\n'
                            '숫자분석결과값: ${historyViewModel.selectedData!.numAnalRsltVal}\n'
                            '문자분석결과값: ${historyViewModel.selectedData!.charAnalRsltVal}\n'
                            '문자합격값: ${historyViewModel.selectedData!.charPsngVal}\n'
                            '문자불합격값: ${historyViewModel.selectedData!.charUnPsngVal}\n'
                            '숫자합격최소값: ${historyViewModel.selectedData!.numPsngMinVal}\n'
                            '숫자합격최대값: ${historyViewModel.selectedData!.numPsngMaxVal}\n'
                            '품목적합여부: ${historyViewModel.selectedData!.itmFtnsYn}\n'
                            '항목적합여부: ${historyViewModel.selectedData!.ciseFtnsYn}\n'
                            '분석지원코드: ${historyViewModel.selectedData!.analMchnCd}\n'
                            '분석지원명: ${historyViewModel.selectedData!.analMchnNm}\n'
                            '분석결과편차: ${historyViewModel.selectedData!.analDevia}\n'
                            'MDA: ${historyViewModel.selectedData!.mda}\n'
                            '조사단위코드: ${historyViewModel.selectedData!.survUnitCd}\n'
                            '조사단위코드명: ${historyViewModel.selectedData!.survUnitNm}\n'
                        : '없음',
                  ),
                  SizedBox(
                    height: 200,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
