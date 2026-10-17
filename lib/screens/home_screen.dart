
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../main.dart';
import '../services/prayer_service.dart';

import 'quran_screen.dart';
import 'dua_screen.dart';
import 'qibla_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PrayerService _service = PrayerService.instance;

  PrayerSchedule? _schedule;
  String? _error;
  bool _loading = false;
  DateTime _now = DateTime.now();
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _now = DateTime.now());
    });

    _loadSchedule();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _loadSchedule() async {
    if (_loading) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final result = await _service.loadSchedule();

      if (!mounted) return;

      setState(() {
        _schedule = result;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _error = e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  String _bn(String value) {
    const en = '0123456789';
    const bn = '০১২৩৪৫৬৭৮৯';

    for (var i = 0; i < 10; i++) {
      value = value.replaceAll(en[i], bn[i]);
    }

    return value;
  }

  String _formatTime(DateTime time) {
    final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final suffix = time.hour < 12 ? 'AM' : 'PM';

    return '${_bn(hour.toString())}:${_bn(minute)} $suffix';
  }

  String _formatDate(DateTime date) {
    const weekdays = [
      'সোমবার',
      'মঙ্গলবার',
      'বুধবার',
      'বৃহস্পতিবার',
      'শুক্রবার',
      'শনিবার',
      'রবিবার',
    ];

    const months = [
      'জানুয়ারি',
      'ফেব্রুয়ারি',
      'মার্চ',
      'এপ্রিল',
      'মে',
      'জুন',
      'জুলাই',
      'আগস্ট',
      'সেপ্টেম্বর',
      'অক্টোবর',
      'নভেম্বর',
      'ডিসেম্বর',
    ];

    return '${weekdays[date.weekday - 1]}, '
        '${_bn(date.day.toString())} '
        '${months[date.month - 1]} '
        '${_bn(date.year.toString())}';
  }

  PrayerTimeItem? get _nextPrayer {
    final schedule = _schedule;
    if (schedule == null) return null;

    for (final prayer in schedule.prayers) {
      if (prayer.name == 'সূর্যোদয়') continue;

      if (prayer.time.isAfter(_now)) {
        return prayer;
      }
    }

    return PrayerTimeItem(
      name: 'ফজর',
      time: schedule.tomorrowFajr,
    );
  }

  String get _countdown {
    final prayer = _nextPrayer;
    if (prayer == null) return '--:--:--';

    final difference = prayer.time.difference(_now);

    if (difference.isNegative) return '--:--:--';

    final hours = difference.inHours.toString().padLeft(2, '0');
    final minutes = (difference.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (difference.inSeconds % 60).toString().padLeft(2, '0');

    return _bn('$hours:$minutes:$seconds');
  }

  @override
  Widget build(BuildContext context) {
    final schedule = _schedule;
    final next = _nextPrayer;

    return SafeArea(
      child: RefreshIndicator(
        color: appGreen,
        onRefresh: _loadSchedule,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
          children: [
            Row(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: appGreen,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.mosque,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Islamic Companion',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: appGreen,
                        ),
                      ),
                      Text(
                        'আপনার দৈনন্দিন ইসলামিক সঙ্গী',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: _loadSchedule,
                  tooltip: 'সময় আপডেট করুন',
                  icon: const Icon(Icons.refresh, color: appGreen),
                ),
              ],
            ),

            const SizedBox(height: 22),

            Text(
              _formatDate(_now),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 14),

            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF155B4A), Color(0xFF23745D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(26),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.white70,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'পরবর্তী নামাজ',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    next?.name ?? 'নামাজের সময়',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    next == null ? '--:--' : _formatTime(next.time),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'নামাজের সময় বাকি',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _countdown,
                    style: const TextStyle(
                      color: Color(0xFFFFE0A0),
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'আজকের নামাজের সময়',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: appGreen,
                  ),
                ),
                if (schedule != null)
                  const Icon(Icons.location_on_outlined, color: appGreen),
              ],
            ),

            if (schedule != null) ...[
              const SizedBox(height: 4),
              Text(
                'অবস্থান: ${schedule.latitude.toStringAsFixed(3)}, '
                '${schedule.longitude.toStringAsFixed(3)}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],

            const SizedBox(height: 12),

            if (_loading && schedule == null)
              const Padding(
                padding: EdgeInsets.all(28),
                child: Center(
                  child: CircularProgressIndicator(color: appGreen),
                ),
              ),

            if (_error != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE8E5),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.location_off_outlined,
                      size: 34,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(height: 8),
                    Text(_error!, textAlign: TextAlign.center),
                    const SizedBox(height: 10),
                    FilledButton.icon(
                      onPressed: _loadSchedule,
                      icon: const Icon(Icons.refresh),
                      label: const Text('আবার চেষ্টা করুন'),
                    ),
                    TextButton(
                      onPressed: Geolocator.openLocationSettings,
                      child: const Text('Location Settings'),
                    ),
                  ],
                ),
              ),

            if (schedule != null)
              ...schedule.prayers.map((prayer) {
                final isNext = next?.name == prayer.name &&
                    next?.time == prayer.time;

                return Container(
                  margin: const EdgeInsets.only(bottom: 9),
                  decoration: BoxDecoration(
                    color: isNext
                        ? const Color(0xFFE0EFE6)
                        : const Color(0xFFFFF4DF),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isNext ? appGreen : Colors.white,
                      child: Icon(
                        prayer.name == 'সূর্যোদয়'
                            ? Icons.wb_sunny_outlined
                            : Icons.access_time,
                        color: isNext ? Colors.white : appGreen,
                      ),
                    ),
                    title: Text(
                      prayer.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: Text(
                      _formatTime(prayer.time),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                );
              }),

            const SizedBox(height: 18),

            const Text(
              'ইসলামিক ফিচার',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: appGreen,
              ),
            ),

            const SizedBox(height: 12),

            
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.55,
              children: [
                _FeatureCard(
                  title: 'পবিত্র কোরআন',
                  subtitle: 'আয়াত ও অনুবাদ',
                  icon: Icons.menu_book,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const QuranScreen(),
                      ),
                    );
                  },
                ),
                _FeatureCard(
                  title: 'দোয়া ও যিকির',
                  subtitle: 'দৈনন্দিন আমল',
                  icon: Icons.favorite_outline,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DuaScreen(),
                      ),
                    );
                  },
                ),
                _FeatureCard(
                  title: 'কিবলা',
                  subtitle: 'কাবার দিক',
                  icon: Icons.explore_outlined,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const QiblaScreen(),
                      ),
                    );
                  },
                ),
                _FeatureCard(
                  title: 'মসজিদ',
                  subtitle: 'কাছের মসজিদ',
                  icon: Icons.mosque,
                  onTap: () => _showComingSoon(context, 'মসজিদ'),
                ),
                _FeatureCard(
                  title: 'ইসলামিক ক্যালেন্ডার',
                  subtitle: 'হিজরি তারিখ',
                  icon: Icons.calendar_month,
                  onTap: () => _showComingSoon(context, 'ইসলামিক ক্যালেন্ডার'),
                ),
                _FeatureCard(
                  title: 'আল্লাহর নাম',
                  subtitle: 'আসমাউল হুসনা',
                  icon: Icons.auto_awesome,
                  onTap: () => _showComingSoon(context, 'আল্লাহর নাম'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


void _showComingSoon(BuildContext context, String feature) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('$feature ফিচারটি শিগগিরই যুক্ত করা হবে।'),
    ),
  );
}

class _FeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  const _FeatureCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: appGreen, size: 30),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
