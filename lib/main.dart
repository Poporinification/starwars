import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:starwars/data/theme/app_theme.dart';
import 'package:starwars/di_module.dart';
import 'package:starwars/presentation/screens/details/cubit/character_details_cubit.dart';
import 'package:starwars/presentation/screens/details/cubit/report_button_cubit.dart';
import 'package:starwars/presentation/screens/list/character_list_screen.dart';
import 'package:starwars/presentation/screens/list/cubit/character_list_cubit.dart';
import 'package:starwars/presentation/shared/menu/cubit/menu_cubit.dart';

Future<void> main() async {
  /// Inicializa los Widgets de Flutter
  WidgetsFlutterBinding.ensureInitialized();

  /// Inicializa Hive
  Hive.init((await getApplicationDocumentsDirectory()).path);

  /// Configura la inyección de dependencias
  final di = await setupDependencyInjection();

  /// Ejecuta la aplicación
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.get<CharacterListCubit>()),
        BlocProvider(create: (_) => di.get<CharacterDetailsCubit>()),
        BlocProvider(create: (_) => di.get<ReportButtonCubit>()),
        BlocProvider(create: (_) => di.get<MenuCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Challenge Star Wars',
        theme: lightTheme,
        home: const CharacterListScreen(),
      ),
    ),
  );
}
