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
          const SizedBox(height: 50.0),
          const Text(
              'Por favor ingrese el nombre de usuario del cliente que desea resetear'),
          const SizedBox(height: 40.0),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Usuario',
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
                child: const Text('Resetear'),
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
    );
  }
}
