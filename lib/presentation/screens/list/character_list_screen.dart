import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:starwars/domain/entities/character.dart';
import 'package:starwars/presentation/screens/list/cubit/character_list_cubit.dart';
import 'package:starwars/presentation/screens/list/widget/character_list.dart';
import 'package:starwars/presentation/shared/menu/menu.dart';

/// Pantalla de lista de personajes
class CharacterListScreen extends StatefulWidget {
  /// Constructor de la clase
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen>
    with TickerProviderStateMixin {
  final PagingController<int, Character> _pagingController = PagingController(
    firstPageKey: 1,
  );

  late CharacterListCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<CharacterListCubit>(context);

    _pagingController.addPageRequestListener((page) async {
      await _cubit.getCharacters(
        page,
        _pagingController,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Star Wars'),
        centerTitle: true,
      ),
      drawer: const Menu(),
      body: CharacterList(pagingController: _pagingController),
    );
  }
}
