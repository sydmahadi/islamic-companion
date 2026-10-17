
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DuaScreen extends StatefulWidget {
  const DuaScreen({super.key});

  @override
  State<DuaScreen> createState() => _DuaScreenState();
}

class _DuaScreenState extends State<DuaScreen> {
  String _selectedCategory = 'সব';

  final List<Map<String, String>> _duas = [
    {
      'category': 'সকাল-সন্ধ্যা',
      'title': 'সকালের যিকির',
      'arabic': 'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ',
      'pronunciation': 'আসবাহনা ওয়া আসবাহাল মুলকু লিল্লাহ',
      'meaning': 'আমরা সকালে উপনীত হয়েছি এবং সমস্ত রাজত্ব আল্লাহর।',
      'reference': 'সহিহ মুসলিম ২৭২৩',
    },
    {
      'category': 'সকাল-সন্ধ্যা',
      'title': 'সন্ধ্যার যিকির',
      'arabic': 'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ',
      'pronunciation': 'আমসাইনা ওয়া আমসাল মুলকু লিল্লাহ',
      'meaning': 'আমরা সন্ধ্যায় উপনীত হয়েছি এবং সমস্ত রাজত্ব আল্লাহর।',
      'reference': 'সকাল-সন্ধ্যার যিকির',
    },
    {
      'category': 'ঘুম',
      'title': 'ঘুমানোর দোয়া',
      'arabic': 'بِاسْمِكَ اللَّهُمَّ أَمُوتُ وَأَحْيَا',
      'pronunciation': 'বিসমিকা আল্লাহুম্মা আমুতু ওয়া আহইয়া',
      'meaning': 'হে আল্লাহ! আপনার নামেই আমি মরি এবং জীবিত হই।',
      'reference': 'সহিহ বুখারি ৬৩২৪',
    },
    {
      'category': 'ঘুম',
      'title': 'ঘুম থেকে ওঠার দোয়া',
      'arabic': 'الْحَمْدُ لِلَّهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ النُّشُورُ',
      'pronunciation': 'আলহামদু লিল্লাহিল্লাযি আহইয়ানা বা‘দা মা আমাতানা ওয়া ইলাইহিন নুশুর',
      'meaning': 'সমস্ত প্রশংসা আল্লাহর, যিনি আমাদের মৃত্যুর মতো ঘুমের পর জীবিত করেছেন; তাঁর কাছেই পুনরুত্থান।',
      'reference': 'সহিহ বুখারি ৬৩২৪',
    },
    {
      'category': 'খাবার',
      'title': 'খাওয়ার আগে',
      'arabic': 'بِسْمِ اللَّهِ',
      'pronunciation': 'বিসমিল্লাহ',
      'meaning': 'আল্লাহর নামে শুরু করছি।',
      'reference': 'সুনান আবু দাউদ ৩৭৬৭',
    },
    {
      'category': 'খাবার',
      'title': 'খাওয়ার পরে',
      'arabic': 'الْحَمْدُ لِلَّهِ',
      'pronunciation': 'আলহামদুলিল্লাহ',
      'meaning': 'সমস্ত প্রশংসা আল্লাহর।',
      'reference': 'সহিহ মুসলিম ২৭৩৪',
    },
    {
      'category': 'বাড়ি',
      'title': 'বাড়িতে প্রবেশ',
      'arabic': 'بِسْمِ اللَّهِ وَلَجْنَا وَبِسْمِ اللَّهِ خَرَجْنَا وَعَلَى اللَّهِ رَبِّنَا تَوَكَّلْنَا',
      'pronunciation': 'বিসমিল্লাহি ওয়ালাজনা, ওয়া বিসমিল্লাহি খারাজনা, ওয়া আলাল্লাহি রব্বিনা তাওয়াক্কালনা',
      'meaning': 'আল্লাহর নামে আমরা প্রবেশ করি, আল্লাহর নামেই বের হই এবং আমাদের রব আল্লাহর ওপরই ভরসা করি।',
      'reference': 'সুনান আবু দাউদ ৫০৯৬',
    },
    {
      'category': 'বাড়ি',
      'title': 'বাড়ি থেকে বের হওয়া',
      'arabic': 'بِسْمِ اللَّهِ تَوَكَّلْتُ عَلَى اللَّهِ وَلَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ',
      'pronunciation': 'বিসমিল্লাহি তাওয়াক্কালতু আলাল্লাহি, ওয়া লা হাওলা ওয়া লা কুওয়াতা ইল্লা বিল্লাহ',
      'meaning': 'আল্লাহর নামে বের হচ্ছি। আল্লাহর ওপর ভরসা করলাম। আল্লাহর সাহায্য ছাড়া কোনো শক্তি বা সামর্থ্য নেই।',
      'reference': 'সুনান আবু দাউদ ৫০৯৫',
    },
    {
      'category': 'ক্ষমা',
      'title': 'ক্ষমা প্রার্থনা',
      'arabic': 'أَسْتَغْفِرُ اللَّهَ',
      'pronunciation': 'আস্তাগফিরুল্লাহ',
      'meaning': 'আমি আল্লাহর কাছে ক্ষমা প্রার্থনা করছি।',
      'reference': 'সহিহ মুসলিম ৫৯১',
    },
    {
      'category': 'ক্ষমা',
      'title': 'সাইয়্যিদুল ইস্তিগফার',
      'arabic': 'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ',
      'pronunciation': 'আল্লাহুম্মা আনতা রব্বি, লা ইলাহা ইল্লা আনতা',
      'meaning': 'হে আল্লাহ! আপনি আমার রব। আপনি ছাড়া কোনো সত্য উপাস্য নেই।',
      'reference': 'সহিহ বুখারি ৬৩০৬ — দোয়াটির পূর্ণ পাঠ আরও দীর্ঘ',
    },
    {
      'category': 'বিপদ',
      'title': 'বিপদের সময়',
      'arabic': 'حَسْبُنَا اللَّهُ وَنِعْمَ الْوَكِيلُ',
      'pronunciation': 'হাসবুনাল্লাহু ওয়া নি‘মাল ওয়াকিল',
      'meaning': 'আমাদের জন্য আল্লাহই যথেষ্ট, আর তিনি কতই না উত্তম কর্মবিধায়ক।',
      'reference': 'কুরআন ৩:১৭৩',
    },
    {
      'category': 'সাধারণ',
      'title': 'দুনিয়া ও আখিরাতের কল্যাণ',
      'arabic': 'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ',
      'pronunciation': 'রব্বানা আতিনা ফিদ্দুনইয়া হাসানাতাও ওয়া ফিল আখিরাতি হাসানাতাও ওয়া কিনা আযাবান নার',
      'meaning': 'হে আমাদের রব! আমাদের দুনিয়াতে কল্যাণ দিন, আখিরাতেও কল্যাণ দিন এবং আগুনের শাস্তি থেকে রক্ষা করুন।',
      'reference': 'কুরআন ২:২০১',
    },
    {
      'category': 'সাধারণ',
      'title': 'জ্ঞান বৃদ্ধির দোয়া',
      'arabic': 'رَبِّ زِدْنِي عِلْمًا',
      'pronunciation': 'রব্বি যিদনি ইলমা',
      'meaning': 'হে আমার রব! আমার জ্ঞান বৃদ্ধি করে দিন।',
      'reference': 'কুরআন ২০:১১৪',
    },
  ];

