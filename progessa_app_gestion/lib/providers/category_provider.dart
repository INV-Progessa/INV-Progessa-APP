import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CategoryProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _categories = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get categories => _categories;
  bool get isLoading => _isLoading;

  // Método para obtener categorías desde el API
  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners(); // Notifica a los listeners que el estado de carga ha cambiado

    try {
      // Llamada al servicio para obtener categorías
      final response = await ApiService().obtenerCategorias();

      // Convertir la lista dinámica en una lista de mapas con clave-valor
      _categories = List<Map<String, dynamic>>.from(response);
    } catch (error) {
      print('Error al obtener categorías: $error');
      _categories = [];
      throw error; // Lanza el error para que pueda ser manejado por el consumidor del proveedor
    }

    _isLoading = false;
    notifyListeners(); // Notifica a los listeners para actualizar la UI
  }
}
