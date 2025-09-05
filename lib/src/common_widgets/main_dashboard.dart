import 'package:flutter/material.dart';
import 'package:jira_clone/src/features/profile/presentation/profile_screen.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int currentIndex = 0;

  final tabs = [Center(child: Text('Home Tab')), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mini-Jira')),
      body: tabs[currentIndex],
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onDestinationSelected: (value) => setState(() {
          currentIndex = value;
        }),
        selectedIndex: currentIndex,
      ),
    );
  }
}
