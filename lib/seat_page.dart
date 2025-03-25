import 'package:flutter/material.dart';

class SeatPage extends StatefulWidget {
  const SeatPage({super.key});

  @override
  SeatPageState createState() => SeatPageState();
}

class SeatPageState extends State<SeatPage> {
  List<int> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('좌석 선택'))),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  ['A', 'B', 'C', 'D']
                      .map(
                        (label) => SizedBox(
                          width: 50,
                          height: 50,
                          child: Center(
                            child: Text(label, style: TextStyle(fontSize: 18)),
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
                  crossAxisSpacing: 4, // 좌석 위젯 가로 간격 4
                  mainAxisSpacing: 8, // 좌석 위젯 세로 간격 8
                ),
                itemCount: 20, // 총 좌석 행 개수 20개
                itemBuilder: (context, index) {
                  final seatNumber = index + 1;
                  final isSelected = selectedSeats.contains(seatNumber);

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
                      width: 50, // 좌석 위젯 너비 50
                      height: 50, // 좌석 위젯 높이 50
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.purple : Colors.grey[300],
                        borderRadius: BorderRadius.circular(
                          8,
                        ), // 좌석 위젯 모서리 둥글기 8
                      ),
                      child: Center(
                        child: Text(
                          '$seatNumber',
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
            ElevatedButton(
              onPressed: () {
                // 예매하기 버튼 클릭 시 동작
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple, // 예매하기 버튼 색상
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // 예매하기 버튼 모서리 둥글기 20
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
                child: Text(
                  '예매하기',
                  style: TextStyle(
                    color: Colors.white, // 예매하기 글자 색상
                    fontSize: 18, // 예매하기 글자 크기
                    fontWeight: FontWeight.bold, // 예매하기 글자 두께
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
