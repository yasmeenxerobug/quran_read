import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/quran_provider.dart';


class SurahListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quran Reader'),
      ),
      body: Consumer<QuranProvider>(
        builder: (context, quranProvider, child) {
          return Column(
            children: <Widget>[
              DropdownButton<int>(
                value: quranProvider.selectedSurah,
                items: quranProvider.surahs.map<DropdownMenuItem<int>>((surah) {
                  return DropdownMenuItem<int>(
                    value: surah.number,
                    child: Text(surah.englishName),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    quranProvider.selectSurah(value);
                  }
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: (quranProvider.ayahs.length >
                      (quranProvider.currentPage + 1) * quranProvider.ayahsPerPage)
                      ? quranProvider.ayahsPerPage
                      : quranProvider.ayahs.length -
                      quranProvider.currentPage * quranProvider.ayahsPerPage,
                  itemBuilder: (context, index) {
                    int ayahIndex = quranProvider.currentPage * quranProvider.ayahsPerPage + index;
                    return ListTile(
                      title: Text(quranProvider.ayahs[ayahIndex].text),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: quranProvider.prevPage,
                    child: Text('Previous'),
                  ),
                  ElevatedButton(
                    onPressed: quranProvider.nextPage,
                    child: Text('Next'),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
