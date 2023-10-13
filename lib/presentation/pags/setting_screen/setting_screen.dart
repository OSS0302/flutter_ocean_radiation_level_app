import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:flutter_ocean_radiation_level/main.dart';
import 'package:flutter_ocean_radiation_level/presentation/pags/setting_screen/setting_screen_controller.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isLightMode = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SettingViewModel = context.watch<SettingScreenController>();
    return Scaffold(
      appBar: AppBar(
      elevation: 0,
      centerTitle: false,
      title: const Text(
        '히스토리화면 ',
        style: TextStyle(
            fontSize: 40, fontWeight: FontWeight.bold ),
      ),
    ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text("테마 변경",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            ),
            Switch(
              value: _isLightMode,
              onChanged: (val) {
                setState(() {
                  _isLightMode = val;
                });
                MyApp.themeNotifier.value =
                    MyApp.themeNotifier.value == ThemeMode.light
                        ? ThemeMode.dark
                        : ThemeMode.light;
              },
            ),
                const Text(
                  'Dark Mode',
                  style: TextStyle(fontSize: 20),
                ),
                Switch(
                  value: controller.value,
                  onChanged: (bool value) {
                    controller.setMode(value);
                  },
                ),

          ],
        ),
      ),
    );
  }
}
