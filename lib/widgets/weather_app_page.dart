import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  late Future<Map<String, dynamic>> weatherUpdate;

  /// rebuild state in statefull widget
  @override
  void initState() {
    super.initState();
    weatherUpdate = getTemp();
  }

  /// function for getting Temp from API Key
  Future<Map<String, dynamic>> getTemp() async {
    try {
      String city = 'Vehari';

      /// http.get is from https packge of flutter
      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$city,PK&units=metric&APPID=$appid'),
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
              setState(() {
                weatherUpdate = getTemp();
              });
            },
            icon: const Icon(Icons.refresh_outlined),
          ),
        ],
      ),

      /// future builder is used for handling data for future, it recover api calls
      /// handle states of widets, states through snapshoot atribute
      body: FutureBuilder(
        future: weatherUpdate,
        builder: (context, snapshot) {
          /// adding progress indicator if data from web is late
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          /// Handling error if error occure, give this mesage
          if (snapshot.hasError) {
            return const Center(
              child: Text("Please Check Your'e Internet Connection!"),
            );
          }

          /// getting data from API , web or scaning json file with snapshot keyword
          final data = snapshot.data!;

          /// Extracting Data From jsonFile
          /// For Current Temprature
          final currentTemp = (data['list'][0]['main']['temp']);

          /// In json file, Data is overall data of jsonFile, list is a object of jsonFile
          /// and ['main'], [0], ['temp'] is object of list, of jsonFile, [0], is possition
          /// of object of jsonFile, there is list on zero and city is on 1 possition
          /// in this jsonFile

          /// skyPrediction, coluds or Rain
          /// /// [0] is used for showing int to string, because json file has data in Map,
          final skyPredic = (data['list'][0]['weather'][0]['main']);
          final getCloudCover = (data['list'][0]['clouds']['all']);

          /// For Humidity
          final gethumidity = (data['list'][0]['main']['humidity']);

          /// For Wind Speed
          final getWindSpeed = (data['list'][0]['wind']['speed']);

          /// For Pressure
          final getPressure = (data['list'][0]['main']['pressure']);

          final getCityName = (data['city']['name']);

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
                            child: Center(
                              child: Text(
                                "$getCityName, Punjab, Pakistan",
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),

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
                                  "$currentTemp °C",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Icon(
                                  /// setting conditions with ternary operator, if cloud,
                                  skyPredic == 'Clouds' || skyPredic == 'Rain'
                                      ? Icons.cloud
                                      : Icons.sunny,
                                  size: 60,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "$skyPredic",
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    if (skyPredic == 'Clouds' ||
                                        skyPredic == 'Rain')
                                      Text(
                                        "$getCloudCover%",
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                  ],
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
                    "Hourly & Weekly Forcaste",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  /// Hourly Forcaste widget

                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 39,
                      itemBuilder: (context, index) {
                        /// getting time from web, jsonFile
                        final getTime = data['list'][index + 1]['dt_txt'];
                        final getDate = data['list'][index + 1]['dt_txt'];

                        /// getting Clouds or Not of all items of json
                        final getSkyPredic =
                            (data['list'][index + 1]['weather'][0]['main']);

                        /// With intl package, we extracting only time from jsonFile
                        ///
                        final time = DateTime.parse(getTime);
                        final date = DateTime.parse(getDate);

                        return HourlyForcate(
                          icon:
                              getSkyPredic == 'Clouds' || getSkyPredic == 'Rain'
                                  ? Icons.cloud
                                  : Icons.sunny,
                          temprature:
                              "${data['list'][index + 1]['main']['temp'].toString()} °C ",

                          /// Formating time style
                          textTime: DateFormat.jm().format(time).toString(),
                          textDate: DateFormat('d/M/y').format(date).toString(),

                          textClear: data['list'][index + 1]['weather'][0]
                                  ['main']
                              .toString(),

                          textPredictCloudOrRainPercent: getSkyPredic ==
                                      'Clouds' ||
                                  getSkyPredic == 'Rain'
                              ? "${data['list'][index + 1]['clouds']['all'].toString()}%"
                              : const String.fromEnvironment(''),
                        );
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Additional Information",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  /// Aditional Information widget
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AditionalInfo(
                          icon: Icons.water_drop_outlined,
                          textInfo: "Humidity",
                          textTepm: gethumidity.toString()),
                      AditionalInfo(
                          icon: Icons.wind_power_outlined,
                          textInfo: "Wind Speed",
                          textTepm: getWindSpeed.toString()),
                      AditionalInfo(
                          icon: Icons.compress_outlined,
                          textInfo: "Pressur",
                          textTepm: getPressure.toString()),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
