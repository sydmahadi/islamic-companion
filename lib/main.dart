
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/goals_screen.dart';
import 'screens/bookmarks_screen.dart';
import 'screens/settings_screen.dart';

const Color appGreen = Color(0xFF155B4A);
const Color appCream = Color(0xFFFFFCF5);
const Color appGold = Color(0xFFC9A45C);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const IslamicCompanionApp());
}

class IslamicCompanionApp extends StatefulWidget {
  const IslamicCompanionApp({super.key});

  @override
  State<IslamicCompanionApp> createState() =>
      _IslamicCompanionAppState();
}

class _IslamicCompanionAppState extends State<IslamicCompanionApp> {
  bool isDarkMode = false;
  String language = 'bn';

  void changeTheme(bool value) {
    setState(() => isDarkMode = value);
  }

  void changeLanguage(String value) {
    setState(() => language = value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Islamic Companion',
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: appCream,
        colorScheme: ColorScheme.fromSeed(
          seedColor: appGreen,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: appCream,
          foregroundColor: appGreen,
          centerTitle: false,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: appGreen,
          brightness: Brightness.dark,
        ),
      ),
      home: MainNavigation(
        isDarkMode: isDarkMode,
        onThemeChanged: changeTheme,
        language: language,
        onLanguageChanged: changeLanguage,
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final String language;
  final ValueChanged<String> onLanguageChanged;

  const MainNavigation({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.language,
    required this.onLanguageChanged,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isBangla = widget.language == 'bn';

    final pages = [
      const HomeScreen(),
      const GoalsScreen(),
      const BookmarksScreen(),
      SettingsScreen(
        isDarkMode: widget.isDarkMode,
        onThemeChanged: widget.onThemeChanged,
        language: widget.language,
        onLanguageChanged: widget.onLanguageChanged,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        backgroundColor: Theme.of(context).colorScheme.surface,
        indicatorColor: Theme.of(context).colorScheme.primaryContainer,
        onDestinationSelected: (index) {
          setState(() => selectedIndex = index);
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: isBangla ? 'হোম' : 'Home',
          ),
          NavigationDestination(
            icon: const Icon(Icons.check_circle_outline),
            selectedIcon: const Icon(Icons.check_circle),
            label: isBangla ? 'লক্ষ্য' : 'Goals',
          ),
          NavigationDestination(
            icon: const Icon(Icons.bookmark_border),
            selectedIcon: const Icon(Icons.bookmark),
            label: isBangla ? 'বুকমার্ক' : 'Bookmarks',
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: isBangla ? 'সেটিংস' : 'Settings',
          ),
        ],
      ),
    );
  }
}