  final Set<String> _favorites = {};

  List<String> get _categories => [
        'সব',
        ..._duas.map((dua) => dua['category']!).toSet(),
        'পছন্দের',
      ];

  List<Map<String, String>> get _filteredDuas {
    if (_selectedCategory == 'সব') return _duas;
    if (_selectedCategory == 'পছন্দের') {
      return _duas
          .where((dua) => _favorites.contains(dua['title']))
          .toList();
    }
    return _duas
        .where((dua) => dua['category'] == _selectedCategory)
        .toList();
  }

  void _copyDua(Map<String, String> dua) {
    final text = '${dua['title']}\n${dua['arabic']}\n'
        '${dua['pronunciation']}\n${dua['meaning']}\n'
        'সূত্র: ${dua['reference']}';

    Clipboard.setData(ClipboardData(text: text));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('দোয়ার লেখা কপি হয়েছে')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('দোয়া ও যিকির'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 58,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              children: _categories.map((category) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: _selectedCategory == category,
                    onSelected: (_) {
                      setState(() => _selectedCategory = category);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: _filteredDuas.isEmpty
                ? const Center(child: Text('এখানে এখনো কোনো দোয়া নেই'))
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _filteredDuas.length,
                    itemBuilder: (context, index) {
                      final dua = _filteredDuas[index];
                      final title = dua['title']!;
                      final favorite = _favorites.contains(title);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        clipBehavior: Clip.antiAlias,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  IconButton(
                                    tooltip: favorite
                                        ? 'পছন্দ থেকে সরান'
                                        : 'পছন্দে রাখুন',
                                    onPressed: () {
                                      setState(() {
                                        if (favorite) {
                                          _favorites.remove(title);
                                        } else {
                                          _favorites.add(title);
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      favorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: favorite ? Colors.red : null,
                                    ),
                                  ),
                                  IconButton(
                                    tooltip: 'কপি করুন',
                                    onPressed: () => _copyDua(dua),
                                    icon: const Icon(Icons.copy),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                  dua['arabic']!,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    fontSize: 26,
                                    height: 1.9,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'উচ্চারণ',
                                style: TextStyle(
                                  color: colors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                dua['pronunciation']!,
                                style: const TextStyle(
                                  fontSize: 15,
                                  height: 1.6,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'অর্থ',
                                style: TextStyle(
                                  color: colors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                dua['meaning']!,
                                style: const TextStyle(
                                  fontSize: 15,
                                  height: 1.7,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colors.primary.withValues(
                                      alpha: 0.10,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'সূত্র: ${dua['reference']}',
                                    style: TextStyle(
                                      color: colors.primary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
