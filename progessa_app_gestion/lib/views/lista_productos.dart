import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';
import '../providers/insumos_provider.dart';

class ListaInsumosPage extends StatefulWidget {
  @override
  _ListaInsumosPageState createState() => _ListaInsumosPageState();
}

class _ListaInsumosPageState extends State<ListaInsumosPage> {
  @override
  void initState() {
    super.initState();
    _loadInsumos();
  }

  Future<void> _loadInsumos() async {
    final insumosProvider = Provider.of<InsumosProvider>(context, listen: false);
    await insumosProvider.fetchInsumos();
  }

  String _formatDate(String? date) {
    if (date == null) return 'N/A';
    try {
      final DateTime parsedDate = DateTime.parse(date);
      return DateFormat('dd-MM-yyyy').format(parsedDate);
    } catch (e) {
      return 'Fecha inválida';
    }
  }

  Future<void> _exportToExcel() async {
    // Verificar y solicitar permisos de almacenamiento
    if (await Permission.storage.request().isGranted) {
      final insumosProvider = Provider.of<InsumosProvider>(context, listen: false);
      var excel = Excel.createExcel();
       // Eliminar la hoja predeterminada "Sheet1"
      final sheet = excel['Insumos'];
      excel.delete('Sheet1');

      // Agregar encabezados
      sheet.appendRow([
        TextCellValue('Nombre'),
        TextCellValue('Categoría'),
        TextCellValue('Código de Barra'),
        TextCellValue('Cantidad Disponible'),
        TextCellValue('Fecha de Creación'),
        TextCellValue('Última Modificación')
      ]);

      // Agregar datos de cada insumo
      for (var insumo in insumosProvider.insumos) {
        sheet.appendRow([
          TextCellValue(insumo['nombre'] ?? ''),
          TextCellValue(insumo['descripcion_categoria'] ?? ''),
          TextCellValue(insumo['codigo_barra'] ?? ''),
          TextCellValue(insumo['cantidad_disponible']?.toString() ?? '0'),
          TextCellValue(_formatDate(insumo['fecha_creacion'])),
          TextCellValue(_formatDate(insumo['fecha_modificacion'])),
        ]);
      }

      // Guardar el archivo Excel en una ubicación accesible
      final directory = await getExternalStorageDirectory();
      if (directory != null) {
        final path = '${directory.path}/insumos_export.xlsx';
        final File file = File(path)
          ..createSync(recursive: true)
          ..writeAsBytesSync(excel.encode()!);

        // Abrir el archivo automáticamente
        await OpenFile.open(path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se pudo acceder a la ubicación de almacenamiento')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permiso de almacenamiento denegado')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final insumosProvider = Provider.of<InsumosProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Lista de Insumos'),
            IconButton(
              icon: Icon(Icons.download),
              onPressed: _exportToExcel,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: insumosProvider.insumos.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: insumosProvider.insumos.length,
                itemBuilder: (context, index) {
                  final insumo = insumosProvider.insumos[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            insumo['nombre'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Categoría: ${insumo['descripcion_categoria']}',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Código de Barra: ${insumo['codigo_barra']}',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Cantidad Disponible: ${insumo['cantidad_disponible']}',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Fecha de Creación: ${_formatDate(insumo['fecha_creacion'])}',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Última Modificación: ${_formatDate(insumo['fecha_modificacion'])}',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
