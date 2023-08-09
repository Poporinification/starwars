import 'package:flutter/material.dart';
import 'package:starwars/domain/entities/character.dart';
import 'package:starwars/presentation/screens/details/widget/details_footer.dart';
import 'package:starwars/presentation/screens/details/widget/details_item.dart';
import 'package:starwars/presentation/screens/details/widget/report_button.dart';

/// Pantalla de detalles del personaje
class CharacterDetailsScreen extends StatefulWidget {
  /// Constructor de la clase
  const CharacterDetailsScreen({
    required Character character,
    super.key,
  }) : _character = character;

  final Character _character;

  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._character.name),
        centerTitle: true,
        actions: [
          ReportButton(character: widget._character),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          DetailsItem(
            header: 'Género',
            text: widget._character.formattedGender,
          ),
          const SizedBox(height: 20),
          DetailsItem(
            header: 'Fecha de nacimiento',
            text: widget._character.birthYear,
          ),
          const SizedBox(height: 20),
          DetailsItem(
            header: 'Altura',
            text: widget._character.formattedHeight,
          ),
          const SizedBox(height: 20),
          DetailsItem(
            header: 'Peso',
            text: widget._character.formattedMass,
          ),
          const SizedBox(height: 20),
          DetailsItem(
            header: 'Color de pelo',
            text: widget._character.hairColor,
          ),
          const SizedBox(height: 20),
          DetailsItem(
            header: 'Color de ojos',
            text: widget._character.eyeColor,
          ),
          const SizedBox(height: 20),
          DetailsFooter(character: widget._character),
        ],
      ),
    );
  }
}
