import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_erd/Controllers/fechas_controller.dart';
import 'package:proyecto_erd/models/fechas_models.dart';
import 'package:proyecto_erd/pages/fechas/diaView.dart';

class MesView extends StatelessWidget {
  final FechasController _controller = Get.put(FechasController());

  MesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seleccionar Día"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              // Cargar fechas para un mes específico
              await _controller.cargarFechas(2024, 11); // Año 2024, noviembre
            },
            child: Text("Cargar Mes"),
          ),
          Obx(() {
            if (_controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            if (_controller.fechas.isEmpty) {
              return Center(child: Text("No hay datos disponibles"));
            }
            return SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _controller.fechas.length,
                itemBuilder: (context, index) {
                  final RegistroEstado registro = _controller.fechas[index];
                  final fecha = registro.f053Id;

                  return GestureDetector(
                    onTap: () {
                      // Navegar a la vista del día específico
                      
                    },
                    child: Card(
                      margin: EdgeInsets.all(8),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text("${fecha.day}", style: TextStyle(fontSize: 20)),
                            Text("${fecha.month}/${fecha.year}"),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
