import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_erd/Controllers/check_controller.dart';
import 'package:proyecto_erd/Controllers/calendar_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DashboardPage extends StatelessWidget {
  final String username;

  const DashboardPage({super.key, required this.username});

  Future<void> fetchTasksForDay(BuildContext context, int month, int day) async {
    print("Fetching tasks for $month-$day...");
    final url = Uri.parse("http://127.0.0.1:8000/consultar_fechas?anio=2024&mes=$month");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print("Data received: $data");

        // Filtrar la respuesta para el día seleccionado
        final taskData = data.firstWhere(
          (item) => item["f053_id"] == "2024-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}T00:00:00",
          orElse: () => {},
        );

        
        // Si se encuentra la fecha, actualizar las tareas
        if (taskData.isNotEmpty) {
          // ignore: use_build_context_synchronously
          final checkController = Provider.of<CheckController>(context, listen: false);

          // Actualizar las tareas según el estado de los campos recibidos
          checkController.toggleTask(0, taskData["f053_ind_estado_cxc"] == 2); // Cuentas por cobrar
          checkController.toggleTask(1, taskData["f053_ind_estado_cxp"] == 2); // Cuentas por pagar
          checkController.toggleTask(2, taskData["f053_ind_estado_af"] == 2);  // Activos Fijos
          checkController.toggleTask(3, taskData["f053_ind_estado_inv"] == 2); // Inventarios
          checkController.toggleTask(4, taskData["f053_ind_estado_cm"] == 2); // Ventas
          checkController.toggleTask(5, taskData["f053_ind_estado_co"] == 2);  // Compras
        }
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching tasks: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CheckController()), // Provee el controlador del checklist
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ERP Siesa Enterprise'),
          backgroundColor: const Color(0xFFDCE9FD),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Navigator.of(context).pop(); // Lógica para cerrar sesión
              },
            ),
          ],
          automaticallyImplyLeading: false, // Quitar la flecha de regresar
        ),
        backgroundColor: const Color(0xFFDCE9FD),
        body: Column(
          children: [
            // Texto de bienvenida
            Text(
              'Bienvenido, $username!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
             // Aquí se integra CalendarView
            SizedBox(
              // height: 150, // Ajusta este valor según sea necesario
              // child: CalendarView(),
              height: 150,
              child: CalendarView(
                onDateSelected: (month, day) {
                  // Hacer la petición GET cuando se selecciona una nueva fecha
                  fetchTasksForDay(context, month, day);
                },
              ),
            ),

            // Checklist
            Expanded(
              child: Consumer<CheckController>(
                builder: (context, checkController, child) {
                  return ListView.builder(
                    itemCount: checkController.tasks.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        title: Text(checkController.tasks[index]["title"]),
                        value: checkController.tasks[index]["isChecked"],
                        onChanged: (value) {
                          checkController.toggleTask(index, value!);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}