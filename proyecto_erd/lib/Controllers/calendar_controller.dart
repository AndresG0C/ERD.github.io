import 'package:flutter/material.dart';

class CalendarView extends StatefulWidget {
  final Function(int month, int day) onDateSelected;
  const CalendarView({super.key, required this.onDateSelected});
  // final String username;

  // CalendarView({required this.username});

  @override
  // ignore: library_private_types_in_public_api
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {

  Map<int, List<int>> daysPerMonth = {
    0: List.generate(31, (index) => index + 1), // Enero
    1: [], // Febrero
    2: List.generate(31, (index) => index + 1), // Marzo
    3: List.generate(30, (index) => index + 1), // Abril
    4: List.generate(31, (index) => index + 1), // Mayo
    5: List.generate(30, (index) => index + 1), // Junio
    6: List.generate(31, (index) => index + 1), // Julio
    7: List.generate(31, (index) => index + 1), // Agosto
    8: List.generate(30, (index) => index + 1), // Septiembre
    9: List.generate(31, (index) => index + 1), // Octubre
    10: List.generate(30, (index) => index + 1), // Noviembre
    11: List.generate(31, (index) => index + 1), // Diciembre
  };


  @override
  void initState() {
    super.initState();
    _updateDaysForMonth(selectedMonthIndex); // Inicializar días para el mes seleccionado
  }

  void _updateDaysForMonth(int monthIndex) {
    setState(() {
      if (monthIndex == 1) { // Si es febrero, ajusta los días según el año bisiesto
        int year = 2024; // Puedes cambiarlo dinámicamente
        bool isLeapYear = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
        daysPerMonth[1] = List.generate(isLeapYear ? 29 : 28, (index) => index + 1);
      }
      days = daysPerMonth[monthIndex]!;
      selectedDay = days[0]; // Seleccionar el primer día por defecto
    });
  }

  // Cuando selecciones un nuevo mes, actualiza los días
  void _onMonthSelected(int index) {
    setState(() {
      selectedMonthIndex = index;
      _updateDaysForMonth(index); // Actualiza los días según el mes seleccionado
    });
  }
  // void updateDaysForMonth(int monthIndex) {
  //   setState(() {
  //     days = daysPerMonth[monthIndex]!;
  //     selectedDay = days[0]; // Seleccionar el primer día por defecto
  //   });
  // }


  List<String> months = [
    'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
    'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
  ];

  List<int> days = List.generate(30, (index) => index + 1); // Días de ejemplo
  int selectedMonthIndex = 3; // Junio por defecto
  int selectedDay = 3; // Día seleccionado por defecto
  // ScrollControllers para manejar el desplazamiento de los ListView
  final ScrollController _monthsScrollController = ScrollController();
  final ScrollController _daysScrollController = ScrollController();

  // void _scrollMonths(bool forward) {
  //   double offset = _monthsScrollController.offset + (forward ? 100 : -100);
  //   _monthsScrollController.animateTo(
  //     offset,
  //     duration: Duration(milliseconds: 300),
  //     curve: Curves.easeInOut,
  //   );
  // }

  // void _scrollDays(bool forward) {
  //   double offset = _daysScrollController.offset + (forward ? 100 : -100);
  //   _daysScrollController.animateTo(
  //     offset,
  //     duration: Duration(milliseconds: 300),
  //     curve: Curves.easeInOut,
  //   );
  // }

  void _onDaySelected(int day) {
    widget.onDateSelected(selectedMonthIndex, day);  // Llamar al callback cuando se selecciona un día
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDCE9FD),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Texto de bienvenida
          // Text(
          //   'Bienvenido, ${widget.username}!',
          //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          //   textAlign: TextAlign.center,
          // ),
          // SizedBox(height: 20),

          // Fila para los meses con flechas
          Row(
            children: [
              // IconButton(
              //   icon: Icon(Icons.arrow_back),
              //   iconSize: 16, // Tamaño del icono más pequeño
              //   padding: EdgeInsets.all(4),
              //   constraints: BoxConstraints(
              //     minWidth: 30, // Ancho mínimo del botón
              //     minHeight: 24,
              //   ),
              //   onPressed: () => _scrollMonths(false),
              // ),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ListView.builder(
                    controller: _monthsScrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: months.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _onMonthSelected(index);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: selectedMonthIndex == index ? Colors.blue : const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              months[index],
                              style: TextStyle(
                                color: selectedMonthIndex == index ? const Color.fromARGB(255, 255, 255, 255) : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // IconButton(
              //   icon: Icon(Icons.arrow_forward),
              //   iconSize: 16, // Tamaño del icono más pequeño
              //   padding: EdgeInsets.all(4), // Reducción del padding para hacerlo más pequeño
              //   constraints: BoxConstraints(
              //     minWidth: 30, // Ancho mínimo del botón
              //     minHeight: 24, // Altura mínima del botón
              //   ),
              //   onPressed: () => _scrollMonths(true),
              // ),

            ],
          ),

          const SizedBox(height: 20),

          // Fila para los días con flechas
          Row(
            children: [
              // IconButton(
              //   icon: Icon(Icons.arrow_back),
              //   iconSize: 16, // Tamaño del icono más pequeño
              //   padding: EdgeInsets.all(4),
              //   constraints: BoxConstraints(
              //     minWidth: 30, // Ancho mínimo del botón
              //     minHeight: 24,
              //   ),
              //   onPressed: () => _scrollDays(false),
              // ),
              Expanded(
                child: SizedBox(
                  height: 60,
                  child: ListView.builder(
                    controller: _daysScrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: days.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDay = days[index];
                          });
                          _onDaySelected(days[index]);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: selectedDay == days[index] ? Colors.blue : const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${months[selectedMonthIndex].substring(0, 3)} ${days[index]}',
                                  style: TextStyle(
                                    color: selectedDay == days[index] ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  getDayOfWeek(days[index]),
                                  style: TextStyle(
                                    color: selectedDay == days[index] ? Colors.white : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // IconButton(
              //   icon: Icon(Icons.arrow_forward),
              //   iconSize: 16,
              //   onPressed: () => _scrollDays(true),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  // Función para obtener el nombre del día
  String getDayOfWeek(int day) {
    List<String> weekdays = ['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'];
    DateTime date = DateTime(2024, selectedMonthIndex + 1, day); // Año 2023 como ejemplo
    return weekdays[date.weekday % 7];
  }
}