import 'package:flutter/material.dart';
import 'timer_page.dart';
import 'converter_page.dart';

class ToolsPage extends StatefulWidget {
  const ToolsPage({super.key});

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  bool isTimerSelected = true; // State to track the toggle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 1. Back Button
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            
            // 2. The Toggle Button (Simplified version of your screenshot)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => setState(() => isTimerSelected = true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      decoration: BoxDecoration(
                        color: isTimerSelected ? const Color(0xFFD9B691) : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text("Timer"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => isTimerSelected = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      decoration: BoxDecoration(
                        color: !isTimerSelected ? const Color(0xFFD9B691) : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text("Converter"),
                    ),
                  ),
                ],
              ),
            ),

            // 3. The Dynamic Content Area
            Expanded(
              child: isTimerSelected ? const TimerPage() : const ConverterPage(),
            ),
          ],
        ),
      ),
    );
  }
}