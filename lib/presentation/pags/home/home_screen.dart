import 'package:flutter/material.dart';
import 'package:flutter_ocean_radiation_level/presentation/pags/home/home_screen_controller.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:animation_list/animation_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final PanelController panelController = PanelController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final homeViewModel = context.read<HomeScreenController>();
      homeViewModel.initHome().then((value) {
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    // =_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context  ) {
    final homeViewModel = context.watch<HomeScreenController>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: const Text(
          '홈화면',
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold),
        ),
        // backgroundColor: Colors.white,
      ),
      body: homeViewModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SlidingUpPanel(
              controller: homeViewModel.panelController,
              color: Theme.of(context).colorScheme.background,
              maxHeight: MediaQuery.of(context).size.height * 0.9,
              minHeight: 0,
              // minHeight: MediaQuery.of(context).size.height * 0.3,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              backdropEnabled: true,
              panel: _floatingPanel(),
              // collapsed: _floatingCollapsed(),
              body: Container(
                color: Theme.of(context).colorScheme.background,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              newestDateTile(title: '시료수거지원명: ', data: homeViewModel.dataApi[0].gathMchnNm),
                              newestDateTile(title: '채취일자 : ', data: homeViewModel.dataApi[0].gathDt),
                              newestDateTile(title: '품목명: ', data: homeViewModel.dataApi[0].itmNm),
                              newestDateTile(title: '원산지: ', data: homeViewModel.dataApi[0].ogLoc),
                              newestDateTile(title: '분석의뢰일자: ', data: homeViewModel.dataApi[0].analRqstDt),
                              newestDateTile(title: '분석시작일자: ', data: homeViewModel.dataApi[0].analStDt),
                              newestDateTile(title: '분석종료일자: ', data: homeViewModel.dataApi[0].analEndDt),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                      child: Text(
                          'data가 없는날도 있어서 한달치를 가져오도록 했습니다.',
                          style: TextStyle(
                            color: Colors.grey,
                              fontSize: 16,
                          ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: AnimationList(
                          physics: const NeverScrollableScrollPhysics(),
                            duration: 2000,
                            reBounceDepth: 30,
                            children: homeViewModel.data.map((item) {
                              return _buildTile(
                                  item['title']);
                            }).toList()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildTile(String? title,{ Color?backgroundColor = Colors.blueAccent} ) {
    final homeViewModel = context.watch<HomeScreenController>();
    return InkWell(
      onTap: () {
        print('title: $title');
        homeViewModel.openPanel(title: title ?? '');
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: backgroundColor,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              title ?? '',
              style: const TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  // color: context.isDarkMode ? Colors.red : Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _floatingPanel() {
    final homeViewModel = context.watch<HomeScreenController>();
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
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.6),
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
                      homeViewModel.panelBodyText,
                      style: TextStyle(fontSize: 16),
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

  Widget newestDateTile({required String title, required String data}){
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
              title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
              data,
            style: const TextStyle(fontSize: 16),
          ),
        )

      ],
    );
  }
}
