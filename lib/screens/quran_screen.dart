
import 'package:flutter/material.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  String _search = '';

  final List<Map<String, dynamic>> _surahs = [
    {'number': 1, 'arabic': 'الْفَاتِحَة', 'name': 'Al-Fatihah', 'bn': 'আল-ফাতিহা', 'verses': 7, 'type': 'মাক্কী'},
    {'number': 2, 'arabic': 'الْبَقَرَة', 'name': 'Al-Baqarah', 'bn': 'আল-বাকারা', 'verses': 286, 'type': 'মাদানী'},
    {'number': 3, 'arabic': 'آلِ عِمْرَان', 'name': 'Ali Imran', 'bn': 'আলে ইমরান', 'verses': 200, 'type': 'মাদানী'},
    {'number': 4, 'arabic': 'النِّسَاء', 'name': 'An-Nisa', 'bn': 'আন-নিসা', 'verses': 176, 'type': 'মাদানী'},
    {'number': 5, 'arabic': 'الْمَائِدَة', 'name': 'Al-Maidah', 'bn': 'আল-মায়িদাহ', 'verses': 120, 'type': 'মাদানী'},
    {'number': 6, 'arabic': 'الْأَنْعَام', 'name': 'Al-Anam', 'bn': 'আল-আনআম', 'verses': 165, 'type': 'মাক্কী'},
    {'number': 7, 'arabic': 'الْأَعْرَاف', 'name': 'Al-Araf', 'bn': 'আল-আরাফ', 'verses': 206, 'type': 'মাক্কী'},
    {'number': 8, 'arabic': 'الْأَنْفَال', 'name': 'Al-Anfal', 'bn': 'আল-আনফাল', 'verses': 75, 'type': 'মাদানী'},
    {'number': 9, 'arabic': 'التَّوْبَة', 'name': 'At-Tawbah', 'bn': 'আত-তাওবাহ', 'verses': 129, 'type': 'মাদানী'},
    {'number': 10, 'arabic': 'يُونُس', 'name': 'Yunus', 'bn': 'ইউনুস', 'verses': 109, 'type': 'মাক্কী'},
    {'number': 11, 'arabic': 'هُود', 'name': 'Hud', 'bn': 'হুদ', 'verses': 123, 'type': 'মাক্কী'},
    {'number': 12, 'arabic': 'يُوسُف', 'name': 'Yusuf', 'bn': 'ইউসুফ', 'verses': 111, 'type': 'মাক্কী'},
    {'number': 13, 'arabic': 'الرَّعْد', 'name': 'Ar-Rad', 'bn': 'আর-রাদ', 'verses': 43, 'type': 'মাদানী'},
    {'number': 14, 'arabic': 'إِبْرَاهِيم', 'name': 'Ibrahim', 'bn': 'ইবরাহিম', 'verses': 52, 'type': 'মাক্কী'},
    {'number': 15, 'arabic': 'الْحِجْر', 'name': 'Al-Hijr', 'bn': 'আল-হিজর', 'verses': 99, 'type': 'মাক্কী'},
    {'number': 16, 'arabic': 'النَّحْل', 'name': 'An-Nahl', 'bn': 'আন-নাহল', 'verses': 128, 'type': 'মাক্কী'},
    {'number': 17, 'arabic': 'الإِسْرَاء', 'name': 'Al-Isra', 'bn': 'বনি ইসরাইল', 'verses': 111, 'type': 'মাক্কী'},
    {'number': 18, 'arabic': 'الْكَهْف', 'name': 'Al-Kahf', 'bn': 'আল-কাহফ', 'verses': 110, 'type': 'মাক্কী'},
    {'number': 19, 'arabic': 'مَرْيَم', 'name': 'Maryam', 'bn': 'মারইয়াম', 'verses': 98, 'type': 'মাক্কী'},
    {'number': 20, 'arabic': 'طه', 'name': 'Ta-Ha', 'bn': 'ত্বা-হা', 'verses': 135, 'type': 'মাক্কী'},
    {'number': 21, 'arabic': 'الْأَنْبِيَاء', 'name': 'Al-Anbiya', 'bn': 'আল-আম্বিয়া', 'verses': 112, 'type': 'মাক্কী'},
    {'number': 22, 'arabic': 'الْحَجّ', 'name': 'Al-Hajj', 'bn': 'আল-হজ্জ', 'verses': 78, 'type': 'মাদানী'},
    {'number': 23, 'arabic': 'الْمُؤْمِنُون', 'name': 'Al-Muminun', 'bn': 'আল-মুমিনুন', 'verses': 118, 'type': 'মাক্কী'},
    {'number': 24, 'arabic': 'النُّور', 'name': 'An-Nur', 'bn': 'আন-নূর', 'verses': 64, 'type': 'মাদানী'},
    {'number': 25, 'arabic': 'الْفُرْقَان', 'name': 'Al-Furqan', 'bn': 'আল-ফুরকান', 'verses': 77, 'type': 'মাক্কী'},
    {'number': 26, 'arabic': 'الشُّعَرَاء', 'name': 'Ash-Shuara', 'bn': 'আশ-শুআরা', 'verses': 227, 'type': 'মাক্কী'},
    {'number': 27, 'arabic': 'النَّمْل', 'name': 'An-Naml', 'bn': 'আন-নমল', 'verses': 93, 'type': 'মাক্কী'},
    {'number': 28, 'arabic': 'الْقَصَص', 'name': 'Al-Qasas', 'bn': 'আল-কাসাস', 'verses': 88, 'type': 'মাক্কী'},
    {'number': 29, 'arabic': 'الْعَنْكَبُوت', 'name': 'Al-Ankabut', 'bn': 'আল-আনকাবুত', 'verses': 69, 'type': 'মাক্কী'},
    {'number': 30, 'arabic': 'الرُّوم', 'name': 'Ar-Rum', 'bn': 'আর-রূম', 'verses': 60, 'type': 'মাক্কী'},
    {'number': 31, 'arabic': 'لُقْمَان', 'name': 'Luqman', 'bn': 'লুকমান', 'verses': 34, 'type': 'মাক্কী'},
    {'number': 32, 'arabic': 'السَّجْدَة', 'name': 'As-Sajdah', 'bn': 'আস-সাজদাহ', 'verses': 30, 'type': 'মাক্কী'},
    {'number': 33, 'arabic': 'الأَحْزَاب', 'name': 'Al-Ahzab', 'bn': 'আল-আহযাব', 'verses': 73, 'type': 'মাদানী'},
    {'number': 34, 'arabic': 'سَبَأ', 'name': 'Saba', 'bn': 'সাবা', 'verses': 54, 'type': 'মাক্কী'},
    {'number': 35, 'arabic': 'فَاطِر', 'name': 'Fatir', 'bn': 'ফাতির', 'verses': 45, 'type': 'মাক্কী'},
    {'number': 36, 'arabic': 'يس', 'name': 'Ya-Sin', 'bn': 'ইয়াসিন', 'verses': 83, 'type': 'মাক্কী'},
    {'number': 37, 'arabic': 'الصَّافَّات', 'name': 'As-Saffat', 'bn': 'আস-সাফফাত', 'verses': 182, 'type': 'মাক্কী'},
    {'number': 38, 'arabic': 'ص', 'name': 'Sad', 'bn': 'সাদ', 'verses': 88, 'type': 'মাক্কী'},
    {'number': 39, 'arabic': 'الزُّمَر', 'name': 'Az-Zumar', 'bn': 'আয-যুমার', 'verses': 75, 'type': 'মাক্কী'},
    {'number': 40, 'arabic': 'غَافِر', 'name': 'Ghafir', 'bn': 'গাফির', 'verses': 85, 'type': 'মাক্কী'},
    {'number': 41, 'arabic': 'فُصِّلَت', 'name': 'Fussilat', 'bn': 'ফুসসিলাত', 'verses': 54, 'type': 'মাক্কী'},
    {'number': 42, 'arabic': 'الشُّورَى', 'name': 'Ash-Shura', 'bn': 'আশ-শুরা', 'verses': 53, 'type': 'মাক্কী'},
    {'number': 43, 'arabic': 'الزُّخْرُف', 'name': 'Az-Zukhruf', 'bn': 'আয-যুখরুফ', 'verses': 89, 'type': 'মাক্কী'},
    {'number': 44, 'arabic': 'الدُّخَان', 'name': 'Ad-Dukhan', 'bn': 'আদ-দুখান', 'verses': 59, 'type': 'মাক্কী'},
    {'number': 45, 'arabic': 'الْجَاثِيَة', 'name': 'Al-Jathiyah', 'bn': 'আল-জাসিয়াহ', 'verses': 37, 'type': 'মাক্কী'},
    {'number': 46, 'arabic': 'الأَحْقَاف', 'name': 'Al-Ahqaf', 'bn': 'আল-আহকাফ', 'verses': 35, 'type': 'মাক্কী'},
    {'number': 47, 'arabic': 'مُحَمَّد', 'name': 'Muhammad', 'bn': 'মুহাম্মদ', 'verses': 38, 'type': 'মাদানী'},
    {'number': 48, 'arabic': 'الْفَتْح', 'name': 'Al-Fath', 'bn': 'আল-ফাতহ', 'verses': 29, 'type': 'মাদানী'},
    {'number': 49, 'arabic': 'الْحُجُرَات', 'name': 'Al-Hujurat', 'bn': 'আল-হুজুরাত', 'verses': 18, 'type': 'মাদানী'},
    {'number': 50, 'arabic': 'ق', 'name': 'Qaf', 'bn': 'কাফ', 'verses': 45, 'type': 'মাক্কী'},
    {'number': 51, 'arabic': 'الذَّارِيَات', 'name': 'Adh-Dhariyat', 'bn': 'আয-যারিয়াত', 'verses': 60, 'type': 'মাক্কী'},
    {'number': 52, 'arabic': 'الطُّور', 'name': 'At-Tur', 'bn': 'আত-তূর', 'verses': 49, 'type': 'মাক্কী'},
    {'number': 53, 'arabic': 'النَّجْم', 'name': 'An-Najm', 'bn': 'আন-নাজম', 'verses': 62, 'type': 'মাক্কী'},
    {'number': 54, 'arabic': 'الْقَمَر', 'name': 'Al-Qamar', 'bn': 'আল-কামার', 'verses': 55, 'type': 'মাক্কী'},
    {'number': 55, 'arabic': 'الرَّحْمَن', 'name': 'Ar-Rahman', 'bn': 'আর-রহমান', 'verses': 78, 'type': 'মাদানী'},
    {'number': 56, 'arabic': 'الْوَاقِعَة', 'name': 'Al-Waqiah', 'bn': 'আল-ওয়াকিয়াহ', 'verses': 96, 'type': 'মাক্কী'},
    {'number': 57, 'arabic': 'الْحَدِيد', 'name': 'Al-Hadid', 'bn': 'আল-হাদীদ', 'verses': 29, 'type': 'মাদানী'},
    {'number': 58, 'arabic': 'الْمُجَادِلَة', 'name': 'Al-Mujadilah', 'bn': 'আল-মুজাদালাহ', 'verses': 22, 'type': 'মাদানী'},
    {'number': 59, 'arabic': 'الْحَشْر', 'name': 'Al-Hashr', 'bn': 'আল-হাশর', 'verses': 24, 'type': 'মাদানী'},
    {'number': 60, 'arabic': 'الْمُمْتَحَنَة', 'name': 'Al-Mumtahanah', 'bn': 'আল-মুমতাহিনাহ', 'verses': 13, 'type': 'মাদানী'},
    {'number': 61, 'arabic': 'الصَّفّ', 'name': 'As-Saff', 'bn': 'আস-সাফ', 'verses': 14, 'type': 'মাদানী'},
    {'number': 62, 'arabic': 'الْجُمُعَة', 'name': 'Al-Jumuah', 'bn': 'আল-জুমুআহ', 'verses': 11, 'type': 'মাদানী'},
    {'number': 63, 'arabic': 'الْمُنَافِقُون', 'name': 'Al-Munafiqun', 'bn': 'আল-মুনাফিকুন', 'verses': 11, 'type': 'মাদানী'},
    {'number': 64, 'arabic': 'التَّغَابُن', 'name': 'At-Taghabun', 'bn': 'আত-তাগাবুন', 'verses': 18, 'type': 'মাদানী'},
    {'number': 65, 'arabic': 'الطَّلَاق', 'name': 'At-Talaq', 'bn': 'আত-তালাক', 'verses': 12, 'type': 'মাদানী'},
    {'number': 66, 'arabic': 'التَّحْرِيم', 'name': 'At-Tahrim', 'bn': 'আত-তাহরীম', 'verses': 12, 'type': 'মাদানী'},
    {'number': 67, 'arabic': 'الْمُلْك', 'name': 'Al-Mulk', 'bn': 'আল-মুলক', 'verses': 30, 'type': 'মাক্কী'},
    {'number': 68, 'arabic': 'الْقَلَم', 'name': 'Al-Qalam', 'bn': 'আল-কলম', 'verses': 52, 'type': 'মাক্কী'},
    {'number': 69, 'arabic': 'الْحَاقَّة', 'name': 'Al-Haqqah', 'bn': 'আল-হাক্কাহ', 'verses': 52, 'type': 'মাক্কী'},
    {'number': 70, 'arabic': 'الْمَعَارِج', 'name': 'Al-Maarij', 'bn': 'আল-মাআরিজ', 'verses': 44, 'type': 'মাক্কী'},
    {'number': 71, 'arabic': 'نُوح', 'name': 'Nuh', 'bn': 'নূহ', 'verses': 28, 'type': 'মাক্কী'},
    {'number': 72, 'arabic': 'الْجِنّ', 'name': 'Al-Jinn', 'bn': 'আল-জিন', 'verses': 28, 'type': 'মাক্কী'},
    {'number': 73, 'arabic': 'الْمُزَّمِّل', 'name': 'Al-Muzzammil', 'bn': 'আল-মুযযাম্মিল', 'verses': 20, 'type': 'মাক্কী'},
    {'number': 74, 'arabic': 'الْمُدَّثِّر', 'name': 'Al-Muddaththir', 'bn': 'আল-মুদ্দাসসির', 'verses': 56, 'type': 'মাক্কী'},
    {'number': 75, 'arabic': 'الْقِيَامَة', 'name': 'Al-Qiyamah', 'bn': 'আল-কিয়ামাহ', 'verses': 40, 'type': 'মাক্কী'},
    {'number': 76, 'arabic': 'الْإِنْسَان', 'name': 'Al-Insan', 'bn': 'আল-ইনসান', 'verses': 31, 'type': 'মাদানী'},
    {'number': 77, 'arabic': 'الْمُرْسَلَات', 'name': 'Al-Mursalat', 'bn': 'আল-মুরসালাত', 'verses': 50, 'type': 'মাক্কী'},
    {'number': 78, 'arabic': 'النَّبَأ', 'name': 'An-Naba', 'bn': 'আন-নাবা', 'verses': 40, 'type': 'মাক্কী'},
    {'number': 79, 'arabic': 'النَّازِعَات', 'name': 'An-Naziat', 'bn': 'আন-নাযিআত', 'verses': 46, 'type': 'মাক্কী'},
    {'number': 80, 'arabic': 'عَبَسَ', 'name': 'Abasa', 'bn': 'আবাসা', 'verses': 42, 'type': 'মাক্কী'},
    {'number': 81, 'arabic': 'التَّكْوِير', 'name': 'At-Takwir', 'bn': 'আত-তাকভীর', 'verses': 29, 'type': 'মাক্কী'},
    {'number': 82, 'arabic': 'الانْفِطَار', 'name': 'Al-Infitar', 'bn': 'আল-ইনফিতার', 'verses': 19, 'type': 'মাক্কী'},
    {'number': 83, 'arabic': 'الْمُطَفِّفِين', 'name': 'Al-Mutaffifin', 'bn': 'আল-মুতাফফিফীন', 'verses': 36, 'type': 'মাক্কী'},
    {'number': 84, 'arabic': 'الانْشِقَاق', 'name': 'Al-Inshiqaq', 'bn': 'আল-ইনশিকাক', 'verses': 25, 'type': 'মাক্কী'},
    {'number': 85, 'arabic': 'الْبُرُوج', 'name': 'Al-Buruj', 'bn': 'আল-বুরুজ', 'verses': 22, 'type': 'মাক্কী'},
    {'number': 86, 'arabic': 'الطَّارِق', 'name': 'At-Tariq', 'bn': 'আত-তারিক', 'verses': 17, 'type': 'মাক্কী'},
    {'number': 87, 'arabic': 'الْأَعْلَى', 'name': 'Al-Ala', 'bn': 'আল-আলা', 'verses': 19, 'type': 'মাক্কী'},
    {'number': 88, 'arabic': 'الْغَاشِيَة', 'name': 'Al-Ghashiyah', 'bn': 'আল-গাশিয়াহ', 'verses': 26, 'type': 'মাক্কী'},
    {'number': 89, 'arabic': 'الْفَجْر', 'name': 'Al-Fajr', 'bn': 'আল-ফজর', 'verses': 30, 'type': 'মাক্কী'},
    {'number': 90, 'arabic': 'الْبَلَد', 'name': 'Al-Balad', 'bn': 'আল-বালাদ', 'verses': 20, 'type': 'মাক্কী'},
    {'number': 91, 'arabic': 'الشَّمْس', 'name': 'Ash-Shams', 'bn': 'আশ-শামস', 'verses': 15, 'type': 'মাক্কী'},
    {'number': 92, 'arabic': 'اللَّيْل', 'name': 'Al-Layl', 'bn': 'আল-লাইল', 'verses': 21, 'type': 'মাক্কী'},
    {'number': 93, 'arabic': 'الضُّحَى', 'name': 'Ad-Duha', 'bn': 'আদ-দুহা', 'verses': 11, 'type': 'মাক্কী'},
    {'number': 94, 'arabic': 'الشَّرْح', 'name': 'Ash-Sharh', 'bn': 'আশ-শারহ', 'verses': 8, 'type': 'মাক্কী'},
    {'number': 95, 'arabic': 'التِّين', 'name': 'At-Tin', 'bn': 'আত-তীন', 'verses': 8, 'type': 'মাক্কী'},
    {'number': 96, 'arabic': 'الْعَلَق', 'name': 'Al-Alaq', 'bn': 'আল-আলাক', 'verses': 19, 'type': 'মাক্কী'},
    {'number': 97, 'arabic': 'الْقَدْر', 'name': 'Al-Qadr', 'bn': 'আল-কদর', 'verses': 5, 'type': 'মাক্কী'},
    {'number': 98, 'arabic': 'الْبَيِّنَة', 'name': 'Al-Bayyinah', 'bn': 'আল-বাইয়িনাহ', 'verses': 8, 'type': 'মাদানী'},
    {'number': 99, 'arabic': 'الزَّلْزَلَة', 'name': 'Az-Zalzalah', 'bn': 'আয-যিলযাল', 'verses': 8, 'type': 'মাদানী'},
    {'number': 100, 'arabic': 'الْعَادِيَات', 'name': 'Al-Adiyat', 'bn': 'আল-আদিয়াত', 'verses': 11, 'type': 'মাক্কী'},
    {'number': 101, 'arabic': 'الْقَارِعَة', 'name': 'Al-Qariah', 'bn': 'আল-কারিআহ', 'verses': 11, 'type': 'মাক্কী'},
    {'number': 102, 'arabic': 'التَّكَاثُر', 'name': 'At-Takathur', 'bn': 'আত-তাকাসুর', 'verses': 8, 'type': 'মাক্কী'},
    {'number': 103, 'arabic': 'الْعَصْر', 'name': 'Al-Asr', 'bn': 'আল-আসর', 'verses': 3, 'type': 'মাক্কী'},
    {'number': 104, 'arabic': 'الْهُمَزَة', 'name': 'Al-Humazah', 'bn': 'আল-হুমাযাহ', 'verses': 9, 'type': 'মাক্কী'},
    {'number': 105, 'arabic': 'الْفِيل', 'name': 'Al-Fil', 'bn': 'আল-ফীল', 'verses': 5, 'type': 'মাক্কী'},
    {'number': 106, 'arabic': 'قُرَيْش', 'name': 'Quraysh', 'bn': 'কুরাইশ', 'verses': 4, 'type': 'মাক্কী'},
    {'number': 107, 'arabic': 'الْمَاعُون', 'name': 'Al-Maun', 'bn': 'আল-মাউন', 'verses': 7, 'type': 'মাক্কী'},
    {'number': 108, 'arabic': 'الْكَوْثَر', 'name': 'Al-Kawthar', 'bn': 'আল-কাউসার', 'verses': 3, 'type': 'মাক্কী'},
    {'number': 109, 'arabic': 'الْكَافِرُون', 'name': 'Al-Kafirun', 'bn': 'আল-কাফিরুন', 'verses': 6, 'type': 'মাক্কী'},
    {'number': 110, 'arabic': 'النَّصْر', 'name': 'An-Nasr', 'bn': 'আন-নাসর', 'verses': 3, 'type': 'মাদানী'},
    {'number': 111, 'arabic': 'الْمَسَد', 'name': 'Al-Masad', 'bn': 'আল-মাসাদ', 'verses': 5, 'type': 'মাক্কী'},
    {'number': 112, 'arabic': 'الإِخْلَاص', 'name': 'Al-Ikhlas', 'bn': 'আল-ইখলাস', 'verses': 4, 'type': 'মাক্কী'},
    {'number': 113, 'arabic': 'الْفَلَق', 'name': 'Al-Falaq', 'bn': 'আল-ফালাক', 'verses': 5, 'type': 'মাক্কী'},
    {'number': 114, 'arabic': 'النَّاس', 'name': 'An-Nas', 'bn': 'আন-নাস', 'verses': 6, 'type': 'মাক্কী'},
  ];

  List<Map<String, dynamic>> get _filteredSurahs {
    final query = _search.trim().toLowerCase();
    if (query.isEmpty) return _surahs;

    return _surahs.where((surah) {
      return surah['name'].toString().toLowerCase().contains(query) ||
          surah['bn'].toString().toLowerCase().contains(query) ||
          surah['number'].toString() == query;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showSurahInfo(Map<String, dynamic> surah) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                surah['arabic'].toString(),
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                '${surah['number']}. ${surah['bn']}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(surah['name'].toString()),
              const SizedBox(height: 16),
              Text(
                '${surah['verses']} আয়াত • ${surah['type']}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              const Text(
                'এই স্ক্রিনে বর্তমানে সূরার পরিচিতি দেখানো হচ্ছে। '
                'সম্পূর্ণ আরবি আয়াত, বাংলা অনুবাদ ও তিলাওয়াত যুক্ত করা হবে '
                'পরবর্তী ধাপে যাচাইকৃত কুরআন ডেটা যুক্ত করে।',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('বন্ধ করুন'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('আল-কুরআন'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  colorScheme.primary,
                  colorScheme.primary.withValues(alpha: 0.75),
                ],
              ),
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.menu_book_rounded,
                  size: 42,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Text(
                  'الْقُرْآن الْكَرِيم',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'পবিত্র আল-কুরআন',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '১১৪টি সূরা',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _search = value),
              decoration: InputDecoration(
                hintText: 'সূরার নাম বা নম্বর খুঁজুন',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _search.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _search = '');
                        },
                        icon: const Icon(Icons.clear),
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          Expanded(
            child: _filteredSurahs.isEmpty
                ? const Center(child: Text('কোনো সূরা পাওয়া যায়নি'))
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    itemCount: _filteredSurahs.length,
                    itemBuilder: (context, index) {
                      final surah = _filteredSurahs[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 5,
                          ),
                          leading: Container(
                            width: 44,
                            height: 44,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: colorScheme.primary.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              surah['number'].toString(),
                              style: TextStyle(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(
                            surah['bn'].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${surah['name']} • ${surah['verses']} আয়াত • ${surah['type']}',
                          ),
                          trailing: Text(
                            surah['arabic'].toString(),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          onTap: () => _showSurahInfo(surah),
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
