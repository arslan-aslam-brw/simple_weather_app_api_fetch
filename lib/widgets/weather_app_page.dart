import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:simple_weather_app_api_fetch/widgets/aditiona_info_page.dart';
import 'package:simple_weather_app_api_fetch/widgets/secrect_api.dart';
import 'package:simple_weather_app_api_fetch/widgets/weather_forcaste.dart';
import 'package:http/http.dart' as http;

class WeatherAppPage extends StatefulWidget {
  const WeatherAppPage({super.key});

  @override
  State<WeatherAppPage> createState() => _WeatherAppPageState();
}

class _WeatherAppPageState extends State<WeatherAppPage> {
  /// rebuild state in statefull widget
  @override
  void initState() {
    super.initState();
    getTemp();
  }

  /// function for getting Temp from API Key
  Future<Map<String, dynamic>> getTemp() async {
    try {
      const city = 'London';

      /// http.get is from https packge of flutter
      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$city&APPID=$appid'),
      );

//// because we extracting different different things from jsonFile, so we use jsonDecode
      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw "Error in API json File";
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Weather App",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh_outlined),
          ),
        ],
      ),

      /// future builder is use dfor handling data for future, it recover api calls
      /// handle states of widets, states through snapshoot atribute
      body: FutureBuilder(
        future: getTemp(),
        builder: (context, snapshot) {
          /// adding progress indicator if data from web is late
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          /// Handling error if error occure, give this mesage
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          /// getting data from API , web
          final data = snapshot.data!;

          final currentTemp = (data['list'][0]['main']['temp']);

          /// [0] is used for showing int to string, because json file has data in Map,
          final skyPredic = (data['list'][0]['weather'][0]['main']);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                  "$currentTemp F",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Icon(
                                  /// setting conditions with ternary operator, if coud,
                                  skyPredic == 'Clouds' || skyPredic == 'Rain'
                                      ? Icons.cloud
                                      : Icons.cloudy_snowing,
                                  size: 60,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  skyPredic,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
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
                    "Weather Forcaste",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),

                  /// calling Forcaste widget
                  const WeatherForcaste(),

                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Additional Information",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),

                  /// calling Aditional Information widget
                  const SizedBox(
                    height: 10,
                  ),
                  const AditionalInfoWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
