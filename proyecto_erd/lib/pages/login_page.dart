import 'package:flutter/material.dart';
import 'package:proyecto_erd/pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Future<void> _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Crear el cuerpo del request
    Map<String, String> body = {
      'username': username,
      'password': password,
    };

    try {
      // Hacer la petición POST
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        // Suponiendo que la respuesta incluye un token o un mensaje de éxito
        final responseData = json.decode(response.body);

        // ignore: unused_local_variable
        String accessToken = responseData['access_token'];
        // ignore: unused_local_variable
        String tokenType = responseData['token_type'];
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Inicio de sesión exitoso')),
        );

        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(username: username),
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credenciales inválidas')),
        );
      }
    } catch (e) {
        // Manejar errores de red
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de red: $e')),
      );
    }
  }

  // final UserController _userController = UserController();

  // void _login() {
  //   String username = _usernameController.text;
  //   String password = _passwordController.text;


  //   if (_userController.login(username, password)) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Inicio de sesión exitoso')),
  //     );

  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => HomePage(username: username),
  //       ),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Credenciales inválidas')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ERP Siesa Enterprise', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
        centerTitle: true,
        backgroundColor: const Color(0xFFDCE9FD),
      ),
      body:Container(
        // Aplicar el color de fondo a toda la pantalla
        color: const Color(0xFFDCE9FD),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "INICIO DE SESIÓN",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: _togglePasswordVisibility, // Alternar visibilidad
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Color de fondo personalizado
                padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(50), // Bordes redondeados opcionales
                ),
                foregroundColor: Colors.white
              ),
              child: const Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
