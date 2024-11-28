import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_erd/Controllers/fechas_controller.dart';
import 'package:proyecto_erd/models/fechas_models.dart';

class VistaFechas extends StatelessWidget {
  const VistaFechas({super.key});

  @override
  Widget build(BuildContext context) {
    FechasController fechasc = Get.find<FechasController>();
    fechasc.cargarFechas(2024, 11);

    // Fecha seleccionada (observable)
    final Rxn<RegistroEstado> fechaSeleccionada = Rxn<RegistroEstado>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Estados por Fecha"),
      ),
      body: Obx(
        () => fechasc.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  // Lista horizontal de fechas
                  SizedBox(
                    height: 100, // Altura para la lista horizontal
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: fechasc.listfechas.length,
                      itemBuilder: (BuildContext context, int index) {
                        final fecha = fechasc.listfechas[index];
                        final DateTime fechaDate =fecha.f053Id;

                        return GestureDetector(
                          onTap: () {
                            // Cambia la fecha seleccionada
                            fechaSeleccionada.value = fecha;
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: fechaSeleccionada.value?.f053Id == fecha.f053Id
                                  ? Colors.blue
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${fechaDate.day}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Icon(
                                  fecha.f053IndFestivo == 1
                                      ? Icons.event_available
                                      : Icons.event_note,
                                  color: Colors.white,
                                  size: 16,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  // Mostrar estados de la fecha seleccionada
                  Expanded(
                    child: Obx(() {
                      if (fechaSeleccionada.value == null) {
                        return const Center(
                          child: Text(
                            "Selecciona una fecha para ver los estados",
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      }

                      final estados = fechaSeleccionada.value!;

                      // Lista de estados
                      return ListView(
                        children: [
                          ListTile(
                            title: const Text("Estado CM"),
                            trailing: Icon(
                              estados.f053IndEstadoCm == 2
                                  ? Icons.check
                                  : Icons.close,
                              color: estados.f053IndEstadoCm == 2
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          ListTile(
                            title: const Text("Estado CO"),
                            trailing: Icon(
                              estados.f053IndEstadoCo == 2
                                  ? Icons.check
                                  : Icons.close,
                              color: estados.f053IndEstadoCo == 2
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          ListTile(
                            title: const Text("Estado CXC"),
                            trailing: Icon(
                              estados.f053IndEstadoCxc == 2
                                  ? Icons.check
                                  : Icons.close,
                              color: estados.f053IndEstadoCxc == 2
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          // Agregar más estados según sea necesario
                        ],
                      );
                    }),
                  ),
                ],
              ),
      ),
    );
  }
}
