import 'package:flutter/material.dart';
import '../models/emoji_category.dart';
import '../models/emoji_data_service.dart';
import '../models/clipboard_service.dart';

class EmojiViewModel extends ChangeNotifier {
  final EmojiDataService _emojiDataService = EmojiDataService();
  final ClipboardService _clipboardService = ClipboardService();

  List<EmojiCategory> get categories => _emojiDataService.getCategories();

  String _selectedEmoji = '';
  bool _copied = false;

  String get selectedEmoji => _selectedEmoji;
  bool get copied => _copied;

  // 클립보드에 이모지 복사
  Future<void> copyEmoji(String emoji) async {
    await _clipboardService.copyToClipboard(emoji);
    _selectedEmoji = emoji;
    _copied = true;
    notifyListeners();

    // 복사 표시를 잠시 후에 사라지게 함
    Future.delayed(const Duration(seconds: 1), () {
      _copied = false;
      notifyListeners();
    });
  }
}
