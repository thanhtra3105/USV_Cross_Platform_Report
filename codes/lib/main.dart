import 'package:flutter/material.dart';
import 'pages/dashboardPage.dart';
import 'pages/missionPage.dart';
import 'pages/overviewPage.dart';
import 'pages/streamPage.dart';

void main() {
  runApp(USVApp());
}

class USVApp extends StatefulWidget {
  const USVApp({super.key});

  @override
  State<USVApp> createState() => _USVApp();
}

class _USVApp extends State<USVApp> {
  bool _isDark = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'USV App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: MainHome(
        isDark: _isDark,
        onThemeToggle: () {
          setState(() {
            _isDark = !_isDark;
          });
        },
      ),
    );
  }
}

class MainHome extends StatefulWidget {
  final bool isDark;
  final VoidCallback onThemeToggle;
  const MainHome({
    super.key,
    required this.isDark,
    required this.onThemeToggle,
  });
  @override
  State<MainHome> createState() => _MainHome();
}

class _MainHome extends State<MainHome> {
  String selectedPage = "Dashboard";
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget body;
    switch (selectedPage) {
      case "Mission":
        body = const MissionPage();
        break;
      case "Dashboard":
        body = const DashboardPage();
        break;
      case "Stream":
        body = const StreamPage();
        break;
      default:
        body = const OverviewPage();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("USV - $selectedPage"),
        actions: [
          IconButton(
            onPressed: widget.onThemeToggle,
            icon: Icon(widget.isDark ? Icons.dark_mode : Icons.light_mode),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                "USV Menu",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              title: const Text("Overview"),
              onTap: () {
                setState(() {
                  selectedPage = "Overview";
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: const Text("Mission"),
              onTap: () {
                setState(() {
                  selectedPage = "Mission";
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: const Text("Dashboard"),
              onTap: () {
                setState(() {
                  selectedPage = "Dashboard";
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: const Text("Stream"),
              onTap: () {
                setState(() {
                  selectedPage = "Stream";
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          _currentIndex = value;
          print(_currentIndex);
          selectedPage = (_currentIndex == 0) ? "Home" : "Setting";
          print(selectedPage);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
        ],
      ),
    );
  }
}
