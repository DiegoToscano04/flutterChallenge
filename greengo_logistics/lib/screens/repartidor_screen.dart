// lib/screens/repartidor_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pedidos_provider.dart';
import '../models/pedido_model.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart'; 

class RepartidorScreen extends StatefulWidget {
  const RepartidorScreen({super.key});

  @override
  State<RepartidorScreen> createState() => _RepartidorScreenState();
}

class _RepartidorScreenState extends State<RepartidorScreen> {
  // 1. La "llave" para controlar nuestra AnimatedList
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void _marcarComoEntregado(Pedido pedido, int index) {
    // Obtenemos el provider sin escuchar cambios para usarlo en callbacks
    final pedidosProvider = Provider.of<PedidosProvider>(context, listen: false);

    Vibrate.feedback(FeedbackType.success);
    // 2. Animación de eliminación
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildItem(pedido, animation, index),
      duration: const Duration(milliseconds: 300),
    );

    // 3. Esperamos un poco a que la animación termine antes de actualizar el estado
    Future.delayed(const Duration(milliseconds: 350), () {
      pedidosProvider.marcarComoEntregado(pedido.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${pedido.producto} marcado como entregado.'),
          backgroundColor: Colors.green[700],
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  // Widget para construir cada elemento de la lista con su animación
  Widget _buildItem(Pedido pedido, Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              child: Icon(
                Icons.inventory_2,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            title: Text(pedido.producto, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(pedido.direccion),
            trailing: IconButton(
              icon: Icon(Icons.check_circle_outline, color: Colors.green[600], size: 30),
              onPressed: () => _marcarComoEntregado(pedido, index),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Usamos un Consumer para que solo la lista se reconstruya cuando cambian los datos
    return Consumer<PedidosProvider>(
      builder: (context, pedidosProvider, child) {
        final pedidosPendientes = pedidosProvider.pedidosPendientes;

        if (pedidosPendientes.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.done_all, size: 80, color: Colors.green[600]),
                const SizedBox(height: 16),
                Text(
                  '¡No hay entregas pendientes!',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          );
        }

        return AnimatedList(
          key: _listKey,
          initialItemCount: pedidosPendientes.length,
          itemBuilder: (context, index, animation) {
            final pedido = pedidosPendientes[index];
            return _buildItem(pedido, animation, index);
          },
        );
      },
    );
  }
}