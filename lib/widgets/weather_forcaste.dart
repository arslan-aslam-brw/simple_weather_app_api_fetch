import 'package:flutter/material.dart';

class WeatherForcaste extends StatelessWidget {
  const WeatherForcaste({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          HourlyForcate(
              icon: Icons.cloud_circle_outlined,
              textTime: "9:00",
              temprature: "301.71"),
          HourlyForcate(
              icon: Icons.cloud_circle_outlined,
              textTime: "10:00",
              temprature: "301.71"),
          HourlyForcate(
              icon: Icons.cloud_circle_outlined,
              textTime: "12:00",
              temprature: "301.71"),
          HourlyForcate(
              icon: Icons.cloud_circle_outlined,
              textTime: "1:00",
              temprature: "301.71"),
          HourlyForcate(
              icon: Icons.cloud_circle_outlined,
              textTime: "1:00",
              temprature: "301.71"),
          HourlyForcate(
              icon: Icons.cloud_circle_outlined,
              textTime: "1:00",
              temprature: "301.71"),
          HourlyForcate(
              icon: Icons.cloud_circle_outlined,
              textTime: "1:00",
              temprature: "301.71"),
        ],
      ),
    );
  }
}

/// Seprated Widget For Hourly, easy to use, code redendency remover method, make
/// one widget or method, create construcotr and call it where we want and modified their
class HourlyForcate extends StatelessWidget {
  final String textTime;
  final IconData icon;
  final String temprature;

  const HourlyForcate(
      {super.key,
      required this.textTime,
      required this.icon,
      required this.temprature});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Card(
        elevation: 10,
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Text(
              textTime,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Icon(
              icon,
              size: 20,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(temprature),
          ],
        ),
      ),
    );
  }
}
