import 'package:flutter/material.dart';
import '../services/api_service.dart';

class InsumosProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _insumos = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get insumos => _insumos;
  bool get isLoading => _isLoading;

  // Método para obtener insumos desde el API
  Future<void> fetchInsumos() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Llama a listarInsumos y asigna la respuesta a _insumos
      final List<Map<String, dynamic>> insumos = await ApiService().listarInsumos();
      _insumos = insumos.map((e) => Map<String, dynamic>.from(e)).toList();
      print("Insumos guardados en el proveedor: $_insumos");
    } catch (error) {
      print("Error al obtener los insumos: $error");
    }

    _isLoading = false;
    notifyListeners();
  }
}
