import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
                    widget.departureStation,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  Icon(Icons.arrow_circle_right_outlined, size: 30),
                  Text(
                    widget.arrivalStation,
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
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text('선택됨'),
                  const SizedBox(width: 20),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text('선택 안됨'),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, // 균등 간격 배치
              children: [
                const SizedBox(width: 20), // A, B 시작 위치 조정
                Text('A', style: TextStyle(fontSize: 18)),
                Text('B', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 80), // C, D 시작 위치 조정
                Text('C', style: TextStyle(fontSize: 18)),
                Text('D', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 20),
              ],
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: 10,
                itemBuilder: (context, rowIndex) {
                  return Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceAround, // 좌석 그룹 간 간격 조정
                    children: [
                      Row(
                        children: [
                          buildSeat(rowIndex * 4 + 1),
                          const SizedBox(width: 10), // A, B 좌석 간 간격
                          buildSeat(rowIndex * 4 + 2),
                        ],
                      ),
                      SizedBox(
                        width: 50, // 숫자 위치 조정
                        height: 50,
                        child: Center(
                          child: Text(
                            (rowIndex + 1).toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          buildSeat(rowIndex * 4 + 3),
                          const SizedBox(width: 10), // C, D 좌석 간 간격
                          buildSeat(rowIndex * 4 + 4),
                        ],
                      ),
                    ],
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
                      selectedSeats.isNotEmpty
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
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                            );
                          }
                          : null,
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

  Widget buildSeat(int seatNumber) {
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
        width: 50,
        height: 50,
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
