import 'package:hive/hive.dart';
import 'package:starwars/domain/entities/connetivity.dart';

part 'connecitivity_model.g.dart';

/// Modelo de la clase Connectivity
@HiveType(typeId: 0)
class ConnectivityModel {
  /// Constructor de la clase
  ConnectivityModel({required this.hasConnection});

  /// Indica si hay conexión
  @HiveField(0)
  final bool hasConnection;

  /// Convierte un objeto json en una instancia de la clase Connectivity
  factory ConnectivityModel.fromJson(Map<dynamic, dynamic> json) {
    return ConnectivityModel(
      hasConnection: json['hasConnection'] as bool,
    );
  }

  /// Convierte una instancia de la clase Connectivity en un objeto json
  Map<String, dynamic> toJson() => {
        'hasConnection': hasConnection,
      };

  /// Convierte un modelo a una entidad
  Connectivity toEntity() => Connectivity(
        hasConnection: hasConnection,
      );
}
