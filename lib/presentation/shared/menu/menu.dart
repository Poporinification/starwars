import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starwars/domain/observable/connection_observable.dart';
import 'package:starwars/presentation/shared/menu/cubit/menu_cubit.dart';

/// Menú de la aplicación
class Menu extends StatefulWidget {
  /// Constructor del menú
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool _isConnected = false;

  final ConnectionObservable connectionObservable = ConnectionObservable();

  late MenuCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<MenuCubit>(context);
    _cubit.getConnectivityStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey[700],
            ),
            child: const Center(
              child: Text(
                'Star Wars',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          BlocConsumer<MenuCubit, MenuState>(
            listener: (context, state) {
              if (state is StoredConnectivityStatusLoaded) {
                setState(() {
                  _isConnected = state.isConnected;
                });
              }
            },
            builder: (context, state) {
              return SwitchListTile(
                title: Text(_isConnected ? 'Desconectar' : 'Conectar'),
                value: _isConnected,
                onChanged: (value) {
                  setState(() {
                    _isConnected = _cubit.toggleConnectivityStatus(
                      isConnected: value,
                      connectionObservable: connectionObservable,
                    );
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
