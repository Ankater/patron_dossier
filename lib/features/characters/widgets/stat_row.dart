import 'package:flutter/material.dart';

class StatRow extends StatelessWidget {
  const StatRow({
    super.key,
    required this.label,
    required this.value,
    this.showControls = false,
    this.canIncrement = false,
    this.canDecrement = false,
    this.onIncrement,
    this.onDecrement,
  });

  final String label;
  final int value;
  final bool showControls;
  final bool canIncrement;
  final bool canDecrement;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 52,
            child: Text(
              label,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (showControls) ...[
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: canDecrement ? onDecrement : null,
              visualDensity: VisualDensity.compact,
            ),
            SizedBox(
              width: 40,
              child: Text(
                '$value',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: canIncrement ? onIncrement : null,
              visualDensity: VisualDensity.compact,
            ),
          ] else
            Text('$value', style: theme.textTheme.bodyLarge),
        ],
      ),
    );
  }
}
