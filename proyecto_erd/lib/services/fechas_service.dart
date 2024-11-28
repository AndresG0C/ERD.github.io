import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto_erd/models/fechas_models.dart';

class FechasService {
  final String baseUrl = "http://127.0.0.1:8000";

  Future<List<RegistroEstado>> consultarFechas(int anio, int mes) async {
    final url = Uri.parse("$baseUrl/consultar_fechas?anio=$anio&mes=$mes");
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Decodificar la respuesta JSON
        final List<dynamic> jsonList = jsonDecode(response.body);

        print(response.body);

        // Convertir cada elemento en una instancia de RegistroEstado
        return jsonList.map((json) => RegistroEstado.fromJson(json)).toList();
      } else {
        // Manejo de error con excepción
        throw Exception("Error al consultar las fechas: ${response.statusCode}");
      }
    } catch (e) {
      // Imprime el error para depuración
      throw Exception("Error en la conexión: $e");
    }
  }
}
