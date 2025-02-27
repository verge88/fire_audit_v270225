import 'package:flutter/material.dart';
import '../../data/model/questions.dart';
import '../../data/repositories/quiz_repo.dart';
import '../../utility/questions_db.dart';

class QuestionsScreen extends StatefulWidget {
  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  late Future<List<Question>> futureQuestions;

  @override
  void initState() {
    super.initState();
    futureQuestions = fetchQuestionsFromDatabase();
  }

  Future<List<Question>> fetchQuestionsFromDatabase() async {
    // Используем DatabaseHelper для получения данных
    return await DatabaseHelper.instance.fetchQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: FutureBuilder<List<Question>>(
        future: futureQuestions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No questions available.'));
          }

          List<Question> questions = snapshot.data!;
          return ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              Question question = questions[index];
              List<String> options = [...question.incorrectAnswers, question.correctAnswer];
              options.shuffle(); // Перемешиваем ответы

              return Card(
                margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // Изменяем отступы
                elevation: 0.5, // Уменьшаем высоту тени
                //shadowColor: Colors.white,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0.0), // Закругляем углы
                  child: ExpansionTile(
                    title: Text(
                      question.question,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                    children: options.asMap().entries.map((entry) {
                      int optionIndex = entry.key;
                      String optionText = entry.value;
                      return Padding(
                        padding: const EdgeInsets.all(2.0), // Уменьшаем вертикальный отступ
                        child: ListTile(
                          title: Text('${optionIndex + 1}. $optionText'),
                        ),
                      );
                    }).toList()
                      ..add(
                        Padding(
                          padding: EdgeInsets.only(top: 2.0), // Уменьшаем отступ
                          child: ListTile(
                            title: Text(
                              'Правильный ответ: ${question.correctAnswer}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
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
