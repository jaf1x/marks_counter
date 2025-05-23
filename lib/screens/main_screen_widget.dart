import 'package:flutter/material.dart';

class MainScreenWidget extends StatefulWidget {
  MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  bool isDarkTheme = false;
  var backgroundColorDarkTheme = Color.fromARGB(221, 30, 30, 30);

  List<int> _marksList = [];
  List<int> marksForTeach = [2, 3, 4, 5];
  List<Color> borderColors = [
    Colors.red,
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

  void changeTheme() {
    setState(() {
      isDarkTheme = !isDarkTheme;
    });
  }

  bool isCol = false;
  void changeCol(){
    setState(() {
    isCol = !isCol;
    });
  }
  // реализовать кол
  // добавить хуйню типо "как всё работает?" и там бам всплывающее окно и написано всё

  void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Настройки'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CheckboxListTile(
                  title: Text('Оценка "кол"'),
                  value: isCol,
                  onChanged: (bool? value) {
                    setState(() {
                      isCol = value ?? false;
                    });
                  },
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Закрыть'),
          ),
        ],
      );
      },
    ).then((_){
      setState(() {
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    List<int> displayMarksForTeach = List.from(marksForTeach);
    if(isCol){
      displayMarksForTeach.insert(0,1);
    }

    return Scaffold(
      backgroundColor: isDarkTheme ? backgroundColorDarkTheme : Colors.white,
      body: Stack(
        children: [
          Center(
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
                        style: TextStyle(
                          fontSize: 28,
                          color: isDarkTheme ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Text(
                    'Оценки: ${_marksList.join(', ')}',
                    style: TextStyle(
                      fontSize: 24,
                      color: isDarkTheme ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Кнопки оценок
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(displayMarksForTeach.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Container(
                          height: 52,
                          width: displayMarksForTeach.length == 5 ? 65 : 75 ,
                          child: ElevatedButton(
                            onPressed: () => _addMark(displayMarksForTeach[index]),
                            style: ButtonStyle(
                              foregroundColor: WidgetStatePropertyAll(isDarkTheme ? Colors.white: Colors.black),
                              backgroundColor: WidgetStatePropertyAll(isDarkTheme ? backgroundColorDarkTheme: Colors.white),
                              side: WidgetStatePropertyAll(BorderSide(
                                color: borderColors[index],
                                width: 1.5,
                              )),
                            ),
                            child: Text(
                              displayMarksForTeach[index].toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 15),
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
                        ),
                      ),
                      const SizedBox(width: 10),
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
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 42),
            child: Align(
              alignment: Alignment.topRight, // Выравнивание по верхнему правому углу
              child: IconButton(
                onPressed: changeTheme,
                icon: Icon(
                  isDarkTheme ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                  color: isDarkTheme ? Colors.yellow : Colors.black,
                ),
                iconSize: 32,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 42),
            child: Align(
              alignment: Alignment.topRight, // Выравнивание по верхнему правому углу
              child: IconButton(
                onPressed: () => _showDialog(context),
                icon: Icon(
                  Icons.settings,
                  color: isDarkTheme ? Colors.white : Colors.black,
                ),
                iconSize: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }


  ButtonStyle exButtonStyle() {
    return ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(isDarkTheme ? Colors.white : backgroundColorDarkTheme),
        backgroundColor: WidgetStatePropertyAll(isDarkTheme ? Color.fromARGB(221, 30, 30, 30): Colors.white),
        side: WidgetStatePropertyAll(BorderSide(color: isDarkTheme ? Colors.white : backgroundColorDarkTheme)));
  }
}
