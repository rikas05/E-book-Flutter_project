import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/ebook_provider.dart';
import 'screens/bookshelf_screen.dart';

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
          create: (_) => EbookProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Ebook Library',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
          ),
          useMaterial3: true,
        ),
        home: const BookshelfScreen(),
      ),
    );
  }
}
