import 'package:flutter/material.dart';
import 'package:flutter_train_app/seat_page.dart'; // SeatPage import

class StationListPage extends StatelessWidget {
  const StationListPage({super.key}); // key 매개변수 추가

  @override
  Widget build(BuildContext context) {
    // final Map<String, String> args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('출발역')), // 앱바 타이틀 중앙 정렬
      ),
      body: ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            // GestureDetector 추가
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SeatPage(),
                ), // SeatPage로 이동
              );
            },
            child: Container(
              height: 50, // 기차역 이름 감싸는 영역 높이 50
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300]!), // 아래 테두리 색상
                ),
              ),
              child: Center(
                child: Text(
                  stations[index],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// 기차역 목록
final List<String> stations = [
  '수서',
  '동탄',
  '평택지제',
  '천안아산',
  '오송',
  '대전',
  '김천구미',
  '동대구',
  '경주',
  '울산',
  '부산',
];
