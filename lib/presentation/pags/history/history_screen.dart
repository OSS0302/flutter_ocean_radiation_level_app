import 'package:flutter/material.dart';

import 'package:flutter_ocean_radiation_level/presentation/pags/history/history_screen_controller.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:animation_list/animation_list.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // final PanelController panelController = PanelController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final historyViewModel = context.read<historyScreenController>();
      historyViewModel.initHistory();
    });
  }


  @override
  void dispose() {
    //AnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final historyViewModel = context.watch<historyScreenController>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: const Text(
          '히스토리화면 ',
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(),
            onPressed: () {

            },
            child: const Text('새로고침'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(),
            onPressed: () {

            },
            child: const Text('클리어'),
          ),
        ],
      ),
      body: historyViewModel.isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : SlidingUpPanel(
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0)), // 검색창 모서리 각도 10 둥글게 한다.
                  ),
                  suffixIcon: IconButton(
                    onPressed: () async {
                      // fecth 로직이 Future이기 떄문에 async 사용한다.
                    },
                    icon: const Icon(Icons.search),
                  ),
                ),
              ),
            ),

            Expanded(
              child: Center(
                child: AnimationList(
                    duration: 2000,
                    reBounceDepth: 30,
                    children: historyViewModel.data.map((item) {
                      return _buildTile(
                          item['title'], item['backgroundColor']);
                    }).toList()),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildTile(String? title, Color? backgroundColor) {
    final historyViewModel = context.watch<historyScreenController>();
    return InkWell(
      onTap: () {
        print('title: $title');
        historyViewModel.openPanel(title: title ?? '');
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
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }

  Widget _floatingPanel() {
    final historyViewModel = context.watch<historyScreenController>();
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
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
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              historyViewModel.panelBodyText,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}