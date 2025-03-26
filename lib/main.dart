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
      debugShowCheckedModeBanner: false,
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
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black, // 앱바 배경색을 검정색으로 변경
          foregroundColor: Colors.white, // 하얀색 아이콘과 텍스트
          elevation: 0, // 그림자 제거
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        dialogTheme: DialogTheme(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        colorScheme: ColorScheme.dark(
          primary: Colors.purple,
          secondary: Colors.purpleAccent,
          surface: Colors.black,
          onPrimary: Colors.white,
          onSurface: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.purple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      themeMode: ThemeMode.dark, // 다크 모드로 설정
    );
  }
}
