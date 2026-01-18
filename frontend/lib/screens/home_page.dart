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
                              fontSize: 24,
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
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [
                      _buildActionCard(
                        icon: Icons.search,
                        title: "Find recipes by ingredients",
                        subtitle: "Tell me what you have and I'll find perfect recipes for you",
                        borderColor: const Color(0xFF522F2F),
                        iconBgColor: const Color.fromARGB(255, 240, 228, 190),
                      ),
                      const SizedBox(height: 18),
                      _buildActionCard(
                        icon: Icons.auto_awesome_mosaic_outlined,
                        title: "Generate custom recipes",
                        subtitle: "Describe what you want and I'll give you the recipe",
                        borderColor: const Color.fromARGB(255, 161, 95, 36),
                        iconBgColor: const Color.fromARGB(255, 240, 228, 190),
                      ),
                      const SizedBox(height: 18),
                      _buildActionCard(
                        icon: Icons.person_search_outlined,
                        title: "Go to Community Page",
                        subtitle: "Join the community, explore other's posts and recipes, leave a like and comment and share your cooking with friends!",
                        borderColor: const Color.fromARGB(255, 198, 181, 110),
                        iconBgColor: const Color.fromARGB(255, 240, 228, 190),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              

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
Widget _buildActionCard({required IconData icon, required String title, required String subtitle, required Color borderColor, required Color iconBgColor,}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      // --- ENHANCED 3D SHADOW ---
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1), // Soft outer glow
          blurRadius: 20,
          offset: const Offset(0, 4),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.2), // Darker bottom shadow for depth
          blurRadius: 8,
          offset: const Offset(0, 8), // Moves the shadow down to create height
        ),
      ],
      // Adding a very light border makes the edges pop against the brown
      border: Border.all(color: borderColor,width: 3,),),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconBgColor,
            border: Border.all(color: Colors.black, width: 1.5),
            borderRadius: BorderRadius.circular(14),
            // Minimal shadow for the icon box to make it look inset
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              )
            ]
          ),
          child: Icon(icon, size: 32, color: Colors.black),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E2E2E),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
  }