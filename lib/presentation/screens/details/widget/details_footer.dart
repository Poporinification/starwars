import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starwars/domain/entities/character.dart';
import 'package:starwars/presentation/screens/details/cubit/character_details_cubit.dart';
import 'package:starwars/presentation/screens/details/widget/details_item.dart';

/// Footer de la pantalla de detalles del personaje
class DetailsFooter extends StatefulWidget {
  /// Constructor de la clase
  const DetailsFooter({
    required Character character,
    super.key,
  }) : _character = character;

  final Character _character;

  @override
  State<DetailsFooter> createState() => _DetailsFooterState();
}

class _DetailsFooterState extends State<DetailsFooter> {
  late CharacterDetailsCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<CharacterDetailsCubit>(context);
    _cubit.getCharacterDetails(widget._character);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: Column(
        children: [
          BlocConsumer<CharacterDetailsCubit, CharacterDetailsState>(
            listener: (context, state) {
              if (state is ErrorGettingDetails) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is LoadingCharacterDetails) {
                return const Center(
                  child: LinearProgressIndicator(color: Colors.grey),
                );
              }
              return SlideInDown(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            DetailsItem(
                              header: 'Planeta natal',
                              text: widget._character.homeworld,
                            ),
                            const SizedBox(height: 20),
                            DetailsItem(
                              header: 'Naves estelares',
                              text: widget._character.starships.isEmpty
                                  ? 'Ninguna'
                                  : widget._character.starships.join(', '),
                            ),
                            const SizedBox(height: 20),
                            DetailsItem(
                              header: 'Vehículos',
                              text: widget._character.vehicles.isEmpty
                                  ? 'Ninguno'
                                  : widget._character.vehicles.join(', '),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
