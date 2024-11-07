import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/category_provider.dart'; // Importa el CategoryProvider
import 'providers/insumos_provider.dart';
import 'views/login_page.dart';
import 'views/bodeguero.dart'; // Asegúrate de tener importada esta página
import 'views/crear_producto.dart';
import 'views/barcode_scanner.dart';
import 'views/actualizar_producto.dart';
import 'views/lista_productos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => InsumosProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        routes: {
          '/': (context) => LoginPage(),
          '/bodeguero': (context) => BodegueroPage(),
          '/crear_producto': (context) => CrearInsumoPage(),
          '/scanner' : (context) => BarcodeScannerPage(),
          '/actualizar_insumo' : (context) => ActualizarInsumoPage(),
          '/lista_insumo' : (context) => ListaInsumosPage(),
        },
        initialRoute: '/',
      ),
    );
  }
}
