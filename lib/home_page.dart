import 'package:flutter/material.dart';
import 'package:flutter_train_app/stations.dart';

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
      appBar: AppBar(title: Text('출발/도착역 선택')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
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
              decoration: InputDecoration(labelText: '출발역'),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
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
              decoration: InputDecoration(labelText: '도착역'),
            ),
            SizedBox(height: 32),
            ElevatedButton(
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
              child: Text('다음'),
            ),
          ],
        ),
      ),
    );
  }
}
