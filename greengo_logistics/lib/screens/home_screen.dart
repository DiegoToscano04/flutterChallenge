// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'repartidor_screen.dart';
import 'supervisor_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('GreenGo Logistics'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.delivery_dining), text: 'Repartidor'),
              Tab(icon: Icon(Icons.supervisor_account), text: 'Supervisor'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RepartidorScreen(),
            SupervisorScreen(),
          ],
        ),
      ),
    );
  }
}