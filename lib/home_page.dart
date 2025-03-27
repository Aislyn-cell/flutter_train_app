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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Center(
          child: Text('기차 예매', style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStationSelection('출발역', departureStation, (station) {
                    if (mounted) {
                      setState(() {
                        departureStation = station;
                      });
                    }
                  }, true),
                  SizedBox(
                    height: 50,
                    child: VerticalDivider(
                      width: 2,
                      thickness: 2,
                      color: Colors.grey[700],
                    ),
                  ),
                  _buildStationSelection('도착역', arrivalStation, (station) {
                    if (mounted) {
                      setState(() {
                        arrivalStation = station;
                      });
                    }
                  }, false),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (departureStation != null && arrivalStation != null) {
                    if (!context.mounted) return;
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
                    _showErrorDialog('출발역과 도착역을 모두 선택해주세요.');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
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
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () async {
            try {
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
              if (!mounted) return;
              if (result != null && result is String) {
                onStationSelected(result);
              }
            } catch (error) {
              _showErrorDialog('역 선택 중 오류가 발생했습니다.\n$error');
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              selectedStation ?? '선택',
              style: const TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  void _showErrorDialog(String message) {
    if (!context.mounted) return;
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.grey[900],
            title: const Text('오류 발생', style: TextStyle(color: Colors.white)),
            content: Text(message, style: const TextStyle(color: Colors.white)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('확인', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
    );
  }
}
