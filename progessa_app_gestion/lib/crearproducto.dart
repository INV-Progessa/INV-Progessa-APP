import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CrearInsumoPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  String? _categoriaSeleccionada;

  // Función para enviar datos a la API
  Future<void> _crearInsumo() async {
    final url = ''; // URL vacía por ahora
    if (url.isEmpty) {
      // Si la URL está vacía, simplemente no hace nada
      print('URL no configurada, no se enviaron los datos');
      return;
    }

    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'nombre': _nombreController.text,
        'descripcion': _descripcionController.text,
        'codigo': _codigoController.text,
        'cantidad': int.parse(_cantidadController.text),
        'categoria': _categoriaSeleccionada,
      }),
    );

    if (response.statusCode == 201) {
      // Insumo creado con éxito
      print('Insumo creado con éxito');
    } else {
      // Error al crear el insumo
      print('Error al crear insumo: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Insumo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre del insumo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un nombre';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _descripcionController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una descripción';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _codigoController,
                decoration: InputDecoration(
                  labelText: 'Código',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un código';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _cantidadController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Cantidad',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la cantidad';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor ingresa un número válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Categoría',
                  border: OutlineInputBorder(),
                ),
                items: <String>['Categoría 1', 'Categoría 2', 'Categoría 3']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  _categoriaSeleccionada = newValue;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor selecciona una categoría';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _crearInsumo(); // Llama a la función para crear el insumo
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Insumo creado con éxito')),
                      );
                    }
                  },
                  child: Text('Crear insumo'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
