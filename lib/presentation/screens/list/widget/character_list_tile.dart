import 'package:flutter/material.dart';
import 'package:starwars/domain/entities/character.dart';
import 'package:starwars/presentation/screens/details/character_details_screen.dart';

/// Opción de la lista de personajes
class CharacterListTile extends StatelessWidget {
  /// Constructor de la opción de la lista de personajes
  const CharacterListTile({
    required Character item,
    super.key,
  }) : _item = item;

  final Character _item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CharacterDetailsScreen(character: _item),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _item.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        _item.formattedGender,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
