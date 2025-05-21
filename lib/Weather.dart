import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherApp extends StatefulWidget {
  @override
  State<WeatherApp> createState() => _HomePageState();
}

class _HomePageState extends State<WeatherApp> {
  String? _weatherDescription;
  String? _temperature;
  String? _cityName;
  String? _weatherIcon;
  String _time = DateFormat('hh:mm a').format(DateTime.now());
  bool _loading = true;

  final String _apiKey = '130fdc09a0a45817dab98cb1188f5281'; // ← Paste your API key

  @override
  void initState() {
    super.initState();
    _fetchLocationAndWeather();
  }

  Future<void> _fetchLocationAndWeather() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.always &&
            permission != LocationPermission.whileInUse) {
          throw Exception('Location permission denied.');
        }
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      await _fetchWeather(position.latitude, position.longitude);
    } catch (e) {
      print('Location error: $e');
      setState(() {
        _loading = false;
        _weatherDescription = "Location can't be detected";
      });
    }
  }

  Future<void> _fetchWeather(double lat, double lon) async {
    try {
      final url =
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_apiKey&units=metric';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _cityName = data['name'];
          _temperature = data['main']['temp'].toString();
          _weatherDescription = data['weather'][0]['description'];
          _weatherIcon = data['weather'][0]['icon'];
          _time = DateFormat('hh:mm a').format(DateTime.now());
          _loading = false;
        });
      } else {
        throw Exception('Weather API failed');
      }
    } catch (e) {
      print('Weather fetch error: $e');
      setState(() {
        _loading = false;
        _weatherDescription = "Weather can't be detected";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TravelLovers'),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: _loading
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_weatherIcon != null)
              Image.network(
                'https://openweathermap.org/img/wn/$_weatherIcon@2x.png',
              ),
            SizedBox(height: 10),
            Text(
              'Time: $_time',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              _cityName != null ? 'Dhaka: $_cityName' : '',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              _temperature != null ? 'Temperature: $_temperature°C' : '',
              style: TextStyle(fontSize: 28),
            ),
            Text(
              _weatherDescription != null
                  ? 'Weather: $_weatherDescription'
                  : '',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
