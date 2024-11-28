import 'package:get/get.dart';
import '../services/fechas_service.dart';
import '../models/fechas_models.dart';

class FechasController extends GetxController {
  final FechasService _fechasService = FechasService();


  @override
  void onInit() {
    cargarFechas(DateTime.now().year, DateTime.now().month);
    print(fechas);
    // TODO: implement onInit
    super.onInit();
  }
  var fechas = <RegistroEstado>[].obs; // Lista observable de objetos RegistroEstado
  var isLoading = false.obs; // Bandera de carga
  

  Future<void> cargarFechas(int anio, int mes) async {
    isLoading.value = true;
    try {
      // Llama al servicio para obtener las fechas como lista de RegistroEstado
      final data = await _fechasService.consultarFechas(anio, mes);
      fechas.value = data;
      print(fechas[0]);
    } catch (e) {
      // Maneja el error mostrando un mensaje
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

    /// Método para obtener un objeto del día por fecha
  RegistroEstado? obtenerObjetoPorFecha(DateTime fecha) {
    print(fecha);
    try {
      // Busca el objeto que coincida con la fecha
      
      return fechas[3];
      
      // return fechas.firstWhere(
      //   (element) {
      //     // Convierte f053_id (String) a DateTime para comparar
      //     DateTime fechaElemento = element.f053Id;
      //     print(element.f053Id);
      //     print(fecha);
      //     return fechaElemento.year == fecha.year &&
      //         fechaElemento.month == fecha.month &&
      //         fechaElemento.day == fecha.day;
      //   },
      // );
    } catch (e) {
      // Retorna null si no encuentra coincidencia
      return null;
    }
  }

  List<RegistroEstado> get listfechas => fechas;

}
