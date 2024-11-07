import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/category_provider.dart';
import '../services/api_service.dart';
import 'barcode_scanner.dart';

class CrearInsumoPage extends StatefulWidget {
  @override
  _CrearInsumoPageState createState() => _CrearInsumoPageState();
}

class _CrearInsumoPageState extends State<CrearInsumoPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  int? _categoriaSeleccionada;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<CategoryProvider>(context, listen: false).fetchCategories());
  }

  Future<void> _crearInsumo() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final idUsuarioCreador = authProvider.idUsuario;

    if (_formKey.currentState!.validate() && idUsuarioCreador != null) {
      try {
        await ApiService().crearInsumo(
          _nombreController.text,
          _descripcionController.text,
          _codigoController.text,
          int.parse(_cantidadController.text),
          _categoriaSeleccionada!,
          idUsuarioCreador,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Insumo creado con éxito')),
        );
      } catch (e) {
        print('Error al crear insumo: $e');
      }
    }
  }

  Future<void> _scanBarcode() async {
    final scannedCode = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BarcodeScannerPage(),
      ),
    );

    if (scannedCode != null) {
      setState(() {
        _codigoController.text = scannedCode;
      });
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    _codigoController.dispose();
    _cantidadController.dispose();
    super.dispose();
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
                  suffixIcon: IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: _scanBarcode,
                  ),
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
              Consumer<CategoryProvider>(
                builder: (context, categoryProvider, child) {
                  return DropdownButtonFormField<int>(
                    decoration: InputDecoration(
                      labelText: 'Categoría',
                      border: OutlineInputBorder(),
                    ),
                    items: categoryProvider.categories
                        .map((category) => DropdownMenuItem<int>(
                              value: category['id_categoria'],
                              child: Text(category['descripcion_categoria']),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _categoriaSeleccionada = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Por favor selecciona una categoría';
                      }
                      return null;
                    },
                  );
                },
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _crearInsumo,
                  child: Text(
                    'Crear insumo',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
