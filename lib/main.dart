import 'package:flutter/material.dart';

void main() {
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
        scaffoldBackgroundColor: const Color(0xFFFFFCF5),
        fontFamily: 'sans',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF155B4A),
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
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    GoalsScreen(),
    BookmarksScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFE4F0EA),
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
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
            label: 'লক্ষ্যগুলো',
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

// ============================================================
// HOME SCREEN
// ============================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'হোম',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF202020),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF5E3),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 19,
                        color: Color(0xFF333333),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Narayanganj',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Quick Access title
            const Text(
              'দ্রুত অ্যাক্সেস',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
              ),
            ),

            const SizedBox(height: 12),

            // Prayer Timeline
            const PrayerTimeline(),

            const SizedBox(height: 18),

            // Three information cards
            Row(
              children: const [
                Expanded(
                  child: InfoCard(
                    icon: Icons.wb_sunny_outlined,
                    title: 'সাহরির শেষ সময়',
                    value: '০৪:০৮ AM',
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: InfoCard(
                    icon: Icons.restaurant_outlined,
                    title: 'ইফতার',
                    value: '০৫:৪০ PM',
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: InfoCard(
                    icon: Icons.nightlight_outlined,
                    title: 'তাহাজ্জুদ',
                    value: '১২:৫৯ AM',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Qibla Card
            const QiblaCard(),

            const SizedBox(height: 20),

            // Forbidden prayer times
            const ForbiddenPrayerCard(),

            const SizedBox(height: 20),

            // Explore section
            const Text(
              'ঘুরে দেখুন',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF444444),
              ),
            ),

            const SizedBox(height: 12),

            const ExploreGrid(),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// PRAYER TIMELINE
// ============================================================

class PrayerTimeline extends StatelessWidget {
  const PrayerTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final prayers = [
      ['ফজর', '০৮:০৬'],
      ['যোহর', '১১:৪৮'],
      ['আসর', '০৩:১০'],
      ['মাগরিব', '০৫:৪০'],
      ['ইশা', '০৬:৫৮'],
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 22, 12, 22),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF6E5),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Row(
            children: List.generate(
              prayers.length,
              (index) {
                return Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 29,
                        height: 29,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFFFE8BD),
                          border: Border.all(
                            color: const Color(0xFFFFE0AA),
                          ),
                        ),
                      ),
                      if (index != prayers.length - 1)
                        Expanded(
                          child: Container(
                            height: 2,
                            color: const Color(0xFFF1DEB6),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: prayers.map((prayer) {
              return Expanded(
                child: Column(
                  children: [
                    Text(
                      prayer[0],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF383838),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      prayer[1],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF222222),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// INFO CARD
// ============================================================

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF6E5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 27,
            color: const Color(0xFF293838),
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF555555),
            ),
          ),
          const SizedBox(height: 7),
          FittedBox(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF222222),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// QIBLA CARD
// ============================================================

class QiblaCard extends StatelessWidget {
  const QiblaCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF6E5),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(
                  Icons.explore_outlined,
                  size: 31,
                  color: Color(0xFF263838),
                ),
                Spacer(),
                Text(
                  'কিবলা',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF555555),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'বামে ২৭° ঘুরুন',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF222222),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 170,
            height: 170,
            child: CustomPaint(
              painter: QiblaPainter(),
            ),
          ),
        ],
      ),
    );
  }
}

class QiblaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 15;

    final linePaint = Paint()
      ..color = const Color(0xFFEBDDBE)
      ..strokeWidth = 2;

    for (int i = 0; i < 40; i++) {
      final angle = (i * 3.14159 * 2) / 40;

      final start = Offset(
        center.dx + (radius - 8) * cosValue(angle),
        center.dy + (radius - 8) * sinValue(angle),
      );

      final end = Offset(
        center.dx + radius * cosValue(angle),
        center.dy + radius * sinValue(angle),
      );

      canvas.drawLine(start, end, linePaint);
    }

    final circlePaint = Paint()
      ..color = const Color(0xFF164F45)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(center.dx, center.dy - 55),
      23,
      circlePaint,
    );

    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(center.dx, center.dy - 55),
      8,
      whitePaint,
    );

    final needlePaint = Paint()
      ..color = const Color(0xFF111111)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(center.dx, center.dy - 10),
      Offset(center.dx, center.dy + 38),
      needlePaint,
    );

    canvas.drawCircle(
      Offset(center.dx, center.dy + 38),
      11,
      Paint()
        ..color = const Color(0xFF111111)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4,
    );
  }

  double cosValue(double angle) {
    return _cos(angle);
  }

  double sinValue(double angle) {
    return _sin(angle);
  }

  double _cos(double x) {
    double result = 1;
    double term = 1;

    for (int i = 1; i <= 8; i++) {
      term *= -x * x / ((2 * i - 1) * (2 * i));
      result += term;
    }

    return result;
  }

  double _sin(double x) {
    double result = x;
    double term = x;

    for (int i = 1; i <= 8; i++) {
      term *= -x * x / ((2 * i) * (2 * i + 1));
      result += term;
    }

    return result;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// ============================================================
// FORBIDDEN PRAYER TIME
// ============================================================

class ForbiddenPrayerCard extends StatelessWidget {
  const ForbiddenPrayerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF6E5),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'সালাতের নিষিদ্ধ সময়',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF555555),
                ),
              ),
              Icon(
                Icons.info_outline,
                size: 22,
              ),
            ],
          ),
          const SizedBox(height: 12),
          ForbiddenTimeRow(
            icon: Icons.wb_sunny_outlined,
            title: 'সূর্যোদয়',
            start: '০৫:৫১ AM',
            end: '০৬:০৬ AM',
          ),
          const SizedBox(height: 8),
          ForbiddenTimeRow(
            icon: Icons.wb_sunny,
            title: 'দুপুর',
            start: '১১:৪০ AM',
            end: '১১:৪৮ AM',
          ),
          const SizedBox(height: 8),
          ForbiddenTimeRow(
            icon: Icons.wb_twilight,
            title: 'সূর্যাস্ত',
            start: '০৫:২৮ PM',
            end: '০৫:৪০ PM',
          ),
        ],
      ),
    );
  }
}

class ForbiddenTimeRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String start;
  final String end;

  const ForbiddenTimeRow({
    super.key,
    required this.icon,
    required this.title,
    required this.start,
    required this.end,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 83,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE9BD),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: 130,
            height: 83,
            decoration: const BoxDecoration(
              color: Color(0xFFFFDFA8),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
            ),
            child: Center(
              child: Icon(
                icon,
                size: 32,
                color: const Color(0xFF26413D),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF555555),
              ),
            ),
          ),
          Text(
            start,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 7),
            width: 25,
            height: 1,
            color: const Color(0xFFD8C59F),
          ),
          Text(
            end,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// EXPLORE GRID
// ============================================================

class ExploreGrid extends StatelessWidget {
  const ExploreGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ['কুরআন', Icons.menu_book],
      ['দোয়া ও যিকির', Icons.panorama_photosphere_outlined],
      ['কিবলা', Icons.crop_square],
      ['মসজিদ', Icons.mosque_outlined],
      ['ক্যালেন্ডার', Icons.calendar_month_outlined],
      ['আল্লাহর নামসমূহ', Icons.auto_awesome],
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.65,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF6E5),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    items[index][0] as String,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),
                Icon(
                  items[index][1] as IconData,
                  size: 42,
                  color: const Color(0xFF30574E),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ============================================================
// GOALS SCREEN
// ============================================================

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimplePage(
      title: 'লক্ষ্যগুলো',
      icon: Icons.check_circle_outline,
      message: 'আপনার দৈনিক ইবাদতের লক্ষ্য এখানে থাকবে।',
    );
  }
}

// ============================================================
// BOOKMARK SCREEN
// ============================================================

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimplePage(
      title: 'বুকমার্ক',
      icon: Icons.bookmark_border,
      message: 'সংরক্ষিত আয়াত, দোয়া ও অন্যান্য বিষয় এখানে থাকবে।',
    );
  }
}

// ============================================================
// SETTINGS SCREEN
// ============================================================

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimplePage(
      title: 'সেটিংস',
      icon: Icons.settings_outlined,
      message: 'ভাষা, থিম, নামাজের হিসাব ও অন্যান্য সেটিংস এখানে থাকবে।',
    );
  }
}

// ============================================================
// SIMPLE PAGE
// ============================================================

class SimplePage extends StatelessWidget {
  final String title;
  final IconData icon;
  final String message;

  const SimplePage({
    super.key,
    required this.title,
    required this.icon,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 35),
            Center(
              child: Icon(
                icon,
                size: 80,
                color: const Color(0xFF155B4A),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF666666),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
