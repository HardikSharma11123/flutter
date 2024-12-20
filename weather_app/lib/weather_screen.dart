import 'dart:convert';
import 'dart:ui';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/addionalinfo.dart';
import 'package:weather_app/hourly_forecast_Item.dart';
import 'package:weather_app/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityname = 'London';
      final res = await http.get(
        Uri.parse(
            'http://api.openweathermap.org/data/2.5/forecast?q=$cityname,uk&APPID=$openWeatherApikey'),
      );
      final data = jsonDecode(res.body);
      if (int.parse(data['cod']) != 200) {
        throw "An Unexpexted Error Occured";
      }
      return data;

      //temp = (data['list'][0]['main']['temp']);
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData.dark(useMaterial3: true);
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Weather App",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.refresh),
            )
          ],
          centerTitle: true),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureBuilder(
          future: getCurrentWeather(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: LinearProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            final data = snapshot.data!;
            final currentweat = data['list'][0];
            final currenttemp =
                (currentweat['main']['temp'] - 273.15).toStringAsFixed(2);
            final currentsky = (currentweat['weather'][0]['main']);
            final pressure = (currentweat['main']['pressure']);
            final humidity = (currentweat['main']['humidity']);
            final windspeed = (currentweat['wind']['speed']);

            String backgroundImage;
            try {
              if (currentsky == 'Rain') {
                backgroundImage = 'assets/rainy.jpg';
              } else if (currentsky == 'Clouds') {
                backgroundImage = 'assets/cloudy.jpg';
              } else {
                backgroundImage = 'assets/sunny.jpg';
              }
            } catch (e) {
              backgroundImage = 'assets/default_weather.jpg'; // Fallback image
              //print('Error loading image: $e');
            }

            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(backgroundImage), fit: BoxFit.cover)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "London",
                            //textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //main card
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 10,
                              sigmaY: 10,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Text(
                                    "$currenttemp °C",
                                    style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Icon(
                                    currentsky == 'Clouds' ||
                                            currentsky == 'Rain'
                                        ? Icons.cloud
                                        : Icons.sunny,
                                    size: 70,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    "$currentsky",
                                    style: const TextStyle(
                                      fontSize: 24,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Hourly Forecast",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // const SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     children: [
                    //       HourlyForecastItem(
                    //         timee: "03:00",
                    //         icon: Icons.cloud,
                    //         temp: "100",
                    //       ),
                    //       HourlyForecastItem(
                    //         timee: "03:00",
                    //         icon: Icons.cloud,
                    //         temp: "100",
                    //       ),
                    //       HourlyForecastItem(
                    //         timee: "03:00",
                    //         icon: Icons.cloud,
                    //         temp: "100",
                    //       ),
                    //       HourlyForecastItem(
                    //         timee: "03:00",
                    //         icon: Icons.cloud,
                    //         temp: "100",
                    //       ),
                    //       HourlyForecastItem(
                    //         timee: "03:00",
                    //         icon: Icons.cloud,
                    //         temp: "100",
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 140,
                      child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final hourlyForecast = data['list'][index + 1];
                          final hourlysky =
                              data['list'][index + 1]['weather'][0]['main'];
                          final horlytemp = (hourlyForecast['main']['temp'] -
                                  273.15)
                              .toStringAsFixed(
                                  2); // Convert Kelvin to Celsius and format to two decimal places

                          final time = DateTime.parse(hourlyForecast['dt_txt']);
                          return HourlyForecastItem(
                              timee: DateFormat.j().format(time),
                              temp: horlytemp,
                              icon: hourlysky == 'Clouds' || hourlysky == 'Rain'
                                  ? Icons.cloud
                                  : Icons.sunny);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Addtional Information",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Addionalinfo(
                          icon: Icons.water_drop,
                          lable: "Humidity",
                          value: "$humidity",
                        ),
                        Addionalinfo(
                          icon: Icons.air,
                          lable: "Wind Speed",
                          value: "$windspeed",
                        ),
                        Addionalinfo(
                          icon: Icons.beach_access,
                          lable: "Pressure",
                          value: "$pressure",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 180,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
