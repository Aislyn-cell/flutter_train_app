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
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: 20,
                itemBuilder: (context, rowIndex) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Center(
                          child: Text(
                            (rowIndex + 1).toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      ...List.generate(4, (colIndex) {
                        final seatNumber = rowIndex * 4 + colIndex + 1;
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
                            decoration: BoxDecoration(
                              color:
                                  isSelected ? Colors.purple : Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                '',
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
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
}
