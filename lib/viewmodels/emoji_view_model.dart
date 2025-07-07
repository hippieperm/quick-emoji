import 'package:flutter/material.dart';
import '../models/emoji_category.dart';
import '../models/emoji_data_service.dart';
import '../services/clipboard_service.dart';

class EmojiViewModel extends ChangeNotifier {
  final EmojiDataService _dataService = EmojiDataService();
  final ClipboardService _clipboardService = ClipboardService();

  late List<EmojiCategory> _categories;
  String _selectedEmoji = '';
  bool _copied = false;

  EmojiViewModel() {
    _categories = _dataService.getCategories();
  }

  List<EmojiCategory> get categories => _categories;
  String get selectedEmoji => _selectedEmoji;
  bool get copied => _copied;

  void copyEmoji(String emoji) {
    _selectedEmoji = emoji;
    _clipboardService.copyToClipboard(emoji);
    _copied = true;
    notifyListeners();

    // 3초 후 복사 상태 초기화
    Future.delayed(const Duration(seconds: 3), () {
      _copied = false;
      notifyListeners();
    });
  }

  // 새로운 메서드 추가
  void copyEmojiToClipboard(String emoji) {
    _selectedEmoji = emoji;
    _clipboardService.copyToClipboard(emoji);
    _copied = true;
    notifyListeners();

    // 복사 알림 표시
    ScaffoldMessenger.of(
      _clipboardService.navigatorKey.currentContext!,
    ).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
            const Text('클립보드에 복사되었습니다!'),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        width: 280,
        duration: const Duration(seconds: 2),
      ),
    );

    // 3초 후 복사 상태 초기화
    Future.delayed(const Duration(seconds: 3), () {
      _copied = false;
      notifyListeners();
    });
  }
}
