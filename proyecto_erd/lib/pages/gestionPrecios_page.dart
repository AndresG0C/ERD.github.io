import 'package:flutter/material.dart';

class GestionPreciosPage extends StatefulWidget {
  @override
  _GestionPreciosPage createState() => _GestionPreciosPage();
}

class _GestionPreciosPage extends State<GestionPreciosPage>{

  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _productoController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestion de Precios'),
        backgroundColor: const Color.fromARGB(255, 9, 32, 234),
        foregroundColor: Colors.white
      ),
      body: Container(
        color: Color(0xFFDCE9FD),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 50.0),
            Text(
              'Por favor ingrese el código del producto para cambiar su precio'
              ),
            SizedBox(height: 40.0),
            TextField(
              controller: _codigoController,
              decoration: InputDecoration(
                labelText: 'Codigo',
                border: OutlineInputBorder(), 
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _productoController,
              decoration: InputDecoration(
                labelText: 'Producto',
                border: OutlineInputBorder(), 
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _precioController,
              decoration: InputDecoration(
                labelText: 'Precio',
                border: OutlineInputBorder(), 
              ),
            ),
            SizedBox(height: 50.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                  },
                  child: Text('Guardar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(173, 9, 32, 234),
                
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    foregroundColor: Colors.white
                  ),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                  },
                  child: Text('Cancelar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(12, 13, 9, 234),
                
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    foregroundColor: Colors.black
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}