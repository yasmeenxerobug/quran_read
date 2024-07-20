import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/surah_ayah.dart';


class QuranProvider with ChangeNotifier {
  List<Surah> _surahs = [];
  List<Ayah> _ayahs = [];
  int _selectedSurah = 1;
  int _currentPage = 0;
  int ayahsPerPage = 8;


  List<Surah> get surahs => _surahs;
  List<Ayah> get ayahs => _ayahs;
  int get selectedSurah => _selectedSurah;
  int get currentPage => _currentPage;

  QuranProvider() {
    fetchSurahs();
  }

  Future<void> fetchSurahs() async {
    final response = await http.get(Uri.parse('https://api.alquran.cloud/v1/surah'));
    if (response.statusCode == 200) {
      _surahs = (json.decode(response.body)['data'] as List)
          .map((data) => Surah.fromJson(data))
          .toList();
      notifyListeners();
      fetchAyahs(_selectedSurah);
    } else {
      throw Exception('Failed to load Surahs');
    }
  }

  Future<void> fetchAyahs(int surahNumber) async {
    final response = await http.get(Uri.parse('https://api.alquran.cloud/v1/surah/$surahNumber/ur.jhaladhry'));
    if (response.statusCode == 200) {
      _ayahs = (json.decode(response.body)['data']['ayahs'] as List)
          .map((data) => Ayah.fromJson(data))
          .toList();
      _currentPage = 0;
      notifyListeners();
    } else {
      throw Exception('Failed to load Ayahs');
    }
  }

  void selectSurah(int surahNumber) {
    _selectedSurah = surahNumber;
    fetchAyahs(_selectedSurah);
  }

  void nextPage() {
    if ((_currentPage + 1) * ayahsPerPage < _ayahs.length) {
      _currentPage++;
    } else {
      _selectedSurah = (_selectedSurah % _surahs.length) + 1;
      fetchAyahs(_selectedSurah);
    }
    notifyListeners();
  }

  void prevPage() {
    if (_currentPage > 0) {
      _currentPage--;
    }
    notifyListeners();
  }
}
