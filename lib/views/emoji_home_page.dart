import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/emoji_view_model.dart';
import '../viewmodels/theme_view_model.dart';
import '../viewmodels/search_view_model.dart';
import 'emoji_grid_view.dart';
import 'search_view.dart';

class EmojiHomePage extends StatefulWidget {
  final String title;

  const EmojiHomePage({super.key, required this.title});

  @override
  State<EmojiHomePage> createState() => _EmojiHomePageState();
}

class _EmojiHomePageState extends State<EmojiHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

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
        bottom: _currentIndex == 0
            ? TabBar(
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
              )
            : null,
      ),
      body: _currentIndex == 0
          ? TabBarView(
              controller: _tabController,
              children: categories
                  .map(
                    (category) => EmojiGridView(
                      emojis: category.emojis,
                      onEmojiTap: emojiViewModel.copyEmojiToClipboard,
                    ),
                  )
                  .toList(),
            )
          : ChangeNotifierProvider(
              create: (_) => SearchViewModel(emojiViewModel.categories),
              child: const SearchView(),
            ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.emoji_emotions_outlined),
            selectedIcon: Icon(Icons.emoji_emotions),
            label: '이모지',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: '검색',
          ),
        ],
      ),
    );
  }
}
