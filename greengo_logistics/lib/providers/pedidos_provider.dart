// lib/providers/pedidos_provider.dart
import 'package:flutter/material.dart';
import '../models/pedido_model.dart';

class PedidosProvider with ChangeNotifier {
  List<Pedido> _pedidos = [
    Pedido(id: '1', producto: 'Paquete A', direccion: 'Calle Falsa 123'),
    Pedido(id: '2', producto: 'Sobre B', direccion: 'Avenida Siempre Viva 742'),
    Pedido(id: '3', producto: 'Caja C', direccion: 'Carrera 8 con 15'),
    Pedido(id: '4', producto: 'Documentos D', direccion: 'Transversal 5 # 45 - 10'),
    Pedido(id: '5', producto: 'Paquete E', direccion: 'Diagonal 22 con 68'),
  ];

  List<Pedido> get pedidos => _pedidos;

  List<Pedido> get pedidosPendientes => _pedidos.where((p) => !p.completado).toList();

  List<Pedido> get pedidosCompletados => _pedidos.where((p) => p.completado).toList();

  double get porcentajeCompletado {
    if (_pedidos.isEmpty) return 0;
    return (_pedidos.where((p) => p.completado).length / _pedidos.length) * 100;
  }

  void marcarComoEntregado(String id) {
    final index = _pedidos.indexWhere((pedido) => pedido.id == id);
    if (index != -1) {
      _pedidos[index].completado = true;
      notifyListeners(); // Notifica a los widgets que escuchan para que se redibujen.
    }
  }
}