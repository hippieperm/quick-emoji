import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/emoji_view_model.dart';
import '../viewmodels/theme_view_model.dart';
import 'emoji_grid_view.dart';

class EmojiHomePage extends StatefulWidget {
  const EmojiHomePage({super.key, required this.title});

  final String title;

  @override
  State<EmojiHomePage> createState() => _EmojiHomePageState();
}

class _EmojiHomePageState extends State<EmojiHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // 탭 컨트롤러 초기화
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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surfaceVariant,
        title: Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              themeViewModel.isDarkMode
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              color: colorScheme.primary,
            ),
            onPressed: themeViewModel.toggleTheme,
            tooltip: themeViewModel.isDarkMode ? '라이트 모드로 전환' : '다크 모드로 전환',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          dividerColor: Colors.transparent,
          indicatorColor: colorScheme.primary,
          indicatorWeight: 3,
          labelColor: colorScheme.primary,
          unselectedLabelColor: colorScheme.onSurfaceVariant,
          tabs: emojiViewModel.categories
              .map((category) => Tab(text: category.name, height: 48))
              .toList(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: emojiViewModel.categories
                  .map((category) => EmojiGridView(category: category))
                  .toList(),
            ),
          ),
          // 복사된 이모지 표시 영역
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 70,
            decoration: BoxDecoration(
              color: colorScheme.surfaceVariant,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Center(
              child: emojiViewModel.copied
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            emojiViewModel.selectedEmoji,
                            style: TextStyle(
                              fontSize: 28,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.check_circle_rounded,
                          color: colorScheme.primary,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '클립보드에 복사되었습니다!',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      '이모지를 탭하면 클립보드에 복사됩니다',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
