import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:starwars/domain/entities/character.dart';
import 'package:starwars/presentation/screens/list/cubit/character_list_cubit.dart';
import 'package:starwars/presentation/screens/list/widget/character_list_tile.dart';

/// Cuerpo de la lista de personajes
class CharacterList extends StatelessWidget {
  /// Constructor de la opción de la lista de personajes
  const CharacterList({
    required PagingController<int, Character> pagingController,
    super.key,
  }) : _pagingController = pagingController;

  final PagingController<int, Character> _pagingController;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollBehavior: const CupertinoScrollBehavior(),
      slivers: [
        SliverFillRemaining(
          child: BlocConsumer<CharacterListCubit, CharacterListState>(
            listener: (context, state) {
              if (state is ErrorGettingCharacters) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return PagedListView<int, Character>(
                pagingController: _pagingController,
                shrinkWrap: true,
                builderDelegate: PagedChildBuilderDelegate<Character>(
                  itemBuilder: (context, item, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 150),
                      child: SlideAnimation(
                        verticalOffset: -150,
                        duration: const Duration(milliseconds: 150),
                        child: FadeInAnimation(
                          duration: const Duration(milliseconds: 150),
                          child: CharacterListTile(item: item),
                        ),
                      ),
                    );
                  },
                  noMoreItemsIndicatorBuilder: (context) => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('No se encotraron más resultados :('),
                    ),
                  ),
                  firstPageProgressIndicatorBuilder: (context) => const Center(
                      child: Padding(
                    padding: EdgeInsets.only(top: 32),
                    child: CircularProgressIndicator(color: Colors.grey),
                  )),
                  newPageProgressIndicatorBuilder: (context) => const Center(
                      child: CircularProgressIndicator(color: Colors.grey)),
                  noItemsFoundIndicatorBuilder: (context) =>
                      const Center(child: Text('No se encontraron resultados')),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
