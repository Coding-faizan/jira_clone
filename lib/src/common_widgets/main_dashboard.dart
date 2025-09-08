import 'package:flutter/material.dart';
import 'package:jira_clone/src/features/profile/presentation/profile_screen.dart';
import 'package:jira_clone/src/features/sprint/presentation/home_tab.dart';
import 'package:jira_clone/src/features/ticket/presentation/tickets_tab.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int currentIndex = 0;

  final tabs = [HomeTab(), TicketsTab(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mini-Jira')),
      body: tabs[currentIndex],
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.list), label: 'Tickets'),
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
