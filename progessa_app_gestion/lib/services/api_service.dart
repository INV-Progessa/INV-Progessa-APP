// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://inv-progessa-api.glitch.me/';

  // Método para iniciar sesión
  Future<Map<String, dynamic>> iniciarSesion(String email, String password) async {
    final url = Uri.parse('${baseUrl}login');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'correo_electronico': email,
        'contrasena': password,
      }),
    );

    if (response.statusCode == 200) {
      // Decodificar la respuesta JSON
      final Map<String, dynamic> data = jsonDecode(response.body);
      final Map<String, dynamic> usuario = data['usuario'];

      // Extraer el id_usuario e id_rol
      final int idUsuario = usuario['id_usuario'];
      final int idRol = usuario['id_rol'];

      return {
        'id_usuario': idUsuario,
        'id_rol': idRol,
        'nombre_usuario': usuario['nombre_usuario'],
        'correo_electronico': usuario['correo_electronico']
      };
    } else if (response.statusCode == 401) {
      // Si las credenciales no son correctas
      throw Exception('Correo o contraseña incorrectos');
    } else {
      // Otro error en la solicitud
      throw Exception('Error al procesar la solicitud');
    }
  }

  // Método para obtener categorías con POST
  Future<List<dynamic>> obtenerCategorias() async {
    final url = Uri.parse('${baseUrl}insumo_categorias');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({}), // Si necesitas enviar un cuerpo vacío
    );

    if (response.statusCode == 200) {
      // Decodificar la respuesta JSON
      final List<dynamic> categorias = jsonDecode(response.body);
      return categorias;
    } else {
      // Manejar otros errores
      throw Exception('Error al obtener las categorías');
    }
  }
}
