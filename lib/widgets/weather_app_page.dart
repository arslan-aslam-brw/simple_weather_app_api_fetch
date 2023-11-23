import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:simple_weather_app_api_fetch/widgets/aditiona_info_page.dart';
import 'package:simple_weather_app_api_fetch/widgets/weather_forcaste.dart';

class WeatherAppPage extends StatelessWidget {
  const WeatherAppPage({super.key});

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
            onPressed: () {},
            icon: const Icon(Icons.refresh_outlined),
          ),
        ],
      ),
      body: Padding(
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
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              "300.6F",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Icon(
                              Icons.cloud,
                              size: 60,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Rain",
                              style: TextStyle(
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
      ),
    );
  }
}
