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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 50.0), // Añade espacio superior
              child: Center(
                child: Image.asset(
                  'assets/FONDO.png', // Ruta de la imagen
                  alignment:
                      Alignment.center, // Centra la imagen horizontalmente
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 40),
                SizedBox(
                  width: 200, // Ancho fijo para el botón
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 20), // Ajustar padding
                      textStyle: TextStyle(fontSize: 25),
                      side: BorderSide(
                        color: Colors.black, // Color del contorno
                        width: 2, // Grosor del contorno
                      ),
                    ),
                    child: Text('Iniciar sesión'),
                  ),
                ),
                SizedBox(height: 40), // Añadir espacio entre botones
                SizedBox(
                  width: 200, // Ancho fijo para el botón
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      textStyle: TextStyle(fontSize: 25),
                      side: BorderSide(
                        color: Colors.black, // Color del contorno
                        width: 2, // Grosor del contorno
                      ),
                    ),
                    child: Text('Registrarse'),
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Color(0xFF124673), // Color del footer
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Sistema avanzado de gestión de insumos',
              textAlign: TextAlign.center, // Centra el texto
              style: TextStyle(
                  color: Colors.white), // Texto en blanco para contrastar
            ),
          ),
        ),
      ),
    );
  }
}
