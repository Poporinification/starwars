import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starwars/domain/entities/character.dart';
import 'package:starwars/domain/entities/connetivity.dart';
import 'package:starwars/domain/use_cases/get_connectivity_status_use_case.dart';
import 'package:starwars/domain/use_cases/report_character_use_case.dart';

part 'report_button_state.dart';

/// Cubit para la pantalla de detalles del personaje
class ReportButtonCubit extends Cubit<ReportButtonState> {
  /// Constructor del cubit para la pantalla de detalles del personaje
  ReportButtonCubit({
    required this.reportCharacterUseCase,
    required this.getConnectivityStatusUseCase,
  }) : super(ReportButtonInitialState());

  /// Caso de uso para reportar un personaje
  final ReportCharacterUseCase reportCharacterUseCase;

  /// Caso de uso para obtener el estado de la conectividad
  final GetConnectivityStatusUseCase getConnectivityStatusUseCase;

  /// Reportar a un personaje
  Future<void> reportCharacter(Character character) async {
    try {
      emit(ReportingCharacter());
      await reportCharacterUseCase.execute(character);
      emit(CharacterReported());
    } catch (e) {
      emit(ErrorReportingCharacter('Error al reportar el personaje'));
    }
  }

  /// Obtiene el estado de la conectividad
  Future<void> getConnectivityStatus() async {
    try {
      emit(LoadingConnectivityStatus());
      final connectivity = await getConnectivityStatusUseCase.execute();
      emit(ConnectivityStatusLoaded(connectivity: connectivity));
    } catch (e) {
      emit(
        ErrorGettingConnectivityStatus(
          'Error al obtener el estado de la conectividad',
        ),
      );
    }
  }
}
