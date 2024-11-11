import 'package:flutter/material.dart';

class WeatherDataDisplay extends StatelessWidget {
  final int value;
  final String unit;
  final IconData icon;
  final Color iconColor;

  const WeatherDataDisplay({super.key,
    required this.value,
    required this.unit,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(height: 4),
        Text(
          '$value $unit',
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
