import 'package:flutter/material.dart';

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
      home: Scaffold(
        backgroundColor: Color(0xFFF2F2F2), // Color de fondo del cuerpo
        body: LoginPage(), // Llama a la nueva página con el estado
        bottomNavigationBar: BottomAppBar(
          color: Color(0xFF124673), // Color del footer
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Sistema avanzado de gestión de insumos',
              textAlign: TextAlign.center, // Centra el texto
              style: TextStyle(color: Colors.white), // Texto en blanco para contrastar
            ),
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Creamos los controladores para usuario y contraseña
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // Limpiar los controladores cuando el widget se destruye
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0), // Añade espacio superior
          child: Center(
            child: Image.asset(
              'assets/FONDO.png', // Ruta de la imagen
              alignment: Alignment.center, // Centra la imagen horizontalmente
            ),
          ),
        ),
        Column(
          children: [
            Container(
              width: 300, // Controla el ancho del input
              child: TextField(
                controller: _userController, // Asigna el controlador
                decoration: InputDecoration(
                  labelText: 'Usuario',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 300, // Controla el ancho del input
              child: TextField(
                controller: _passwordController, // Asigna el controlador
                obscureText: true, // Oculta la contraseña
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
                String user = _userController.text;
                String password = _passwordController.text;

                // Aquí puedes manejar la lógica del inicio de sesión
                print('Usuario: $user');
                print('Contraseña: $password');
              },
              child: Text('Ingresar'),
            ),
          ],
        ),
      ],
    );
  }
}
