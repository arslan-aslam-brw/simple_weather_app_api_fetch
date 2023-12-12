import 'package:flutter/material.dart';

/// Seprated Widget For Hourly, easy to use, code redendency remover method, make
/// one widget or method, create construcotr and call it where we want and modified their
class HourlyForcate extends StatelessWidget {
  final String textTime;
  final String textDate;
  final IconData icon;
  final String temprature;
  final String textClear;
  final String textPredictCloudOrRainPercent;

  const HourlyForcate(
      {super.key,
      required this.textTime,
      required this.textDate,
      required this.icon,
      required this.temprature,
      required this.textClear,
      required this.textPredictCloudOrRainPercent});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 150,
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
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              textDate,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 5,
            ),
            Icon(
              icon,
              size: 25,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(temprature),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(textClear),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  textPredictCloudOrRainPercent,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
