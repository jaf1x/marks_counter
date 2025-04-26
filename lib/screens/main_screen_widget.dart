import 'package:flutter/material.dart';

class MainScreenWidget extends StatefulWidget {
  MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  List<int> _marksList = [];
  List<int> marksForTeach = [2, 3, 4, 5];
  List<Color> borderColors = [
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.purpleAccent
  ];

  void _addMark(int mark) {
    if (_marksList.length <= 25) _marksList.add(mark);
    setState(() {});
  }

  void _clearMarks() {
    setState(() {
      _marksList.clear();
    });
  }

  void _deleteLastMark() {
    if (_marksList.isNotEmpty) {
      _marksList.removeLast();
    }
    setState(() {});
  }

  double _calculateAverage() {
    if (_marksList.isEmpty) {
      return 0; // Избегаем деления на ноль
    }
    int sum = _marksList.reduce((a, b) => a + b);
    return sum / _marksList.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Средний балл: ${_calculateAverage().toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 28),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Text(
                'Оценки: ${_marksList.join(', ')}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 30),

              // Кнопки оценок
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(marksForTeach.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        height: 52,
                        width: 75,
                        child: ElevatedButton(
                          onPressed: () => _addMark(marksForTeach[index]),
                          style: ButtonStyle(
                            foregroundColor:
                                WidgetStatePropertyAll(Colors.black),
                            side: WidgetStatePropertyAll(BorderSide(
                              color: borderColors[index],
                              width: 1.5,
                            )),
                          ),
                          child: Text(
                            marksForTeach[index].toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    );
                  })),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 50,
                      width: 170,
                      child: ElevatedButton(
                        onPressed: _deleteLastMark,
                        style: exButtonStyle(),
                        child: Text(
                          '<—',
                          style: TextStyle(fontSize: 16),
                        ),
                      )),
                  SizedBox(width: 10),
                  SizedBox(
                      height: 50,
                      width: 170,
                      child: ElevatedButton(
                        onPressed: _clearMarks,
                        style: exButtonStyle(),
                        child: Text(
                          'Очистить',
                          style: TextStyle(fontSize: 16),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ButtonStyle exButtonStyle() {
    return ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(Colors.black),
        side: WidgetStatePropertyAll(BorderSide(color: Colors.black)));
  }
}
