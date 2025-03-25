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
      appBar: AppBar(title: Center(child: Text('기차 예매'))),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
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
                  }, true), // isDeparture: true (출발역)
                  SizedBox(
                    height: 50,
                    child: VerticalDivider(
                      width: 2,
                      thickness: 2,
                      color: Colors.grey[400],
                    ),
                  ),
                  _buildStationSelection(context, '도착역', arrivalStation, (
                    station,
                  ) {
                    setState(() {
                      arrivalStation = station;
                    });
                  }, false), // isDeparture: false (도착역)
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
                            title: Text('오류'),
                            content: Text('출발역과 도착역을 모두 선택해주세요.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('확인'),
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
    bool isDeparture, // isDeparture 변수 추가
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
                builder: (context) => StationListPage(isDeparture: isDeparture),
              ), // isDeparture 전달
            );
            if (result != null && result is String) {
              onStationSelected(result);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            // border 제거
            child: Text(
              selectedStation ?? '선택',
              style: TextStyle(fontSize: 40, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
