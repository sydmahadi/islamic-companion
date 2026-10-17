
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

const Color appGreen = Color(0xFF155B4A);
const Color appCream = Color(0xFFFFFCF5);
const Color appGold = Color(0xFFC9A45C);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const IslamicCompanionApp());
}

class IslamicCompanionApp extends StatelessWidget {
  const IslamicCompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Islamic Companion',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: appCream,
        colorScheme: ColorScheme.fromSeed(seedColor: appGreen),
        appBarTheme: const AppBarTheme(
          backgroundColor: appCream,
          foregroundColor: appGreen,
          centerTitle: false,
        ),
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    CompanionPlaceholder(
      title: 'লক্ষ্যগুলো',
      icon: Icons.check_circle_outline,
      description: 'দৈনিক ইবাদতের লক্ষ্য ও অগ্রগতি এখানে যোগ করা হবে।',
    ),
    CompanionPlaceholder(
      title: 'বুকমার্ক',
      icon: Icons.bookmark_border,
      description: 'সংরক্ষিত আয়াত ও দোয়া এখানে পাওয়া যাবে।',
    ),
    CompanionPlaceholder(
      title: 'সেটিংস',
      icon: Icons.settings_outlined,
      description: 'ভাষা, থিম ও নামাজের হিসাব এখানে নিয়ন্ত্রণ করা যাবে।',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFE4F0EA),
        onDestinationSelected: (index) {
          setState(() => selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'হোম',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_circle_outline),
            selectedIcon: Icon(Icons.check_circle),
            label: 'লক্ষ্য',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border),
            selectedIcon: Icon(Icons.bookmark),
            label: 'বুকমার্ক',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'সেটিংস',
          ),
        ],
      ),
    );
  }
}

class CompanionPlaceholder extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;

  const CompanionPlaceholder({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 72, color: appGreen),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: appGreen,
                ),
              ),
              const SizedBox(height: 12),
              Text(description, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
