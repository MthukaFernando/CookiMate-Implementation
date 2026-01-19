// import 'package:flutter/material.dart';
//
// class TimerPage extends StatelessWidget {
//   const TimerPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text("This is the Timer Page", style: TextStyle(fontSize: 18)),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';

//Used stateful widget as timer value changes over time
class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  // Added colors to match CookiMate's color palette
  final Color cardColor = const Color(0xFFD9B99B);
  final Color buttonTextColor = const Color(0xFF4A3F35);
  final Color secondaryColor = const Color(0xFFF5EFE6);

  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Starts or pauses the timer depending on the current state
  void _toggleTimer() {
    if (_isRunning) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() => _seconds++);
        }
      });
    }
    setState(() => _isRunning = !_isRunning);
  }

  void _resetTimer() {
    _timer?.cancel(); // Stop the timer first
    _timer = null;    // completely delete it
    setState(() {
      _seconds = 0;
      _isRunning = false;
    });
  }

  // Converts seconds into HH : MM : SS format
  String _formatTime() {
    int h = _seconds ~/ 3600;
    int m = (_seconds % 3600) ~/ 60;
    int s = _seconds % 60;
    return "${h.toString().padLeft(2, '0')} : ${m.toString().padLeft(2, '0')} : ${s.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    // We use SingleChildScrollView so it works on small screens without overflowing
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Main Timer Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Timer",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3E3329)
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Labels
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("hr    ", style: TextStyle(color: Colors.black54)),
                      Text("min    ", style: TextStyle(color: Colors.black54)),
                      Text("sec", style: TextStyle(color: Colors.black54)),
                    ],
                  ),

                  // Big Timer Text
                  Text(
                    _formatTime(),
                    style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  // Alarm Sound Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.notifications_none, size: 18),
                        SizedBox(width: 8),
                        Text("Alarm sound"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton("Cancel", _resetTimer),
                      _buildButton(_isRunning ? "Pause" : "Start", _toggleTimer),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: secondaryColor,
        foregroundColor: buttonTextColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
      ),
      child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
      ),
    );
  }
}