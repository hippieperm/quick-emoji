import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/emoji_view_model.dart';
import '../viewmodels/theme_view_model.dart';
import 'emoji_grid_view.dart';

class EmojiHomePage extends StatefulWidget {
  final String title;

  const EmojiHomePage({super.key, required this.title});

  @override
  State<EmojiHomePage> createState() => _EmojiHomePageState();
}

class _EmojiHomePageState extends State<EmojiHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    final emojiViewModel = Provider.of<EmojiViewModel>(context, listen: false);
    _tabController = TabController(
      length: emojiViewModel.categories.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emojiViewModel = Provider.of<EmojiViewModel>(context);
    final themeViewModel = Provider.of<ThemeViewModel>(context);
    final categories = emojiViewModel.categories;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 2,
        actions: [
          IconButton(
            icon: Icon(
              themeViewModel.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: themeViewModel.toggleTheme,
            tooltip: themeViewModel.isDarkMode ? '라이트 모드로 전환' : '다크 모드로 전환',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          dividerColor: Colors.transparent,
          tabs: categories
              .map(
                (category) => Tab(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      category.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: categories
            .map(
              (category) => EmojiGridView(
                emojis: category.emojis,
                onEmojiTap: emojiViewModel.copyEmojiToClipboard,
              ),
            )
            .toList(),
      ),
    );
  }
}
