import 'package:flutter/material.dart';

/// Details item widget
class DetailsItem extends StatelessWidget {
  /// Constructor for Details item widget
  const DetailsItem({
    required String header,
    required String text,
    super.key,
  })  : _header = header,
        _text = text;

  final String _header;
  final String _text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            _header,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.black38),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(_text, style: Theme.of(context).textTheme.titleMedium),
        ),
      ],
    );
  }
}
