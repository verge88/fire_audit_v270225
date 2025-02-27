import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:convert';
import '../../data/model/law.dart';
import '../../data/repositories/library_repo.dart';
import 'law_view_screen.dart';

class LibraryScreen extends StatefulWidget {
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  late Future<List<Law>> futureLaws;
  final String url = 'https://firebasestorage.googleapis.com/v0/b/quiz-4c367.appspot.com/o/law_url%2Flaw_url.json?alt=media&token=10be06c3-85c7-4c83-a1f2-72860fbc5d86';

  @override
  void initState() {
    super.initState();
    futureLaws = _fetchLaws();
  }

  Future<List<Law>> _fetchLaws() async {
    DefaultCacheManager cacheManager = DefaultCacheManager();
    FileInfo? fileInfo = await cacheManager.getFileFromCache(url);
    if (fileInfo != null && fileInfo.validTill!.isAfter(DateTime.now())) {
      String? jsonString = await fileInfo.file.readAsString();
      Iterable decoded = jsonDecode(jsonString!);
      return List<Law>.from(decoded.map((lawJson) => Law.fromJson(lawJson)));
    } else {
      List<Law> laws = await _fetchFromNetwork();
      await cacheManager.putFile(url, utf8.encode(jsonEncode(laws)));
      return laws;
    }
  }

  Future<List<Law>> _fetchFromNetwork() async {
    LibraryDataRepository repository = LibraryDataRepository(url);
    return repository.getLaws();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   title: Text('Нормативно-правовая база'),
      // ),
      body: FutureBuilder<List<Law>>(
        future: futureLaws,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No laws available.'));
          }

          List<Law> laws = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 7), // Добавлены отступы для ListView
            itemCount: laws.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 1), // Добавлены вертикальные отступы между карточками
                child: Card(
                  color: Theme.of(context).cardColor,
                  elevation: 0,
                  child: Center(
                    child: ListTile(
                      title: Text(laws[index].title),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LawViewScreen(law: laws[index]),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}