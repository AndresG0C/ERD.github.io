import 'package:flutter/material.dart';
import 'package:proyecto_erd/pages/resetear_usuarios_page.dart';
import 'package:proyecto_erd/pages/crear_usuarios_page.dart';

class GestionUsuariosPage extends StatefulWidget {
  const GestionUsuariosPage({super.key});

  @override
  State<GestionUsuariosPage> createState() => _GestionUsuariosPage();
}

class _GestionUsuariosPage extends State<GestionUsuariosPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Gestion de Usuarios'),
          backgroundColor: const Color(0xFFDCE9FD),
          foregroundColor: Colors.black,
          automaticallyImplyLeading: false,
        ),
      body: Container(
        color:const Color(0xFFDCE9FD),
        padding: const EdgeInsets.all(50.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: ToggleButtons(
              isSelected: [selectedIndex == 0, selectedIndex == 1],
              onPressed: (int index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              fillColor: Colors.blue,
              selectedColor: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 26.0),
                  child: Text('Crear'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Resetear'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          // Muestra la vista según el botón seleccionado
          Expanded(
            child: selectedIndex == 0 ? const CrearUsuario() : const ResetearUsuarioPage(),
          ),
        ]),
      ),
    );
  }
}
