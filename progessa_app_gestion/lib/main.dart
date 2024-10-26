import 'package:flutter/material.dart';
import 'bodegero.dart'; // Importa el archivo bodeguero.dart
import 'services/api_service.dart' as ApiService;

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
  int _idUsuario = 0;
  int _idRol = 0;

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Método para manejar el inicio de sesión
  Future<void> _handleLogin() async {
    final email = _userController.text;
    final password = _passwordController.text;
    
    try {
      // Esperar la respuesta de la API
      final result = await ApiService.ApiService().iniciarSesion(email, password);
      print(result); // Imprimir el resultado de la API

      // Actualizar el estado con el idUsuario e idRol obtenidos
      setState(() {
        _idRol = result['id_rol'];
        _idUsuario = result['id_usuario'];
      });

      // Comprobación del rol después de actualizar el estado
      if (_idRol == 1) {
        print("Usuario Administrador");
      } else if (_idRol == 2) {
        print("Usuario Asistente");
      } else if (_idRol == 3) {
        print("Usuario Bodega");
        Navigator.pushNamed(context, '/bodeguero');
      }
    } catch (error) {
      // Manejo de errores
      print("Error en inicio de sesión: $error");
    }
  }

  @override
  Widget build(BuildContext context){
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
              _handleLogin();
            },
            child: Text('Ingresar'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Este botón lo coloqué para probar la otra página, ya que como no está programada la autenticación voy manual a la otra página para verla 
              Navigator.pushNamed(context, '/bodeguero');
            },
            child: Text('Ir a Bodeguero'),
          ),
        ],
      ),
    );
  }
}
