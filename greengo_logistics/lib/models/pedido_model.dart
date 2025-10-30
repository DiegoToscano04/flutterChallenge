// lib/models/pedido_model.dart
class Pedido {
  final String id;
  final String producto;
  final String direccion;
  bool completado;

  Pedido({
    required this.id,
    required this.producto,
    required this.direccion,
    this.completado = false,
  });
}