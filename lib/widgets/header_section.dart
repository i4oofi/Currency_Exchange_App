import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Currency Converter',
          style: TextStyle(
            color: Color(0xff1F2261),
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Check live rates, set rate alerts, receive\n notifications and more.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Color(0xff808080)),
        ),
      ],
    );
  }
}
