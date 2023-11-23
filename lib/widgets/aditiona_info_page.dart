import 'package:flutter/material.dart';

class AditionalInfoWidget extends StatelessWidget {
  const AditionalInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          child: Column(
            children: [
              Icon(
                Icons.water_drop_rounded,
                size: 20,
              ),
              SizedBox(
                height: 5,
              ),
              Text("Humidity"),
              SizedBox(
                height: 5,
              ),
              Text("60", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        SizedBox(
          child: Column(
            children: [
              Icon(
                Icons.wind_power_outlined,
                size: 20,
              ),
              SizedBox(
                height: 5,
              ),
              Text("Wind Speed"),
              SizedBox(
                height: 5,
              ),
              Text("7.57", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        SizedBox(
          child: Column(
            children: [
              Icon(
                Icons.compress_outlined,
                size: 20,
              ),
              SizedBox(
                height: 5,
              ),
              Text("Pressure"),
              SizedBox(
                height: 5,
              ),
              Text(
                "1003",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
