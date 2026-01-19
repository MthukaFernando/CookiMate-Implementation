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

    if (index == 0) {
      _timer?.cancel();
      _startTypewriter();
    }
  }

  // ================= CHAT POPUP =================
  void _openChatBox() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFF2ECE2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 15),

                const Text(
                  "Chat with CookiMate",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // Empty messages area
                Expanded(
                  child: Center(
                    child: Text(
                      "Start a conversation 👋",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),

                // Input box
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Type your message...",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      CircleAvatar(
                        backgroundColor: const Color(0xFF522F2F),
                        child: IconButton(
                          icon: const Icon(Icons.send, color: Colors.white),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
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
                      // Mascot (clickable)
                      Positioned.fill(
                        child: GestureDetector(
                          onTap: _openChatBox,
                          child: Image.asset(
                            'assets/images/mascot.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // Animated text
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            _displayedText,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 62, 51, 35),
                              fontFamily: 'Courier',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildActionCard(
                      icon: Icons.search,
                      title: "Find recipes by ingredients",
                      subtitle:
                          "Tell me what you have and I'll find perfect recipes for you",
                      borderColor: const Color(0xFF522F2F),
                      iconBgColor: const Color.fromARGB(255, 240, 228, 190),
                    ),
                    const SizedBox(height: 18),
                    _buildActionCard(
                      icon: Icons.auto_awesome_mosaic_outlined,
                      title: "Generate custom recipes",
                      subtitle:
                          "Describe what you want and I'll give you the recipe",
                      borderColor:
                          const Color.fromARGB(255, 161, 95, 36),
                      iconBgColor: const Color.fromARGB(255, 240, 228, 190),
                    ),
                    const SizedBox(height: 18),
                    _buildActionCard(
                      icon: Icons.person_search_outlined,
                      title: "Go to Community Page",
                      subtitle:
                          "Join the community, explore posts and share recipes!",
                      borderColor:
                          const Color.fromARGB(255, 198, 181, 110),
                      iconBgColor: const Color.fromARGB(255, 240, 228, 190),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      const ToolsPage(),
      const Center(child: Text("Planner page")),
      const Center(child: Text("Shop page")),
      const Center(child: Text("Profile page")),
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
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: 'PLANNER'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'SHOP'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'PROFILE'),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color borderColor,
    required Color iconBgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: borderColor, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, size: 32),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(subtitle,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}