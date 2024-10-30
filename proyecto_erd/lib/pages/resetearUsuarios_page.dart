import 'package:flutter/material.dart'; 

class ResetearUsuarioPage extends StatefulWidget {
  const ResetearUsuarioPage({super.key});

  @override
  State<ResetearUsuarioPage> createState() => _ResetearUsuarioPageState();
}

class _ResetearUsuarioPageState extends State<ResetearUsuarioPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 50.0),
          Text(
              'Por favor ingrese el nombre de usuario del cliente que desea resetear'),
          SizedBox(height: 40.0),
          TextField(
            decoration: InputDecoration(
              labelText: 'Usuario',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text('Resetear'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(173, 9, 32, 234),
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
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
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
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
