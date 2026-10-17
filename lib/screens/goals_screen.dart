
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  final List<Map<String, dynamic>> _goals = [
    {'title': 'পাঁচ ওয়াক্ত নামাজ', 'subtitle': 'সময়মতো নামাজ আদায়', 'icon': Icons.mosque, 'target': 5},
    {'title': 'কুরআন তিলাওয়াত', 'subtitle': 'প্রতিদিন তিলাওয়াত করুন', 'icon': Icons.menu_book, 'target': 1},
    {'title': 'সকালের যিকির', 'subtitle': 'সকালের যিকির সম্পন্ন', 'icon': Icons.wb_sunny_outlined, 'target': 1},
    {'title': 'সন্ধ্যার যিকির', 'subtitle': 'সন্ধ্যার যিকির সম্পন্ন', 'icon': Icons.nights_stay_outlined, 'target': 1},
    {'title': 'ইস্তিগফার', 'subtitle': 'ইস্তিগফার পাঠ করুন', 'icon': Icons.favorite_outline, 'target': 100},
    {'title': 'দরুদ শরিফ', 'subtitle': 'দরুদ পাঠ করুন', 'icon': Icons.volunteer_activism_outlined, 'target': 100},
    {'title': 'দান-সদকা', 'subtitle': 'সামর্থ্য অনুযায়ী সদকা', 'icon': Icons.card_giftcard, 'target': 1},
  ];

  Map<String, int> _progress = {};
  bool _loading = true;

  String get _today {
    final now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }

  String get _storageKey => 'islamic_goals_$_today';

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(_storageKey) ?? [];

    final progress = <String, int>{};
    for (final item in saved) {
      final parts = item.split('|');
      if (parts.length == 2) {
        progress[parts[0]] = int.tryParse(parts[1]) ?? 0;
      }
    }

    if (!mounted) return;
    setState(() {
      _progress = progress;
      _loading = false;
    });
  }

  Future<void> _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = _progress.entries
        .map((entry) => '${entry.key}|${entry.value}')
        .toList();
    await prefs.setStringList(_storageKey, saved);
  }

  Future<void> _changeProgress(
    String title,
    int change,
    int target,
  ) async {
    final current = _progress[title] ?? 0;
    final next = (current + change).clamp(0, target);

    setState(() {
      _progress[title] = next;
    });

    await _saveProgress();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final completed = _goals.where((goal) {
      return (_progress[goal['title']] ?? 0) >= goal['target'];
    }).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('দৈনিক ইসলামিক লক্ষ্য'),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        colors.primary,
                        colors.primary.withValues(alpha: 0.75),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'আজকের অগ্রগতি',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '$completed / ${_goals.length} লক্ষ্য সম্পন্ন',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: completed / _goals.length,
                          minHeight: 9,
                          backgroundColor: Colors.white24,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'নিয়মিত আমল করার অভ্যাস গড়ে তুলুন',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ..._goals.map((goal) {
                  final title = goal['title'] as String;
                  final target = goal['target'] as int;
                  final current = _progress[title] ?? 0;
                  final done = current >= target;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    colors.primary.withValues(alpha: 0.12),
                                child: Icon(
                                  goal['icon'] as IconData,
                                  color: colors.primary,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(goal['subtitle'] as String),
                                  ],
                                ),
                              ),
                              if (done)
                                Icon(
                                  Icons.check_circle,
                                  color: colors.primary,
                                ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Text('$current / $target'),
                              const Spacer(),
                              IconButton(
                                tooltip: 'এক কমান',
                                onPressed: current == 0
                                    ? null
                                    : () => _changeProgress(
                                          title,
                                          -1,
                                          target,
                                        ),
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                ),
                              ),
                              IconButton.filled(
                                tooltip: 'এক বাড়ান',
                                onPressed: done
                                    ? null
                                    : () => _changeProgress(
                                          title,
                                          1,
                                          target,
                                        ),
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                          LinearProgressIndicator(
                            value: current / target,
                            minHeight: 5,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 8),
                Text(
                  'আপনার অগ্রগতি এই ফোনে সংরক্ষিত থাকবে। নতুন দিনে আজকের লক্ষ্যগুলোর গণনা আবার শুরু হবে।',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
    );
  }
}
