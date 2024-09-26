import 'package:flutter/material.dart';
import 'package:proyecto_erd/Controllers/user_controller.dart';
import 'package:proyecto_erd/pages/dashboard_page.dart';

class LoginPage extends StatefulWidget {
  @override
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

  final UserController _userController = UserController();

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;


    if (_userController.login(username, password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Inicio de sesión exitoso')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardPage(username: username),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Credenciales inválidas')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ERP Siesa Enterprise', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
        centerTitle: true,
        backgroundColor: Color(0xFFDCE9FD),
      ),
      body:Container(
        // Aplicar el color de fondo a toda la pantalla
        color: Color(0xFFDCE9FD),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "INICIO DE SESIÓN",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: _togglePasswordVisibility, // Alternar visibilidad
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Iniciar sesión'), 
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xAA0920EA), // Color de fondo personalizado
                
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 24), // Espacio dentro del botón
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50), // Bordes redondeados opcionales
                ),
                foregroundColor: Colors.white
              ),
            ),
          ],
        ),
      ),
    );
  }
}
