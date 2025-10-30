// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'repartidor_screen.dart';
import 'supervisor_screen.dart';
import 'package:provider/provider.dart'; // <-- Importa provider
import '../providers/pedidos_provider.dart'; // <-- Importa el provider

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('GreenGo Logistics'),
          actions: [
            // <-- AÑADE ESTA SECCIÓN
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Resetear datos',
              onPressed: () {
                // Llama a la función de reseteo
                Provider.of<PedidosProvider>(
                  context,
                  listen: false,
                ).resetPedidos();
              },
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.delivery_dining), text: 'Repartidor'),
              Tab(icon: Icon(Icons.supervisor_account), text: 'Supervisor'),
            ],
          ),
        ),
        body: TabBarView(children: [RepartidorScreen(), SupervisorScreen()]),
      ),
    );
  }
}
