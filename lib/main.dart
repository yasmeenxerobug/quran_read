import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_read/provider/quran_provider.dart';

import 'Screens/surah_list_screen.dart';


void main() {
  runApp(QuranReaderApp());
}

class QuranReaderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuranProvider(),
      child: MaterialApp(
        title: 'Quran Reader',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: SurahListScreen(),
      ),
    );
  }
}
