import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/providers/theme_provider.dart';
import 'package:provider_app/providers/todo_provider.dart';
import 'package:provider_app/screens/setting_screen.dart';
import 'package:provider_app/screens/todo_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TodoProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode:
                themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            initialRoute: '/todo',
            routes: {
              '/todo': (context) => TodoListScreen(),
              '/settings': (context) => const SettingScreen(),
            },
          );
        },
      ),
    );
  }
}
