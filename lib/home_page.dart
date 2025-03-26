import 'package:flutter/material.dart';
import 'package:flutter_train_app/station_list_page.dart';
import 'package:flutter_train_app/seat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String? departureStation;
  String? arrivalStation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // 검정색 배경
      appBar: AppBar(
        title: Center(
          child: Text(
            '기차 예매',
            style: TextStyle(color: Colors.white), // 하얀색 텍스트
          ),
        ),
        backgroundColor: Colors.transparent, // 투명한 앱바 배경
        elevation: 0, // 그림자 제거
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[900], // 회색 배경 색상
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStationSelection(context, '출발역', departureStation, (
                    station,
                  ) {
                    setState(() {
                      departureStation = station;
                    });
                  }, true),
                  SizedBox(
                    height: 50,
                    child: VerticalDivider(
                      width: 2,
                      thickness: 2,
                      color: Colors.grey[700], // 회색 선
                    ),
                  ),
                  _buildStationSelection(context, '도착역', arrivalStation, (
                    station,
                  ) {
                    setState(() {
                      arrivalStation = station;
                    });
                  }, false),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (departureStation != null && arrivalStation != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => SeatPage(
                              departureStation: departureStation!,
                              arrivalStation: arrivalStation!,
                            ),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            backgroundColor: Colors.grey[900], // 회색 다이어로그
                            title: Text(
                              '오류',
                              style: TextStyle(color: Colors.white),
                            ),
                            content: Text(
                              '출발역과 도착역을 모두 선택해주세요.',
                              style: TextStyle(color: Colors.white),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  '확인',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    '좌석 선택',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStationSelection(
    BuildContext context,
    String title,
    String? selectedStation,
    Function(String?) onStationSelected,
    bool isDeparture,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => StationListPage(
                      isDeparture: isDeparture,
                      selectedStation:
                          isDeparture ? arrivalStation : departureStation,
                    ),
              ),
            );
            if (result != null && result is String) {
              onStationSelected(result);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              selectedStation ?? '선택',
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
