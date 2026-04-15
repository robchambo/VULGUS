import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../game_controller.dart';

class ActionBar extends ConsumerWidget {
  const ActionBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(gameControllerProvider);
    final ctrl = ref.read(gameControllerProvider.notifier);
    final canSubmit = s.selected.length == 4 && !s.isOver;
    final canDeselect = s.selected.isNotEmpty && !s.isOver;

    return Row(
      children: [
        Expanded(
          child: _OutlineButton(
            label: 'Shuffle',
            onPressed: s.isOver ? null : ctrl.shuffle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _OutlineButton(
            label: 'Deselect',
            onPressed: canDeselect ? ctrl.deselectAll : null,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _FilledButton(
            label: 'Submit',
            onPressed: canSubmit ? ctrl.submit : null,
          ),
        ),
      ],
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const _OutlineButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return Opacity(
      opacity: enabled ? 1 : 0.3,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.onSurface,
          side: const BorderSide(color: AppColors.onSurface, width: 2),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          minimumSize: const Size.fromHeight(52),
          textStyle: const TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1.5),
        ),
        child: Text(label.toUpperCase()),
      ),
    );
  }
}

class _FilledButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const _FilledButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return Opacity(
      opacity: enabled ? 1 : 0.3,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.onSurface,
          foregroundColor: AppColors.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(color: AppColors.onSurface, width: 2),
          ),
          minimumSize: const Size.fromHeight(52),
          elevation: 0,
          textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.5),
        ),
        child: Text(label.toUpperCase()),
      ),
    );
  }
}
