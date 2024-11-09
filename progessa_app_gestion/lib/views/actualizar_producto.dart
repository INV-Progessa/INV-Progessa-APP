import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/insumos_provider.dart';
import '../services/api_service.dart';
import 'barcode_scanner.dart';

class ActualizarInsumoPage extends StatefulWidget {
  @override
  _ActualizarInsumoPageState createState() => _ActualizarInsumoPageState();
}

class _ActualizarInsumoPageState extends State<ActualizarInsumoPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _nombreProductoController = TextEditingController();
  String? _codigoBarra;
  Map<String, dynamic>? _insumoData;

  @override
  void dispose() {
    _cantidadController.dispose();
    _nombreProductoController.dispose();
    super.dispose();
  }

  Future<void> _scanBarcode() async {
    final insumosProvider = Provider.of<InsumosProvider>(context, listen: false);
    await insumosProvider.fetchInsumos();

    final scannedCode = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BarcodeScannerPage(),
      ),
    );

    if (scannedCode != null) {
      setState(() {
        _codigoBarra = scannedCode;
      });
      _buscarInsumo();
    }
  }

  Future<void> _buscarInsumo() async {
    final insumosProvider = Provider.of<InsumosProvider>(context, listen: false);
    await insumosProvider.fetchInsumos();

    final insumo = insumosProvider.insumos.firstWhere(
      (element) => element['codigo_barra'] == _codigoBarra,
      orElse: () => <String, dynamic>{},
    );

    if (insumo.isNotEmpty) {
      setState(() {
        _insumoData = insumo;
        _nombreProductoController.text = insumo['nombre'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Producto no encontrado')),
      );
    }
  }

  Future<void> _actualizarInsumo() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final idUsuarioModificador = authProvider.idUsuario;

    if (_formKey.currentState!.validate() && _codigoBarra != null && idUsuarioModificador != null) {
      try {
        await ApiService().actualizarInsumo(
          _codigoBarra!,
          int.parse(_cantidadController.text),
          idUsuarioModificador,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Insumo actualizado con éxito')),
        );
      } catch (e) {
        print('Error al actualizar insumo: $e');
      }
    }

    _nombreProductoController.text = "";

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar Insumo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nombreProductoController,
                decoration: InputDecoration(
                  labelText: 'Nombre del Producto',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _cantidadController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Cantidad Nueva',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la nueva cantidad';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor ingresa un número válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _scanBarcode,
                  icon: Icon(Icons.camera_alt),
                  label: Text('Escanear Código de Barras'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 48), // Tamaño igual que el botón de actualizar
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _actualizarInsumo,
                  child: Text(
                    'Actualizar Insumo',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 48), // Tamaño del botón de actualizar
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
