import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  final bool isDeparture; // 출발역/도착역 여부
  final String? selectedStation; // 이미 선택된 역 (선택 사항)

  const StationListPage({
    super.key,
    required this.isDeparture,
    this.selectedStation,
  });

  @override
  Widget build(BuildContext context) {
    List<String> filteredStations = [];

    try {
      // 이미 선택된 역을 제외한 역 목록 생성
      filteredStations =
          stations.where((station) => station != selectedStation).toList();
    } catch (e) {
      // 예외 발생 시 빈 리스트로 초기화하여 앱 종료 방지
      filteredStations = [];
      debugPrint('예외 발생: $e');
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(isDeparture ? '출발역' : '도착역')), // 조건에 맞게 제목 변경
      ),
      body:
          filteredStations.isNotEmpty
              ? ListView.builder(
                itemCount: filteredStations.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      try {
                        Navigator.pop(
                          context,
                          filteredStations[index],
                        ); // 선택한 역 이름 반환
                      } catch (e) {
                        debugPrint('Navigator 예외 발생: $e');
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            filteredStations[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
              : Center(
                child: Text(
                  '선택할 수 있는 역이 없습니다.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
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
