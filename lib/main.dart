import 'package:flutter/material.dart';
import 'package:free_games/providers/games_provider.dart';
import 'package:free_games/providers/theme_provider.dart';
import 'package:free_games/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GamesProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeConsumer, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            scaffoldBackgroundColor:
                themeConsumer.isDark ? Colors.black : Colors.white,
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(
                  color: themeConsumer.isDark ? Colors.white : Colors.black),
              color: themeConsumer.isDark ? Colors.black : Colors.white,
              titleTextStyle: TextStyle(
                  color: themeConsumer.isDark ? Colors.white : Colors.black),
            ),
            primarySwatch: Colors.blue,
          ),
          home: const HomeScreen(),
        );
      }),
    );
  }
}
