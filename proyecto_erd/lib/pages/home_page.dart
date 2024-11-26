import 'package:flutter/material.dart';
import 'package:proyecto_erd/pages/dashboard_page.dart';
import 'package:proyecto_erd/pages/gestion_precios_page.dart';
import 'package:proyecto_erd/pages/gestion_usuarios_page.dart';
import 'package:proyecto_erd/pages/question_page.dart';

class HomePage extends StatefulWidget {

  final String username; // Recibe el atributo desde LoginPage

  const HomePage({super.key, required this.username}); // Constructor para recibir el username

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // Pasamos el username a DashboardPage
    _pages = [
      DashboardPage(username: widget.username), // Se pasa el username
      GestionPreciosPage(),
      const GestionUsuariosPage(),
      const QuestionPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Mostrar la página seleccionada
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Precios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Usuarios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Ayuda',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:const Color.fromARGB(255, 40, 74, 127), // Color cuando está seleccionado
        unselectedItemColor: Colors.grey, // Color cuando no está seleccionado
        onTap: _onItemTapped,
      ),
    );
  }
}

// Ejemplo de las páginas

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Página 3'),
    );
  }
}
