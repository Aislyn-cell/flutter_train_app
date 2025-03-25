import 'package:flutter/material.dart';
import 'package:flutter_train_app/home_page.dart';
import 'package:flutter_train_app/seat_page.dart';
import 'package:flutter_train_app/station_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/stationList': (context) => StationListPage(isDeparture: true),
        '/seat':
            (context) => SeatPage(
              departureStation: 'Station A',
              arrivalStation: 'Station B',
            ),
      },
      theme: ThemeData.light(), // 라이트 테마 설정
      darkTheme: ThemeData.dark().copyWith(
        // 다크 테마 설정 및 scaffoldBackgroundColor 변경
        scaffoldBackgroundColor: Colors.grey[900], // 다크 테마 배경색 설정
      ),
      themeMode: ThemeMode.system, // 시스템 테마 모드 설정 (시스템 설정에 따라 라이트/다크 테마 자동 적용)
    );
  }
}
