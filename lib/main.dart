import 'package:flutter/material.dart';
import 'package:flutter_ocean_radiation_level/data/source/local/ocean_radiation_level_dao.dart';
import 'package:flutter_ocean_radiation_level/data/source/local/ocean_radition_level_entity.dart';
import 'package:flutter_ocean_radiation_level/firebase_options.dart';
import 'package:flutter_ocean_radiation_level/presentation/common/color_schemes.g.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_ocean_radiation_level/presentation/bottom_navigation_bar.dart';
import 'package:flutter_ocean_radiation_level/presentation/pags/history/history_screen_controller.dart';
import 'package:flutter_ocean_radiation_level/presentation/pags/home/home_screen_controller.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(OceanRaditionLevelEntityAdapter());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
      );

  // runApp(const MyApp());
  runApp( MultiProvider(
    providers:[
      ChangeNotifierProvider (create: (_) => HomeScreenController()),
      ChangeNotifierProvider (create: (_) => historyScreenController()),
    ],
    child: const MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'e',
      theme: ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: darkColorScheme,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const BottomNaigationBar(),
      // home: MultiProvider(
      //   providers: [
      //     Provider<HomeScreenController>(create: (_) => HomeScreenController()),
      //   ],
      //   child: const MyHomePage(),
      // ),

    );

  }
}

