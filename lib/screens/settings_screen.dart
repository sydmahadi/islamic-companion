
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final String language;
  final ValueChanged<String> onLanguageChanged;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.language,
    required this.onLanguageChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _locationEnabled = true;
  bool _isLoading = true;

  bool get _isBangla => widget.language == 'bn';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      _notificationsEnabled =
          prefs.getBool('notifications_enabled') ?? true;
      _locationEnabled = prefs.getBool('location_enabled') ?? true;
      _isLoading = false;
    });
  }

  Future<void> _saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  void _showAbout() {
    showAboutDialog(
      context: context,
      applicationName: 'Islamic Companion',
      applicationVersion: '1.0.0',
      applicationLegalese:
          'Your daily companion for Islamic worship.',
      children: [
        const SizedBox(height: 12),
        Text(
          _isBangla
              ? 'নামাজের সময়, কুরআন, দোয়া, কিবলা ও দৈনন্দিন আমল ব্যবস্থাপনার জন্য তৈরি।'
              : 'Made to help with prayer times, Quran, duas, Qibla and daily worship.',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isBangla ? 'সেটিংস' : 'Settings'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _sectionTitle(
                  _isBangla ? 'অ্যাপের পছন্দ' : 'App Preferences',
                ),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.language),
                        title: Text(
                          _isBangla ? 'ভাষা' : 'Language',
                        ),
                        subtitle: Text(
                          _isBangla ? 'বাংলা' : 'English',
                        ),
                        trailing: DropdownButton<String>(
                          value: widget.language,
                          underline: const SizedBox(),
                          items: const [
                            DropdownMenuItem(
                              value: 'bn',
                              child: Text('বাংলা'),
                            ),
                            DropdownMenuItem(
                              value: 'en',
                              child: Text('English'),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              widget.onLanguageChanged(value);
                            }
                          },
                        ),
                      ),
                      const Divider(height: 1),
                      SwitchListTile(
                        secondary: Icon(
                          widget.isDarkMode
                              ? Icons.dark_mode
                              : Icons.light_mode,
                        ),
                        title: Text(
                          _isBangla ? 'ডার্ক থিম' : 'Dark Theme',
                        ),
                        subtitle: Text(
                          _isBangla
                              ? 'অ্যাপের রঙ পরিবর্তন করুন'
                              : 'Change the app appearance',
                        ),
                        value: widget.isDarkMode,
                        onChanged: widget.onThemeChanged,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _sectionTitle(
                  _isBangla ? 'রিমাইন্ডার ও অনুমতি' : 'Reminders & Permissions',
                ),
                Card(
                  child: Column(
                    children: [
                      SwitchListTile(
                        secondary: const Icon(Icons.notifications_active),
                        title: Text(
                          _isBangla ? 'নোটিফিকেশন' : 'Notifications',
                        ),
                        subtitle: Text(
                          _isBangla
                              ? 'রিমাইন্ডার পছন্দ সংরক্ষণ করুন'
                              : 'Save your reminder preference',
                        ),
                        value: _notificationsEnabled,
                        onChanged: (value) {
                          setState(() => _notificationsEnabled = value);
                          _saveBool('notifications_enabled', value);
                        },
                      ),
                      const Divider(height: 1),
                      SwitchListTile(
                        secondary: const Icon(Icons.location_on),
                        title: Text(
                          _isBangla ? 'লোকেশন ব্যবহার' : 'Use Location',
                        ),
                        subtitle: Text(
                          _isBangla
                              ? 'নামাজের সময় ও কিবলার জন্য'
                              : 'For prayer times and Qibla',
                        ),
                        value: _locationEnabled,
                        onChanged: (value) {
                          setState(() => _locationEnabled = value);
                          _saveBool('location_enabled', value);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _sectionTitle(
                  _isBangla ? 'অ্যাপ সম্পর্কে' : 'About',
                ),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.info_outline),
                        title: Text(
                          _isBangla ? 'অ্যাপের তথ্য' : 'About App',
                        ),
                        subtitle: const Text('Islamic Companion'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: _showAbout,
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.restart_alt),
                        title: Text(
                          _isBangla
                              ? 'সেটিংস রিফ্রেশ'
                              : 'Refresh Settings',
                        ),
                        subtitle: Text(
                          _isBangla
                              ? 'সংরক্ষিত সেটিংস পুনরায় লোড করুন'
                              : 'Reload saved preferences',
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () async {
                          await _loadSettings();
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                _isBangla
                                    ? 'সেটিংস রিফ্রেশ হয়েছে'
                                    : 'Settings refreshed',
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    'Islamic Companion • v1.0.0',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
