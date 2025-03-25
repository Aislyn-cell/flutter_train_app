import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  const StationListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String departure = args['departure']!;
    final String arrival = args['arrival']!;

    return Scaffold(
      appBar: AppBar(title: Text('기차역 리스트')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('출발역: $departure'),
            Text('도착역: $arrival'),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/seat');
              },
              child: Text('좌석 선택'),
            ),
          ],
        ),
      ),
    );
  }
}
