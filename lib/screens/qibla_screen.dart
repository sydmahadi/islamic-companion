
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({super.key});

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  static const double _kaabaLatitude = 21.4225;
  static const double _kaabaLongitude = 39.8262;

  bool _loading = false;
  String? _error;
  double? _latitude;
  double? _longitude;
  double? _qiblaBearing;

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  double _calculateBearing(
    double latitude,
    double longitude,
  ) {
    final lat1 = latitude * math.pi / 180;
    final lat2 = _kaabaLatitude * math.pi / 180;
    final deltaLon =
        (_kaabaLongitude - longitude) * math.pi / 180;

    final y = math.sin(deltaLon);
    final x = math.cos(lat1) * math.tan(lat2) -
        math.sin(lat1) * math.cos(deltaLon);

    final bearing = math.atan2(y, x) * 180 / math.pi;
    return (bearing + 360) % 360;
  }

  Future<void> _loadLocation() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final serviceEnabled =
          await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        throw Exception('ফোনের Location চালু করুন।');
      }

      LocationPermission permission =
          await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        throw Exception('কিবলার দিক জানতে Location অনুমতি প্রয়োজন।');
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
          'Location অনুমতি বন্ধ আছে। ফোনের App Settings থেকে অনুমতি দিন।',
        );
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 20),
        ),
      );

      final bearing = _calculateBearing(
        position.latitude,
        position.longitude,
      );

      if (!mounted) return;

      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
        _qiblaBearing = bearing;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _error = error.toString().replaceFirst('Exception: ', '');
        _loading = false;
      });
    }
  }

  String _directionName(double degrees) {
    const directions = [
      'উত্তর',
      'উত্তর-পূর্ব',
      'পূর্ব',
      'দক্ষিণ-পূর্ব',
      'দক্ষিণ',
      'দক্ষিণ-পশ্চিম',
      'পশ্চিম',
      'উত্তর-পশ্চিম',
    ];

    final index = ((degrees % 360) / 45).round() % 8;
    return directions[index];
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('কিবলার দিক'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'আবার অবস্থান নির্ণয়',
            onPressed: _loading ? null : _loadLocation,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(
                  Icons.explore,
                  size: 40,
                  color: colors.primary,
                ),
                const SizedBox(height: 8),
                Text(
                  'কাবা শরিফের দিক',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                const Text(
                  'আপনার বর্তমান অবস্থান থেকে কিবলার দিক নির্ণয়',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                if (_loading)
                  const Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('আপনার অবস্থান নির্ণয় করা হচ্ছে...'),
                    ],
                  )
                else if (_error != null)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.location_off,
                            size: 42,
                            color: Colors.orange,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _error!,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          FilledButton.icon(
                            onPressed: _loadLocation,
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
                  )
                else if (_qiblaBearing != null)
                  Column(
                    children: [
                      Container(
                        width: 270,
                        height: 270,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors.primary.withValues(alpha: 0.08),
                          border: Border.all(
                            color: colors.primary,
                            width: 2,
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const Positioned(
                              top: 14,
                              child: Text(
                                'উত্তর',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 14,
                              child: Text(
                                'দক্ষিণ',
                                style: TextStyle(
                                  color: colors.onSurfaceVariant,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 14,
                              child: Text(
                                'পশ্চিম',
                                style: TextStyle(
                                  color: colors.onSurfaceVariant,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 14,
                              child: Text(
                                'পূর্ব',
                                style: TextStyle(
                                  color: colors.onSurfaceVariant,
                                ),
                              ),
                            ),
                            Transform.rotate(
                              angle: _qiblaBearing! * math.pi / 180,
                              child: Icon(
                                Icons.navigation,
                                size: 112,
                                color: colors.primary,
                              ),
                            ),
                            Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colors.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        '${_qiblaBearing!.toStringAsFixed(1)}°',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                              color: colors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'উত্তর দিক থেকে ${_directionName(_qiblaBearing!)} দিকে',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              const Text(
                                'আপনার অবস্থান',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'অক্ষাংশ: ${_latitude!.toStringAsFixed(5)}',
                              ),
                              Text(
                                'দ্রাঘিমাংশ: ${_longitude!.toStringAsFixed(5)}',
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'দ্রষ্টব্য: এই ডিগ্রি ভৌগোলিক উত্তর থেকে গণনা করা। '
                        'ফোনের কম্পাস সেন্সর যুক্ত না থাকায় এই তীরটি '
                        'ফোন ঘোরানোর সঙ্গে ঘুরবে না। নির্ভুলভাবে দিক '
                        'মেলাতে মানচিত্র বা নির্ভরযোগ্য কম্পাস ব্যবহার করুন।',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                else
                  const Text('অবস্থান পাওয়া যায়নি। আবার চেষ্টা করুন।'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
