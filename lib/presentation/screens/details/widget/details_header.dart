import 'package:flutter/material.dart';

/// Details header widget
class DetailsHeader extends StatelessWidget {
  /// Constructor for Details header widget
  const DetailsHeader({
    required String title,
    required String subtitle,
    super.key,
  })  : _title = title,
        _subtitle = subtitle;

  final String _title;
  final String _subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20, width: double.infinity),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(_title, style: Theme.of(context).textTheme.headlineSmall),
        ),
        const SizedBox(height: 10, width: double.infinity),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:
              Text(_subtitle, style: Theme.of(context).textTheme.titleMedium),
        ),
      ],
    );
  }
}
