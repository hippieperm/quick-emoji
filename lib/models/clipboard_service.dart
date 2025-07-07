import 'package:flutter/services.dart';

class ClipboardService {
  // 싱글톤 패턴 구현
  static final ClipboardService _instance = ClipboardService._internal();

  factory ClipboardService() {
    return _instance;
  }

  ClipboardService._internal();

  // 클립보드에 텍스트 복사
  Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
}
