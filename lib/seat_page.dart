import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // CupertinoDialog 사용을 위해 추가

class SeatPage extends StatefulWidget {
  final String departureStation;
  final String arrivalStation;

  const SeatPage({
    super.key,
    required this.departureStation,
    required this.arrivalStation,
  });

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  List<int> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('좌석 선택'))),
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
                    widget.departureStation, // HomePage에서 전달받은 출발역 표시
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  Icon(Icons.arrow_circle_right_outlined, size: 30),
                  Text(
                    widget.arrivalStation, // HomePage에서 전달받은 도착역 표시
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              // 좌석 상태 안내 레이블 추가
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 24, height: 24, color: Colors.purple),
                  const SizedBox(width: 4),
                  const Text('선택됨'),
                  const SizedBox(width: 20),
                  Container(width: 24, height: 24, color: Colors.grey[300]),
                  const SizedBox(width: 4),
                  const Text('선택 안됨'),
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
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 8,
                ),
                itemCount: 20 * 5,
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
                          style: TextStyle(fontSize: 18),
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
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.purple : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          '',
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      selectedSeats
                              .isNotEmpty // 선택된 좌석이 있을 때만 버튼 활성화
                          ? () {
                            showCupertinoDialog(
                              context: context,
                              builder:
                                  (context) => CupertinoAlertDialog(
                                    title: const Text('예매 확인'),
                                    content: const Text('선택하신 좌석으로 예매하시겠습니까?'),
                                    actions: [
                                      CupertinoDialogAction(
                                        child: const Text('취소'),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      CupertinoDialogAction(
                                        child: const Text('확인'),
                                        onPressed: () {
                                          Navigator.pop(context); // Dialog 제거
                                          Navigator.pop(context); // SeatPage 제거
                                          Navigator.pop(
                                            context,
                                          ); // HomePage로 이동
                                        },
                                      ),
                                    ],
                                  ),
                            );
                          }
                          : null, // 선택된 좌석이 없으면 버튼 비활성화
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
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
