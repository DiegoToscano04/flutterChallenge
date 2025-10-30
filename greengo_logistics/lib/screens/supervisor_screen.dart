// lib/screens/supervisor_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pedidos_provider.dart';
import 'package:rive/rive.dart';

class SupervisorScreen extends StatelessWidget {
  const SupervisorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pedidosProvider = Provider.of<PedidosProvider>(context);
    final todosLosPedidos = pedidosProvider.pedidos;
    final porcentaje = pedidosProvider.porcentajeCompletado;

    // Condición para mostrar la vista de "Completado"
    if (porcentaje == 100.0) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 40.0,
                horizontal: 20.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.task_alt, color: Colors.green[600], size: 80),
                  const SizedBox(height: 20),
                  Text(
                    '¡Excelente trabajo!',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Todas las entregas se han completado exitosamente.',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Vista normal si no se ha completado el 100%
    return Column(
      children: [
        const SizedBox(
          height: 120,
          width: double.infinity,
          child: RiveAnimation.asset(
            'assets/4865-9839-delivery-guy-scooter.riv',
            animations: ['Move'],
            fit: BoxFit.none,
          ),
        ),

        Card(
          margin: const EdgeInsets.fromLTRB(
            15,
            0,
            15,
            15,
          ), // Reducimos el margen superior de la tarjeta
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Progreso de Entregas',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                LinearProgressIndicator(
                  value: porcentaje / 100,
                  minHeight: 12,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[600]!),
                  borderRadius: BorderRadius.circular(6),
                ),
                const SizedBox(height: 10),
                Text(
                  '${porcentaje.toStringAsFixed(1)}% Completado',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ),

        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 10),
            itemCount: todosLosPedidos.length,
            itemBuilder: (ctx, i) {
              final pedido = todosLosPedidos[i];
              return Opacity(
                opacity: pedido.completado ? 0.6 : 1.0,
                child: Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: pedido.completado
                          ? Colors.grey
                          : Theme.of(
                              context,
                            ).colorScheme.primary, // Azul del tema
                      child: Icon(
                        pedido.completado ? Icons.check : Icons.inventory_2,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      pedido.producto,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: pedido.completado
                            ? Colors.grey[700]
                            : Colors.black87,
                        decoration: pedido.completado
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    subtitle: Text(pedido.direccion),
                    trailing: pedido.completado
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.green[600],
                            size: 30,
                          )
                        : const Icon(
                            Icons.radio_button_unchecked,
                            color: Colors.grey,
                          ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
