import 'package:flutter/material.dart';
import 'bodegero.dart'; // Importa el archivo bodeguero.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      
      // Aquí se definen las rutas
      routes: {
        '/': (context) => LoginPage(), // Página inicial
        '/bodeguero': (context) => BodegueroPage(), // Ruta para la página Bodeguero
      },
      
      initialRoute: '/', // Define cuál será la ruta inicial al cargar la app
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Center(
              child: Image.asset(
                'assets/FONDO.png', // Ruta de la imagen
                alignment: Alignment.center,
              ),
            ),
          ),
          Container(
            width: 300, 
            child: TextField(
              controller: _userController,
              decoration: InputDecoration(
                labelText: 'Usuario',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 300, 
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Lógica de inicio de sesión
              print('Usuario: ${_userController.text}');
              print('Contraseña: ${_passwordController.text}');
            },
            child: Text('Ingresar'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Este boton lo coloque para probar la otra hoja, ya que como no esta programado la autenticacion voy manual nomas a la otra hoja para verla 
              Navigator.pushNamed(context, '/bodeguero');
            },
            child: Text('Ir a Bodeguero'),
          ),
        ],
      ),
    );
  }
}
