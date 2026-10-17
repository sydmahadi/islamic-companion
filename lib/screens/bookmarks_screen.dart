
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  static const String _storageKey = 'islamic_companion_bookmarks';

  final TextEditingController _controller = TextEditingController();
  List<String> _bookmarks = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final items = prefs.getStringList(_storageKey) ?? [];

    if (!mounted) return;
    setState(() {
      _bookmarks = items;
      _loading = false;
    });
  }

  Future<void> _saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_storageKey, _bookmarks);
  }

  Future<void> _addBookmark() async {
    final value = _controller.text.trim();

    if (value.isEmpty) return;

    if (_bookmarks.contains(value)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('এই নোটটি আগে থেকেই আছে')),
      );
      return;
    }

    setState(() {
      _bookmarks.insert(0, value);
      _controller.clear();
    });

    await _saveBookmarks();
  }

  Future<void> _deleteBookmark(int index) async {
    final removed = _bookmarks[index];

    setState(() {
      _bookmarks.removeAt(index);
    });

    await _saveBookmarks();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('নোটটি মুছে ফেলা হয়েছে'),
        action: SnackBarAction(
          label: 'ফিরিয়ে আনুন',
          onPressed: () async {
            setState(() {
              _bookmarks.insert(index, removed);
            });
            await _saveBookmarks();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('বুকমার্ক ও নোট'),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'ব্যক্তিগত নোট যোগ করুন',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _controller,
                            minLines: 2,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              hintText:
                                  'গুরুত্বপূর্ণ আয়াত, দোয়া বা মনে রাখার বিষয় লিখুন...',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          FilledButton.icon(
                            onPressed: _addBookmark,
                            icon: const Icon(Icons.bookmark_add_outlined),
                            label: const Text('সংরক্ষণ করুন'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Icon(Icons.bookmarks_outlined),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'সংরক্ষিত নোট',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Chip(label: Text('${_bookmarks.length}')),
                    ],
                  ),
                ),
                Expanded(
                  child: _bookmarks.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.bookmark_border,
                                size: 64,
                                color: colors.primary.withValues(alpha: 0.5),
                              ),
                              const SizedBox(height: 12),
                              const Text('এখনো কোনো নোট সংরক্ষণ করা হয়নি'),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          itemCount: _bookmarks.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                leading: Icon(
                                  Icons.bookmark,
                                  color: colors.primary,
                                ),
                                title: Text(_bookmarks[index]),
                                trailing: IconButton(
                                  tooltip: 'মুছে ফেলুন',
                                  onPressed: () => _deleteBookmark(index),
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    color: Colors.red,
                                  ),
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
