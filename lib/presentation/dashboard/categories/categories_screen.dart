import 'package:bloc_quiz/presentation/library/law_view_screen.dart';
import 'package:bloc_quiz/presentation/library/library_screen.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../data/model/generator.dart';
import '../../../data/model/questions.dart';
import '../../../utility/prepare_quiz.dart';
import '../../../utility/questions_db.dart';
import '../../../bloc/results/results_bloc.dart';
import '../../../bloc/results/results_state.dart';
import '../../../bloc/results/results_event.dart';
import '../../../utility/category_detail_list.dart';

import '../../main/prepare_quiz_screen.dart';
import '../../main/question_screen.dart';
import '../test.dart';
import 'generated_tests_screen.dart';

class Categories extends StatelessWidget {
  Categories({Key? key}) : super(key: key);

  final List<String> categories = [for (var e in categoryDetailList) e.title];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResultsBloc()..add(CategoryDataRequested(categories.first)),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatCard('46/800', 'Тестовых вопросов пройдено'),
                    _buildStatCard('0/71', 'Практических вопросов пройдено'),
                  ],
                ),
                const SizedBox(height: 10),
                _buildChartCard(context),
                const SizedBox(height: 10),
                const Text(
                  'Быстрый доступ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // Остальной код без изменений...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildQuickAccessCard(Icons.assignment_outlined, 'Практика', 'Изучите теорию', () {}),
                    _buildQuickAccessCard(Icons.quiz, 'Тесты', 'Проверьте знания', () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Test()));
                    }),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildQuickAccessCard(
                        Icons.account_balance_rounded,
                        'Нормативно-правовая база',
                        'Все материалы',
                            () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => LibraryScreen()));
                        }
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChartCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Text(
          //   'Ст',
          //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          // ),
          const SizedBox(height: 10),
          BlocBuilder<ResultsBloc, ResultsState>(
            builder: (context, state) {
              if (state is Success) {
                if (state.data == null || state.data.docs.isEmpty) {
                  return const Text(
                    'Нет данных',
                    style: TextStyle(color: Colors.grey),
                  );
                }

                List<double>? xValues = state.analysisData?.map((e) => e.x).toList();

                return SizedBox(
                  height: 180,
                  child: LineChart(
                    LineChartData(
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: Colors.grey),
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) {
                              if (xValues!.contains(value)) {
                                return Text(
                                  value.toInt().toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              );
                            },
                          ),
                        ),
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      minX: 1,
                      maxX: (state.data.docs.length * 1.0),
                      minY: 0,
                      maxY: 70,
                      lineBarsData: [
                        LineChartBarData(
                          spots: state.analysisData ?? [],
                          isCurved: true,
                          barWidth: 5,
                          isStrokeCapRound: true,
                          color: Colors.blueGrey,
                          gradient: LinearGradient(colors: [Colors.grey, Colors.blueGrey]),
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [Colors.grey, Colors.grey]
                                  .map((color) => color.withOpacity(0.1))
                                  .toList(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
              if (state is Error) {
                return Text(
                  'Error: ${state.error}',
                  style: TextStyle(color: Colors.red),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary, // Используем цвет темы
                ),
              );

            },
          ),
        ],
      ),
    );
  }

  // Остальные методы без изменений...
  Widget _buildStatCard(String title, String subtitle) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Text(subtitle, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessCard(
      IconData icon, String title, String subtitle, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(icon, size: 30, color: Colors.blueGrey),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}