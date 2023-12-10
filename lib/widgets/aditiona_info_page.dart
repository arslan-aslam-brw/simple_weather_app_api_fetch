import 'package:flutter/material.dart';

/// Seprated Widget For Hourly, easy to use, code redendency remover method, make
/// one widget or method, create construcotr and call it where we want and modified their
class AditionalInfo extends StatelessWidget {
  final IconData icon;
  final String textInfo;
  final String textTepm;

  const AditionalInfo(
      {super.key,
      required this.icon,
      required this.textInfo,
      required this.textTepm});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Icon(
            icon,
            size: 20,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(textInfo),
          const SizedBox(
            height: 5,
          ),
          Text(
            textTepm,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
