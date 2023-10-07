import 'package:flutter/material.dart';
import 'package:flutter_ocean_radiation_level/data/source/local/ocean_radiation_level_dao.dart';
import 'package:flutter_ocean_radiation_level/data/source/local/ocean_radition_level_entity.dart';
import 'package:flutter_ocean_radiation_level/data/source/ocean_radiation_level_api.dart';
import 'package:flutter_ocean_radiation_level/domain/model/ocean_radiation_level_list.dart';
import 'package:flutter_ocean_radiation_level/domain/model/ocean_radiation_level_list.dart';
import 'package:flutter_ocean_radiation_level/presentation/pags/home/home_screen_controller.dart';
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
      homeViewModel.initHome();
    });
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeScreenController>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: const Text(
          '홈화면',
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
      body: homeViewModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SlidingUpPanel(
              controller: homeViewModel.panelController,
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
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: AnimationList(
                          duration: 2000,
                          reBounceDepth: 30,
                          children: homeViewModel.data.map((item) {
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
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }

  Widget _floatingPanel() {
    final homeViewModel = context.watch<HomeScreenController>();
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
              homeViewModel.panelBodyText,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
