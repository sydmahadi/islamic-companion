
import 'dart:async';

import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const IslamicCompanionApp());
}

const green = Color(0xFF155B4A);
const cream = Color(0xFFFFFCF5);
const cardColor = Color(0xFFFFF4DF);

class IslamicCompanionApp extends StatelessWidget {
  const IslamicCompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Islamic Companion',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: cream,
        colorScheme: ColorScheme.fromSeed(seedColor: green),
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
  int index = 0;

  final pages = const [
    HomeScreen(),
    SimplePage(
      title: 'লক্ষ্যগুলো',
      icon: Icons.check_circle_outline,
      message: 'দৈনিক ইবাদতের লক্ষ্য পরবর্তী ধাপে যোগ করা হবে।',
    ),
    SimplePage(
      title: 'বুকমার্ক',
      icon: Icons.bookmark_border,
      message: 'সংরক্ষিত আয়াত ও দোয়া এখানে থাকবে।',
    ),
    SimplePage(
      title: 'সেটিংস',
      icon: Icons.settings_outlined,
      message: 'ভাষা, থিম ও নামাজের হিসাবের সেটিংস পরবর্তী ধাপে আসবে।',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFE4F0EA),
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'হোম',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_circle_outline),
            label: 'লক্ষ্যগুলো',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border),
            label: 'বুকমার্ক',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: 'সেটিংস',
          ),
        ],
      ),
    );
  }
}

class _PrayerItem {
  final String name;
  final DateTime time;

