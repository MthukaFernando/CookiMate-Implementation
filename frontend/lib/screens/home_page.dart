import 'dart:async'; 
import 'package:flutter/material.dart';
import 'tools/tools_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Typing animation
  final String _fullText = "Hi! What would you like to cook today?";
  String _displayedText = "";
  int _characterIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTypewriter();
  }

  @override
  void dispose() {
    _timer?.cancel(); 
    super.dispose();
  }

  void _startTypewriter() {
    
    _displayedText = "";
    _characterIndex = 0;

    // Timer adds one letter every 50-100 milliseconds
    _timer = Timer.periodic(const Duration(milliseconds: 80), (timer) {
      if (_characterIndex < _fullText.length) {
        setState(() {
          _displayedText += _fullText[_characterIndex];
          _characterIndex++;
        });
      } else {
        _timer?.cancel(); 
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Reset the animation when coming back to the home page
    if (index == 0) {
      _timer?.cancel();
      _startTypewriter();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      // Home page starts here
      SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  height: 350,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6D2B5),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Stack(
                    children: [
                      // 1. The Mascot
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/mascot.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      // 2. The Animated Text
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            _displayedText, // Shows the text as it "types"
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 62, 51, 35),
                              fontFamily: 'Courier', // Gives it a typewriter feel
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //Wenuka can insert anything here

            ],
          ),
        ),
      ),

      const ToolsPage(),
      const Center(child: Text("Planner page", style: TextStyle(fontSize: 20))),
      const Center(child: Text("Shop page", style: TextStyle(fontSize: 20))),
      const Center(child: Text("Profile page", style: TextStyle(fontSize: 20))),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF2ECE2),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFE6D2B5),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color.fromARGB(255, 141, 115, 97),
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'TOOLS'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'PLANNER'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'SHOP'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'PROFILE'),
        ],
      ),
    );
  }
}