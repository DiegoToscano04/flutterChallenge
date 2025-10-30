// lib/providers/pedidos_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/pedido_model.dart';

class PedidosProvider with ChangeNotifier {
  List<Pedido> _pedidos = []; // La lista empieza vacía

  PedidosProvider() {
    // Cuando el provider se crea, intentamos cargar los datos guardados
    _loadPedidos();
  }

  List<Pedido> get pedidos => _pedidos;
  List<Pedido> get pedidosPendientes =>
      _pedidos.where((p) => !p.completado).toList();
  List<Pedido> get pedidosCompletados =>
      _pedidos.where((p) => p.completado).toList();

  double get porcentajeCompletado {
    if (_pedidos.isEmpty) return 0;
    return (_pedidos.where((p) => p.completado).length / _pedidos.length) * 100;
  }

  void marcarComoEntregado(String id) {
    final index = _pedidos.indexWhere((pedido) => pedido.id == id);
    if (index != -1) {
      _pedidos[index].completado = true;
      _savePedidos(); // Guardamos el estado cada vez que se marca uno
      notifyListeners();
    }
  }

  Future<void> resetPedidos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('pedidos_data'); // Borra los datos guardados
    _pedidos = _getInitialData(); // Carga los datos iniciales de nuevo
    notifyListeners();
  }

  Future<void> _savePedidos() async {
    final prefs = await SharedPreferences.getInstance();
    // Convertimos la lista de objetos Pedido a una lista de Mapas
    final List<Map<String, dynamic>> data = _pedidos
        .map(
          (pedido) => {
            'id': pedido.id,
            'producto': pedido.producto,
            'direccion': pedido.direccion,
            'completado': pedido.completado,
          },
        )
        .toList();
    // Lo guardamos como un String en formato JSON
    prefs.setString('pedidos_data', json.encode(data));
  }

  Future<void> _loadPedidos() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('pedidos_data')) {
      // Si no hay datos guardados, cargamos los datos iniciales
      _pedidos = _getInitialData();
    } else {
      final extractedData =
          json.decode(prefs.getString('pedidos_data')!) as List<dynamic>;
      _pedidos = extractedData
          .map(
            (item) => Pedido(
              id: item['id'],
              producto: item['producto'],
              direccion: item['direccion'],
              completado: item['completado'],
            ),
          )
          .toList();
    }
    notifyListeners();
  }

  List<Pedido> _getInitialData() {
    return [
      Pedido(id: '1', producto: 'Paquete A', direccion: 'Calle Falsa 123'),
      Pedido(
        id: '2',
        producto: 'Sobre B',
        direccion: 'Avenida Siempre Viva 742',
      ),
      Pedido(id: '3', producto: 'Caja C', direccion: 'Carrera 8 con 15'),
      Pedido(
        id: '4',
        producto: 'Documentos D',
        direccion: 'Transversal 5 # 45 - 10',
      ),
      Pedido(id: '5', producto: 'Paquete E', direccion: 'Diagonal 22 con 68'),
    ];
  }
}
