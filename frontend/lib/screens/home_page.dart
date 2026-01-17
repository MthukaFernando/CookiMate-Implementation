import 'package:flutter/material.dart';
import 'tools/tools_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 1. MEMORY: This variable tracks which tab is currently active.
  int _selectedIndex = 0;

  // 2. PAGES: This list holds the widgets that will show up in the body.
  // When _selectedIndex is 0, it shows Home. When it is 1, it shows Tools.
  final List<Widget> _pages = [
    const Center(child: Text("This is the Home Page", style: TextStyle(fontSize: 20))),
    const ToolsPage(),
    const Center(child: Text("Planner page")),
    const Center(child: Text("Shop page")),
    const Center(child: Text("Profile page")),
  ];

  // 3. LOGIC: This function runs every time you tap a bottom icon.
  // setState tells Flutter to refresh the screen with the new index.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body updates automatically based on our list and the current index
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        // 'fixed' ensures all 5 labels and icons stay visible
        type: BottomNavigationBarType.fixed,
        
        // This links the visual highlight to our variable
        currentIndex: _selectedIndex,
        
        // This calls our function when a user taps the bar
        onTap: _onItemTapped,
        
        // Design settings to match your photo
        selectedItemColor: const Color(0xFFB8967E), // The tan color from your screenshot
        unselectedItemColor: Colors.black,          // Black for inactive icons
        showUnselectedLabels: true,                 // Always show the text labels
        selectedFontSize: 12,
        unselectedFontSize: 12,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.store), 
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time), 
            label: 'TOOLS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month), 
            label: 'PLANNER',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), 
            label: 'SHOP',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), 
            label: 'PROFILE',
          ),
        ],
      ),
    );
  }
}