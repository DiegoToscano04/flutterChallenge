// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/pedidos_provider.dart';
import 'screens/home_screen.dart'; // Asegúrate de importar tu nueva pantalla

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PedidosProvider(),
      child: MaterialApp(
        title: 'GreenGo Logistics',
        
        // ---------- SECCIÓN DEL TEMA MEJORADO ----------
        theme: ThemeData(
          useMaterial3: true,
          
          // 1. Paleta de colores: Usaremos un azul como base.
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.light,
          ),

          // 2. Fondo de la app: Blanco limpio.
          scaffoldBackgroundColor: Colors.white,

          // 3. Estilo de las tarjetas: Sutil, con bordes redondeados.
          cardTheme: CardThemeData(
            elevation: 2,
            color: Colors.grey[50], // Un gris muy claro, casi blanco
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: BorderSide(color: Colors.grey[200]!, width: 1),
            ),
          ),
          
          // 4. Barra de Navegación (AppBar): Limpia, sin elevación.
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87, // Color de íconos y texto
            elevation: 0,
            surfaceTintColor: Colors.transparent,
          ),
          
          // 5. Barra de Pestañas (TabBar): Indicador azul.
          tabBarTheme: TabBarThemeData(
            labelColor: Colors.blue[800],
            unselectedLabelColor: Colors.grey[600],
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: Colors.blue[800]!, width: 3),
            ),
          ),
        ),
        // --------------------------------------------------
        
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}