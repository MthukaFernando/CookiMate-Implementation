import 'package:flutter/material.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  // Tracks which converter is selected:
  // 0 = Weight, 1 = Temperature, 2 = Volume
  int _selectedConverterIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F0DE),
      body: SafeArea(
        child: Center(
          child: Container(
            width: 347,
            height: 378,
            decoration: BoxDecoration(
              color: const Color(0xFFE6C39A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              children: [
                SizedBox(height: 12),
                Text(
                  'Converter',
                  style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}