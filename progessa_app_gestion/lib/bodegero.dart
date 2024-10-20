import 'package:flutter/material.dart';

class BodegueroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              SizedBox(height: 40),
              SizedBox(
                width: 260, // Ancho aumentado del botón
                child: ElevatedButton(
                  onPressed: () {
                    // Aquí puede ir la lógica para crear nuevo insumo
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20), // Mismo padding
                    textStyle: TextStyle(fontSize: 20), // Mismo tamaño de texto
                    side: BorderSide(
                      color: Colors.black, // Color del contorno
                      width: 2, // Grosor del contorno
                    ),
                  ),
                  child: Text('Crear nuevo insumo'),
                ),
              ),
              SizedBox(height: 40), // Añadir espacio entre botones
              SizedBox(
                width: 260, // Ancho aumentado del botón
                child: ElevatedButton(
                  onPressed: () {
                    // Aquí puede ir la lógica para ingresar un nuevo pedido
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20), // Mismo padding
                    textStyle: TextStyle(fontSize: 20), // Mismo tamaño de texto
                    side: BorderSide(
                      color: Colors.black, // Color del contorno
                      width: 2, // Grosor del contorno
                    ),
                  ),
                  child: Text('Ingresar nuevo pedido'),
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
              color: Colors.white, // Texto en blanco para contrastar
            ),
          ),
        ),
      ),
    );
  }
}
