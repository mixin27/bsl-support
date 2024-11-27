import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Placeholder widget showing a message and CTA to go back to the home screen.
class EmptyPlaceholderWidget extends ConsumerWidget {
  const EmptyPlaceholderWidget({
    super.key,
    required this.message,
    this.onTap,
  });

  final String message;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32.0),
            FilledButton(
              onPressed: onTap ??
                  () {
                    // context.goNamed(AppRoute.home.name);
                  },
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
