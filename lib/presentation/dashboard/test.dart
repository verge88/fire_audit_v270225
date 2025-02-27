import 'package:flutter/material.dart';

import '../main/prepare_quiz_screen.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Тестирование'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // "Экзамен" Button
              _buildButton(
                context,
                title: 'Экзамен',
                subtitle: '70 случайных вопросов в случайном порядке',
                icon: Icons.assignment,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                      builder: (context) => PrepareQuizScreen(
                    index: 0,
                    selectedDif: '',
                    numQuestions: 70,
                  )));
                },
              ),
              const SizedBox(height: 15),

              // "Все вопросы" Button
              _buildButton(
                context,
                title: 'Все вопросы',
                subtitle: 'Все вопросы по порядку',
                icon: Icons.list,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => PrepareQuizScreen(
                            index: 1,
                            selectedDif: '',
                            numQuestions: 800,
                          )));
                },
              ),
              const SizedBox(height: 15),



              // "Вопросы 1-20" Button
              FilledButton.tonal(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PrepareQuizScreen(
                    index: 1,
                    selectedDif: '',
                    numQuestions: 800, // Set numQuestions for marathon
                  )));
                },
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // Уменьшение радиуса скругления
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Icon(Icons.run_circle, size: 30), // Иконка в левой части
                    SizedBox(width: 20), // Отступ между иконкой и текстом
                    Text(
                      'Вопросы 1-70',
                      style: TextStyle(fontSize: 18), // Увеличение размера текста
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),


              FilledButton.tonal(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PrepareQuizScreen(
                    index: 1,
                    selectedDif: '',
                    numQuestions: 800, // Set numQuestions for marathon
                  )));
                },
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // Уменьшение радиуса скругления
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Icon(Icons.run_circle, size: 30), // Иконка в левой части
                    SizedBox(width: 20), // Отступ между иконкой и текстом
                    Text(
                      'Вопросы 71-140',
                      style: TextStyle(fontSize: 18), // Увеличение размера текста
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),


              FilledButton.tonal(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PrepareQuizScreen(
                    index: 1,
                    selectedDif: '',
                    numQuestions: 800, // Set numQuestions for marathon
                  )));
                },
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // Уменьшение радиуса скругления
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Icon(Icons.run_circle, size: 30), // Иконка в левой части
                    SizedBox(width: 20), // Отступ между иконкой и текстом
                    Text(
                      'Вопросы 141-210',
                      style: TextStyle(fontSize: 18), // Увеличение размера текста
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),


              FilledButton.tonal(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PrepareQuizScreen(
                    index: 1,
                    selectedDif: '',
                    numQuestions: 800, // Set numQuestions for marathon
                  )));
                },
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // Уменьшение радиуса скругления
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Icon(Icons.run_circle, size: 30), // Иконка в левой части
                    SizedBox(width: 20), // Отступ между иконкой и текстом
                    Text(
                      'Вопросы 211-280',
                      style: TextStyle(fontSize: 18), // Увеличение размера текста
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),


              FilledButton.tonal(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PrepareQuizScreen(
                    index: 1,
                    selectedDif: '',
                    numQuestions: 800, // Set numQuestions for marathon
                  )));
                },
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // Уменьшение радиуса скругления
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Icon(Icons.run_circle, size: 30), // Иконка в левой части
                    SizedBox(width: 20), // Отступ между иконкой и текстом
                    Text(
                      'Вопросы 281-350',
                      style: TextStyle(fontSize: 18), // Увеличение размера текста
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),


              FilledButton.tonal(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PrepareQuizScreen(
                    index: 1,
                    selectedDif: '',
                    numQuestions: 800, // Set numQuestions for marathon
                  )));
                },
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // Уменьшение радиуса скругления
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Icon(Icons.run_circle, size: 30), // Иконка в левой части
                    SizedBox(width: 20), // Отступ между иконкой и текстом
                    Text(
                      'Вопросы 351-420',
                      style: TextStyle(fontSize: 18), // Увеличение размера текста
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),


              FilledButton.tonal(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PrepareQuizScreen(
                    index: 1,
                    selectedDif: '',
                    numQuestions: 800, // Set numQuestions for marathon
                  )));
                },
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // Уменьшение радиуса скругления
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Icon(Icons.run_circle, size: 30), // Иконка в левой части
                    SizedBox(width: 20), // Отступ между иконкой и текстом
                    Text(
                      'Вопросы 421-490',
                      style: TextStyle(fontSize: 18), // Увеличение размера текста
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),


              FilledButton.tonal(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PrepareQuizScreen(
                    index: 1,
                    selectedDif: '',
                    numQuestions: 800, // Set numQuestions for marathon
                  )));
                },
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // Уменьшение радиуса скругления
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Icon(Icons.run_circle, size: 30), // Иконка в левой части
                    SizedBox(width: 20), // Отступ между иконкой и текстом
                    Text(
                      'Вопросы 491-560',
                      style: TextStyle(fontSize: 18), // Увеличение размера текста
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),


              FilledButton.tonal(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PrepareQuizScreen(
                    index: 1,
                    selectedDif: '',
                    numQuestions: 800, // Set numQuestions for marathon
                  )));
                },
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // Уменьшение радиуса скругления
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Icon(Icons.run_circle, size: 30), // Иконка в левой части
                    SizedBox(width: 20), // Отступ между иконкой и текстом
                    Text(
                      'Вопросы 561-630',
                      style: TextStyle(fontSize: 18), // Увеличение размера текста
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),


              FilledButton.tonal(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PrepareQuizScreen(
                    index: 1,
                    selectedDif: '',
                    numQuestions: 800, // Set numQuestions for marathon
                  )));
                },
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // Уменьшение радиуса скругления
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Icon(Icons.run_circle, size: 30), // Иконка в левой части
                    SizedBox(width: 20), // Отступ между иконкой и текстом
                    Text(
                      'Вопросы 631-700',
                      style: TextStyle(fontSize: 18), // Увеличение размера текста
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),


              FilledButton.tonal(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PrepareQuizScreen(
                    index: 1,
                    selectedDif: '',
                    numQuestions: 800, // Set numQuestions for marathon
                  )));
                },
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // Уменьшение радиуса скругления
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Icon(Icons.run_circle, size: 30), // Иконка в левой части
                    SizedBox(width: 20), // Отступ между иконкой и текстом
                    Text(
                      'Вопросы 701-770',
                      style: TextStyle(fontSize: 18), // Увеличение размера текста
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),


              FilledButton.tonal(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PrepareQuizScreen(
                    index: 1,
                    selectedDif: '',
                    numQuestions: 800, // Set numQuestions for marathon
                  )));
                },
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // Уменьшение радиуса скругления
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Icon(Icons.run_circle, size: 30), // Иконка в левой части
                    SizedBox(width: 20), // Отступ между иконкой и текстом
                    Text(
                      'Вопросы 771-800',
                      style: TextStyle(fontSize: 18), // Увеличение размера текста
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return FilledButton.tonal(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDialog(BuildContext context, String title, int numQuestions) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text(title)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Количество вопросов: $numQuestions', style: const TextStyle(fontSize: 18)),
              const Text('Время на выполнение: 80 мин', style: TextStyle(fontSize: 18)),
              const Text('Минимум правильных ответов: 60', style: TextStyle(fontSize: 18)),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Начать'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PrepareQuizScreen(
                      index: title == 'Экзамен' ? 0 : 1,
                      selectedDif: '',
                      numQuestions: numQuestions,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
