// lib/screens/repartidor_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pedidos_provider.dart';

class RepartidorScreen extends StatelessWidget {
  const RepartidorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pedidosProvider = Provider.of<PedidosProvider>(context);
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
    
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: pedidosPendientes.length,
      itemBuilder: (ctx, i) {
        final pedido = pedidosPendientes[i];
        return Card(
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
              icon: Icon(
                Icons.check_circle_outline,
                color: Colors.green[600],
                size: 30,
              ),
              onPressed: () {
                pedidosProvider.marcarComoEntregado(pedido.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${pedido.producto} marcado como entregado.'),
                    backgroundColor: Colors.green[700],
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}