  const _PrayerItem(this.name, this.time);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position? position;
  List<_PrayerItem> prayers = [];
  DateTime? nextPrayerTime;
  String nextPrayerName = '';
  String locationText = 'লোকেশন নেওয়া হচ্ছে...';
  String? error;
  bool loading = false;
  DateTime now = DateTime.now();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => now = DateTime.now());
      if (prayers.isNotEmpty) _updateNextPrayer();
    });
    _loadPrayerTimes();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // Bangladesh local time = UTC + 6 hours.
  // adhan_dart prayer-time results are converted from UTC here.
 DateTime _toBangladeshTime(DateTime time) {
  final utcTime = time.toUtc();

  return DateTime(
    utcTime.year,
    utcTime.month,
    utcTime.day,
    utcTime.hour + 6,
    utcTime.minute,
    utcTime.second,
  );
}

  PrayerTimes _calculateFor(DateTime date) {
    final coordinates = Coordinates(
      position!.latitude,
      position!.longitude,
    );

    final params = CalculationMethodParameters.karachi()
      ..madhab = Madhab.hanafi;

    return PrayerTimes(
      coordinates: coordinates,
      date: DateTime(date.year, date.month, date.day),
      calculationParameters: params,
    );
  }

  Future<void> _loadPrayerTimes() async {
    if (loading) return;

    setState(() {
      loading = true;
      error = null;
    });

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('ফোনের Location/GPS চালু করুন।');
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        throw Exception('নামাজের সময় হিসাব করতে Location অনুমতি দিন।');
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
          'Location অনুমতি স্থায়ীভাবে বন্ধ। ফোনের App Settings থেকে অনুমতি দিন।',
        );
      }

      final currentPosition = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      position = currentPosition;
      final times = _calculateFor(DateTime.now());

      prayers = [
        _PrayerItem('ফজর', _toBangladeshTime(times.fajr)),
        _PrayerItem('যোহর', _toBangladeshTime(times.dhuhr)),
        _PrayerItem('আসর', _toBangladeshTime(times.asr)),
        _PrayerItem('মাগরিব', _toBangladeshTime(times.maghrib)),
        _PrayerItem('ইশা', _toBangladeshTime(times.isha)),
      ];

      locationText =
          '${currentPosition.latitude.toStringAsFixed(3)}, '
          '${currentPosition.longitude.toStringAsFixed(3)}';

      _updateNextPrayer();
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  void _updateNextPrayer() {
    if (prayers.isEmpty || position == null) return;

    for (final prayer in prayers) {
      if (prayer.time.isAfter(now)) {
        nextPrayerName = prayer.name;
        nextPrayerTime = prayer.time;
        return;
      }
    }

    // If today's last prayer has passed, use tomorrow's Fajr.
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final tomorrowTimes = _calculateFor(tomorrow);
    nextPrayerName = 'ফজর';
    nextPrayerTime = _toBangladeshTime(tomorrowTimes.fajr);
  }

  String _digits(String input) {
    const english = '0123456789';
    const bangla = '০১২৩৪৫৬৭৮৯';
    for (int i = 0; i < 10; i++) {
      input = input.replaceAll(english[i], bangla[i]);
    }
    return input;
  }

  String _formatTime(DateTime time) {
    final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour < 12 ? 'AM' : 'PM';
    return '${_digits(hour.toString())}:'
        '${_digits(minute)} $period';
  }

  String _countdown() {
    if (nextPrayerTime == null) return '--:--:--';

    final difference = nextPrayerTime!.difference(now);
    if (difference.isNegative) return 'সময় হিসাব হচ্ছে...';

    final hours = difference.inHours.toString().padLeft(2, '0');
    final minutes = (difference.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (difference.inSeconds % 60).toString().padLeft(2, '0');

    return _digits('$hours:$minutes:$seconds');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _loadPrayerTimes,
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'ইসলামিক কম্প্যানিয়ন',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                ),
                const Icon(Icons.location_on_outlined, color: green),
                Flexible(
                  child: Text(
                    locationText,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: green,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'পরবর্তী নামাজ',
                    style: TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    nextPrayerName.isEmpty ? 'নামাজের সময়' : nextPrayerName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    nextPrayerTime == null
                        ? 'সময় পাওয়া যায়নি'
                        : _formatTime(nextPrayerTime!),
                    style: const TextStyle(color: Colors.white, fontSize: 19),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'নামাজের সময় বাকি',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _countdown(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),
            const Text(
              'আজকের নামাজের সময়',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            if (loading && prayers.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(color: green),
                ),
              ),

            if (error != null)
              Card(
                color: const Color(0xFFFFE8E5),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(error!, textAlign: TextAlign.center),
                      const SizedBox(height: 10),
                      FilledButton.icon(
                        onPressed: _loadPrayerTimes,
                        icon: const Icon(Icons.refresh),
                        label: const Text('আবার চেষ্টা করুন'),
                      ),
                      TextButton(
                        onPressed: Geolocator.openAppSettings,
                        child: const Text('App Settings খুলুন'),
                      ),
                      TextButton(
                        onPressed: Geolocator.openLocationSettings,
                        child: const Text('Location Settings খুলুন'),
                      ),
                    ],
                  ),
                ),
              ),

            ...prayers.map((prayer) {
              final isNext = prayer.name == nextPrayerName &&
                  prayer.time == nextPrayerTime;

              return Card(
                color: isNext ? const Color(0xFFE1EFE7) : cardColor,
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: Icon(
                    isNext ? Icons.notifications_active : Icons.access_time,
                    color: green,
                  ),
                  title: Text(
                    prayer.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: Text(
                    _formatTime(prayer.time),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 14),
            const Text(
              'ঘুরে দেখুন',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.7,
              children: const [
                _FeatureTile('কুরআন', Icons.menu_book),
                _FeatureTile('দোয়া ও যিকির', Icons.favorite_outline),
                _FeatureTile('কিবলা', Icons.explore_outlined),
                _FeatureTile('মসজিদ', Icons.mosque),
                _FeatureTile('ক্যালেন্ডার', Icons.calendar_month),
                _FeatureTile('আল্লাহর নামসমূহ', Icons.auto_awesome),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final String title;
  final IconData icon;

  const _FeatureTile(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(icon, color: green, size: 28),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

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
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Icon(icon, size: 70, color: green),
              const SizedBox(height: 20),
              Text(message, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
