import 'package:flutter/material.dart';

class GestionPreciosPage extends StatefulWidget {
  const GestionPreciosPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GestionPreciosPage createState() => _GestionPreciosPage();
}

class _GestionPreciosPage extends State<GestionPreciosPage> {
  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _productoController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion de Precios'),
        backgroundColor:const Color(0xFFDCE9FD),
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      resizeToAvoidBottomInset: true, // Evita el espacio en blanco al abrir el teclado
      body: Container(
        height: MediaQuery.of(context).size.height, // Asegura que el contenedor ocupe toda la pantalla
        color: const Color(0xFFDCE9FD),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(height: 50.0),
              const Text(
                'Por favor ingrese el código del producto para cambiar su precio',
              ),
              const SizedBox(height: 40.0),
              TextField(
                controller: _codigoController,
                decoration: const InputDecoration(
                  labelText: 'Codigo',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _productoController,
                decoration: const InputDecoration(
                  labelText: 'Producto',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _precioController,
                decoration: const InputDecoration(
                  labelText: 'Precio',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Guardar'),
                  ),
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(12, 13, 9, 234),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('Cancelar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
