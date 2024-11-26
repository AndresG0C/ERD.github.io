import 'package:flutter/material.dart';

class CheckController extends ChangeNotifier {
  // Lista de tareas con su estado
  final List<Map<String, dynamic>> _tasks = [
    {"title": "Cuentas por cobrar (CxC)", "isChecked": false},
    {"title": "Cuentas por pagar (CxP)", "isChecked": false},
    {"title": "Activos Fijos (Af)", "isChecked": false},
    {"title": "Inventarios (Inv)", "isChecked": false},
    {"title": "Ventas (Cm)", "isChecked": false},
    {"title": "Compras (Co)", "isChecked": false},
  ];

  // Obtener la lista de tareas
  List<Map<String, dynamic>> get tasks => _tasks;

  // Actualizar el estado de una tarea específica
  void toggleTask(int index, bool value) {
    _tasks[index]['isChecked'] = value;
    notifyListeners();
  }


}
