import 'package:flutter/material.dart';

class SeatPage extends StatefulWidget {
  const SeatPage({super.key});

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  List<int> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('좌석 선택')), // [앱바 타이틀]
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '수서', // [출발역]
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  Icon(
                    Icons.arrow_circle_right_outlined, // [화살표 아이콘]
                    size: 30,
                  ),
                  Text(
                    '부산', // [도착역]
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  ['A', 'B', 'C', 'D']
                      .map(
                        (label) => SizedBox(
                          width: 50,
                          height: 50,
                          child: Center(
                            child: Text(
                              label,
                              style: TextStyle(fontSize: 18), // [ABCD 레이블]
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 4, // [좌석 위젯] 가로 간격 4
                  mainAxisSpacing: 8, // [좌석 위젯] 세로 간격 8
                ),
                itemCount: 20 * 5, // 총 좌석 행 개수 20개
                itemBuilder: (context, index) {
                  final row = index ~/ 5;
                  final col = index % 5;
                  final seatNumber = row * 4 + col + 1;
                  final isSelected = selectedSeats.contains(seatNumber);

                  if (col == 0) {
                    return SizedBox(
                      width: 50,
                      height: 50,
                      child: Center(
                        child: Text(
                          (row + 1).toString(),
                          style: TextStyle(fontSize: 18), // [행 번호]
                        ),
                      ),
                    );
                  }

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedSeats.remove(seatNumber);
                        } else {
                          selectedSeats.add(seatNumber);
                        }
                      });
                    },
                    child: Container(
                      width: 50, // [좌석 위젯] 너비 50
                      height: 50, // [좌석 위젯] 높이 50
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.purple : Colors.grey[300],
                        borderRadius: BorderRadius.circular(
                          8,
                        ), // [좌석 위젯] 모서리 둥글기 8
                      ),
                      child: Center(
                        child: Text(
                          '', // [좌석 상태 텍스트]
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              // [예매 하기 버튼] 패딩 추가
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // 예매하기 버튼 클릭 시 동작
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ), // [예매 하기 버튼] 모서리 둥글기 20
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      '예매 하기',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
