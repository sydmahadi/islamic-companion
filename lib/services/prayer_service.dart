
import 'package:adhan_dart/adhan_dart.dart';
import 'package:geolocator/geolocator.dart';

class PrayerTimeItem {
  final String name;
  final DateTime time;

  const PrayerTimeItem({
    required this.name,
    required this.time,
  });
}

class PrayerSchedule {
  final double latitude;
  final double longitude;
  final List<PrayerTimeItem> prayers;
  final DateTime tomorrowFajr;

  const PrayerSchedule({
    required this.latitude,
    required this.longitude,
    required this.prayers,
    required this.tomorrowFajr,
  });
}

class PrayerService {
  PrayerService._();

  static final PrayerService instance = PrayerService._();

  Future<PrayerSchedule> loadSchedule() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
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
        'App Settings থেকে Location অনুমতি চালু করুন।',
      );
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 30),
      ),
    );

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    final coordinates = Coordinates(
      position.latitude,
      position.longitude,
    );

    final parameters = CalculationMethodParameters.karachi()
      ..madhab = Madhab.hanafi;

    final todayTimes = PrayerTimes(
      coordinates: coordinates,
      date: today,
      calculationParameters: parameters,
    );

    final tomorrowTimes = PrayerTimes(
      coordinates: coordinates,
      date: tomorrow,
      calculationParameters: parameters,
    );

    return PrayerSchedule(
      latitude: position.latitude,
      longitude: position.longitude,
      prayers: [
        PrayerTimeItem(
          name: 'ফজর',
          time: _toBangladeshTime(todayTimes.fajr),
        ),
        PrayerTimeItem(
          name: 'সূর্যোদয়',
          time: _toBangladeshTime(todayTimes.sunrise),
        ),
        PrayerTimeItem(
          name: 'যোহর',
          time: _toBangladeshTime(todayTimes.dhuhr),
        ),
        PrayerTimeItem(
          name: 'আসর',
          time: _toBangladeshTime(todayTimes.asr),
        ),
        PrayerTimeItem(
          name: 'মাগরিব',
          time: _toBangladeshTime(todayTimes.maghrib),
        ),
        PrayerTimeItem(
          name: 'ইশা',
          time: _toBangladeshTime(todayTimes.isha),
        ),
      ],
      tomorrowFajr: _toBangladeshTime(tomorrowTimes.fajr),
    );
  }

  DateTime _toBangladeshTime(DateTime time) {
    final utc = time.toUtc();

    // Bangladesh Standard Time: UTC+6.
    // Build a local DateTime so countdown comparisons use the
    // same clock basis as DateTime.now() on a Bangladesh device.
    return DateTime(
      utc.year,
      utc.month,
      utc.day,
      utc.hour + 6,
      utc.minute,
      utc.second,
    );
  }
}
