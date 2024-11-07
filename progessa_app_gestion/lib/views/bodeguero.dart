import 'package:flutter/material.dart';
  // Asegúrate de importar la hoja crearproducto.dart

class BodegueroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 70.0), // Añade espacio superior
            child: Center(
              child: Image.asset(
                'assets/inventory.png', // Ruta de la imagen
                alignment: Alignment.center, 
                width: 230,// Centra la imagen horizontalmente
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 30),
              SizedBox(
                width: 250, // Ancho fijo para el botón
                child: ElevatedButton(
                  onPressed: () {
                    // Lógica para navegar a la página crearproducto.dart
                    Navigator.pushNamed(context, '/crear_producto');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20), // Mismo padding
                    textStyle: TextStyle(fontSize: 20), // Mismo tamaño de texto
                    side: BorderSide(
                      color: Colors.black, // Color del contorno
                      width: 2, // Grosor del contorno
                    ),
                  ),
                  child: Text('Crear Insumo'),
                ),
              ),
              SizedBox(height: 30), // Añadir espacio entre botones
              SizedBox(
                width: 250, // Ancho fijo para el botón
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/actualizar_insumo');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20), // Mismo padding
                    textStyle: TextStyle(fontSize: 20), // Mismo tamaño de texto
                    side: BorderSide(
                      color: Colors.black, // Color del contorno
                      width: 2, // Grosor del contorno
                    ),
                  ),
                  child: Text('Actualizar Insumo'),
                ),
              ),
              SizedBox(height: 30), // Añadir espacio entre botones
              SizedBox(
                width: 250, // Ancho fijo para el botón
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/lista_insumo');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20), // Mismo padding
                    textStyle: TextStyle(fontSize: 20), // Mismo tamaño de texto
                    side: BorderSide(
                      color: Colors.black, // Color del contorno
                      width: 2, // Grosor del contorno
                    ),
                  ),
                  child: Text('Lista de Insumos'),
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
            'Sistema Avanzado de Gestión de Insumos',
            textAlign: TextAlign.center, // Centra el texto
            style: TextStyle(
              color: Colors.white, // Texto en blanco para contrastar
            ),
          ),
        ),
      ),
    );
  }
}
