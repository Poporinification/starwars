import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starwars/domain/entities/character.dart';
import 'package:starwars/domain/observable/connection_observable.dart';
import 'package:starwars/domain/observable/observer.dart';
import 'package:starwars/presentation/screens/details/cubit/report_button_cubit.dart';

/// Botón de reporte de personaje
class ReportButton extends StatefulWidget {
  /// Constructor for Details header widget
  const ReportButton({
    super.key,
    required Character character,
  }) : _character = character;

  final Character _character;

  @override
  State<ReportButton> createState() => _ReportButtonState();
}

class _ReportButtonState extends State<ReportButton> implements Observer {
  late ReportButtonCubit _cubit;

  bool _isReported = false;
  bool _hasConnection = false;
  final ConnectionObservable _connectionObservable = ConnectionObservable();

  @override
  void initState() {
    _cubit = BlocProvider.of<ReportButtonCubit>(context);
    _cubit.getConnectivityStatus();
    _isReported = widget._character.isReported;

    _connectionObservable.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    _connectionObservable.removeObserver(this);
    super.dispose();
  }

  @override
  void notifyChange({required bool newValue}) {
    setState(() => _hasConnection = newValue);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content:
            Text('Por seguridad, se ha deshabilitado el botón de reporte.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReportButtonCubit, ReportButtonState>(
      listener: _listener,
      child: _hasConnection
          ? IconButton(
              onPressed: () {
                if (!_isReported) {
                  _cubit.reportCharacter(widget._character);
                }
              },
              icon: Icon(
                Icons.report,
                color: _isReported ? Colors.red : Colors.grey[600],
              ),
              tooltip:
                  _isReported ? 'Personaje reportado' : 'Reportar personaje',
            )
          : Container(),
    );
  }

  void _listener(context, state) {
    if (state is CharacterReported) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Personaje reportado'),
        ),
      );
      setState(() {
        _isReported = widget._character.isReported;
      });
    }
    if (state is ConnectivityStatusLoaded) {
      setState(() {
        _hasConnection = state.connectivity.hasConnection;
      });
    }
  }
}
