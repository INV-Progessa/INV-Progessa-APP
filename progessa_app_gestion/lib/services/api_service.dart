// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://inv-progessa-api.glitch.me/';

  // Método para iniciar sesión
  Future<Map<String, dynamic>> iniciarSesion(
      String email, String password) async {
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
      body: jsonEncode({}), // Cuerpo vacío
    );

    if (response.statusCode == 200) {
      // Decodificamos la respuesta JSON
      final Map<String, dynamic> data = jsonDecode(response.body);

      // Extraemos la lista de categorías de la respuesta
      if (data.containsKey('categorias')) {
        return data['categorias'] as List<dynamic>;
      } else {
        throw Exception('La respuesta no contiene el campo "categorias"');
      }
    } else {
      // Manejar otros errores
      throw Exception('Error al obtener las categorías');
    }
  }

  // Método para crear un insumo
  Future<void> crearInsumo(
      String nombre,
      String descripcion,
      String codigoBarra,
      int cantidadDisponible,
      int idCategoria,
      int idUsuarioCreador) async {
    final url = Uri.parse(
        '${baseUrl}insumo_crear'); // Asegúrate de que esta URL sea correcta
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nombre': nombre,
        'descripcion': descripcion,
        'codigo_barra': codigoBarra,
        'cantidad_disponible': cantidadDisponible,
        'id_categoria': idCategoria,
        'id_usuario_creador': idUsuarioCreador,
      }),
    );

    if (response.statusCode == 201) {
      print('Insumo creado exitosamente');
    } else {
      throw Exception('Error al crear el insumo');
    }
  }

  // Método para actualizar un insumo
  Future<void> actualizarInsumo(String codigoBarra, int cantidadAgregada,
      int idUsuarioModificador) async {
    final url = Uri.parse(
        '${baseUrl}insumo_actualizar'); // Asegúrate de que esta URL sea correcta
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'codigo_barra': codigoBarra,
        'cantidad_agregada': cantidadAgregada,
        'id_usuario_modificador': idUsuarioModificador,
      }),
    );

    if (response.statusCode == 201) {
      print('Insumo actualizado exitosamente');
    } else {
      throw Exception('Error al actualizar el insumo');
    }
  }

  Future<List<Map<String, dynamic>>> listarInsumos() async {
    final url = Uri.parse('${baseUrl}insumo_listar');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({}), // Cuerpo vacío para el POST
    );

    if (response.statusCode == 200) {
      try {
        final List<dynamic> insumos = jsonDecode(response.body);
        return insumos.map((e) => Map<String, dynamic>.from(e)).toList();
      } catch (e) {
        print("Error al decodificar JSON: $e");
        throw Exception("Error al decodificar los datos de insumos");
      }
    } else {
      print("Error en la solicitud: Código ${response.statusCode}");
      print("Cuerpo de la respuesta: ${response.body}");
      throw Exception("Error al listar insumos: ${response.statusCode}");
    }
  }
}
