import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../data/model/questions.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Получаем путь к папке приложения
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'questions.db');

    // Проверяем, существует ли база данных
    final exists = await databaseExists(path);

    if (!exists) {
      // Если база данных не существует, копируем ее из assets
      try {
        await Directory(dirname(path)).create(recursive: true);

        // Загружаем базу данных из assets
        ByteData data = await rootBundle.load('assets/databases/questions.db');
        List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

        // Сохраняем базу данных на устройство
        await File(path).writeAsBytes(bytes, flush: true);

        print('База данных скопирована.');
      } catch (e) {
        print('Ошибка при копировании базы данных: $e');
      }
    }

    // Открываем базу данных
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // Создаем таблицу, если её нет
        await db.execute('''
          CREATE TABLE IF NOT EXISTS generated (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            question TEXT,
            correctAnswer TEXT,
            incorrectAnswers TEXT
          )
        ''');
      },
    );
  }

  Future<List<Question>> fetchQuestions() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('questions');

      if (maps.isEmpty) {
        print('Таблица вопросов пуста');
        return [];
      }

      return List.generate(maps.length, (i) {
        return Question(
          id: maps[i]['id'].toString(),
          category: maps[i]['category'],
          question: maps[i]['question'],
          correctAnswer: maps[i]['correctAnswer'],
          incorrectAnswers: maps[i]['incorrectAnswers'].split('|'),
          clarification: maps[i]['clarification'],
        );
      });
    } catch (e) {
      print('Ошибка при загрузке вопросов: $e');
      return [];
    }
  }

  Future<List<Question>> fetchGeneratedQuestions() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('generated');

      if (maps.isEmpty) {
        print('Таблица сгенерированных вопросов пуста');
        return [];
      }

      return List.generate(maps.length, (i) {
        return Question(
          id: maps[i]['id'].toString(),
          question: maps[i]['question'],
          correctAnswer: maps[i]['correctAnswer'],
          incorrectAnswers: maps[i]['incorrectAnswers'].split('|'),
          category: '',
          clarification: '',
        );
      });
    } catch (e) {
      print('Ошибка при загрузке сгенерированных вопросов: $e');
      return [];
    }
  }

  Future<void> insertGeneratedQuestions(List<Question> questions) async {
    try {
      final db = await database;

      for (var question in questions) {
        await db.insert(
          'generated',
          {
            'question': question.question,
            'correctAnswer': question.correctAnswer,
            'incorrectAnswers': question.incorrectAnswers.join('|')
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      print('Вопросы успешно добавлены');
    } catch (e) {
      print('Ошибка при добавлении вопросов: $e');
    }
  }

  Future<void> deleteGeneratedQuestion(String id) async {
    try {
      final db = await database;
      await db.delete(
        'generated',
        where: 'id = ?',
        whereArgs: [id],
      );
      print('Вопрос успешно удален');
    } catch (e) {
      print('Ошибка при удалении вопроса: $e');
    }
  }
}