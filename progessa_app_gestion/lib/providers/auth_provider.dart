import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AuthProvider extends ChangeNotifier {
  int? _idUsuario;
  int? _idRol;

  int? get idUsuario => _idUsuario;
  int? get idRol => _idRol;

  // Método para manejar el inicio de sesión
  Future<void> iniciarSesion(String email, String password) async {
    try {
      // Llamada al servicio de autenticación de la API
      final result = await ApiService().iniciarSesion(email, password);
      _idUsuario = result['id_usuario'];
      _idRol = result['id_rol'];
      
      // Notificar a los listeners para actualizar el estado en la UI
      notifyListeners();
    } catch (error) {
      print("Error en inicio de sesión: $error");
      throw error;
    }
  }

  void cerrarSesion() {
    _idUsuario = null;
    _idRol = null;
    notifyListeners();
  }
}
