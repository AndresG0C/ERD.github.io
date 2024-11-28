import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_erd/Controllers/fechas_controller.dart';
import 'package:proyecto_erd/pages/fechas/diaView.dart';
import 'package:proyecto_erd/pages/login_page.dart';
import 'package:proyecto_erd/Controllers/check_controller.dart';
// ignore: unused_import
import 'package:proyecto_erd/pages/dashboard_page.dart';

void main() {
  FechasController _controller = Get.put(FechasController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Asegúrate de que CheckController está disponible en todo el árbol de widgets
        ChangeNotifierProvider(create: (context) => CheckController()), 
      ],
      child: MaterialApp(
        title: 'Siesa Enterprise',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const VistaFechas(), // Inicia la página de login
      ),
    );
  }
}
