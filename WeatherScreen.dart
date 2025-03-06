import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {
  Map<String, dynamic>? weatherData;

  @override
  void initState() {
    super.initState();
    _loadWeatherData();
  }

  Future<void> _loadWeatherData() async {
    try {
      String jsonString = await rootBundle.loadString('assets/weather.json');
      final data = json.decode(jsonString);
      setState(() {
        weatherData = data;
      });
    } catch (e) {
      // ignore: avoid_print
      print("Lỗi khi đọc file JSON: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Thời Tiết")),
      body: weatherData == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Thành phố: ${weatherData!['name']}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text("Nhiệt độ: ${weatherData!['main']['temp']}°C"),
                  Text("Độ ẩm: ${weatherData!['main']['humidity']}%"),
                  Text(
                      "Thời tiết: ${weatherData!['weather'][0]['description']}"),
                ],
              ),
            ),
    );
  }
}
