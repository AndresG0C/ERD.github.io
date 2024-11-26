import 'package:flutter/material.dart';

class CrearUsuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Añadir un SingleChildScrollView aquí
      child: Column(
        children: [
          SizedBox(height: 50.0),
          Text(
              'Por favor ingrese un nombre de usuario y una contraseña para el cliente'),
          SizedBox(height: 40.0),
          TextField(
            decoration: InputDecoration(
              labelText: 'Usuario',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 15.0),
          TextField(
            decoration: InputDecoration(
              labelText: 'Contraseña',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text('Crear'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                    EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  foregroundColor: Colors.white,
                ),
              ),
              SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: () {},
                child: Text('Cancelar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(12, 13, 9, 234),
                  padding:
                    EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  foregroundColor: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
