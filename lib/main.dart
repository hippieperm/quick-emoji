import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'viewmodels/emoji_view_model.dart';
import 'viewmodels/theme_view_model.dart';
import 'views/emoji_home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EmojiViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeViewModel = Provider.of<ThemeViewModel>(context);

    return MaterialApp(
      title: '이모지 모음',
      themeMode: themeViewModel.themeMode,
      theme: themeViewModel.lightTheme,
      darkTheme: themeViewModel.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const EmojiHomePage(title: '이모지 모음'),
    );
  }
}
