import 'package:flutter/material.dart';
import 'package:flutter_train_app/station_list_page.dart'; // StationListPage import

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
      appBar: AppBar(
        title: Center(child: Text('기차 예매')), // 앱바 타이틀 중앙 정렬
      ),
      backgroundColor: Colors.grey[200], // body 배경색 회색
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Scaffold body padding 20
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 세로 가운데 정렬
          children: [
            Container(
              height: 200, // 높이 200
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white, // 배경색 흰색
                borderRadius: BorderRadius.circular(20), // 모서리 둥글기 20
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceAround, // 출발역, 도착역 간격 동일하게 배치
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '출발역',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton<String>(
                        value: departureStation,
                        onChanged: (value) {
                          setState(() {
                            departureStation = value;
                          });
                        },
                        items:
                            stations.map((station) {
                              return DropdownMenuItem<String>(
                                value: station,
                                child: Text(station),
                              );
                            }).toList(),
                        hint: Text(
                          '선택',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                          ), // 선택 글자 크기 40, 색상 검정색
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50, // 세로선 높이
                    child: VerticalDivider(
                      width: 2,
                      thickness: 2,
                      color: Colors.grey[400], // 세로선 색상
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '도착역',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton<String>(
                        value: arrivalStation,
                        onChanged: (value) {
                          setState(() {
                            arrivalStation = value;
                          });
                        },
                        items:
                            stations.map((station) {
                              return DropdownMenuItem<String>(
                                value: station,
                                child: Text(station),
                              );
                            }).toList(),
                        hint: Text(
                          '선택',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                          ), // 선택 글자 크기 40, 색상 검정색
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), // 좌석 선택 버튼과 박스 간 간격 20
            SizedBox(
              // 좌석 선택 버튼 길이 조절
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (departureStation != null && arrivalStation != null) {
                    Navigator.pushNamed(
                      context,
                      '/stationList',
                      arguments: {
                        'departure': departureStation,
                        'arrival': arrivalStation,
                      },
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('출발역과 도착역을 모두 선택해주세요.')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, // 버튼 색상 보라색
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // 버튼 모서리 둥글기 20
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
}
