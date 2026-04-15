import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class TinderCard extends StatefulWidget {
  final String statement;
  final void Function(bool agree) onSwiped;
  const TinderCard({super.key, required this.statement, required this.onSwiped});

  @override
  State<TinderCard> createState() => _TinderCardState();
}

class _TinderCardState extends State<TinderCard> {
  double _dx = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onPanUpdate: (d) => setState(() => _dx += d.delta.dx),
      onPanEnd: (_) {
        if (_dx.abs() > 120) {
          widget.onSwiped(_dx > 0);
        } else {
          setState(() => _dx = 0);
        }
      },
      child: Transform.translate(
        offset: Offset(_dx, 0),
        child: Transform.rotate(
          angle: _dx / width * 0.4,
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              border: Border.all(color: AppColors.onSurface, width: 2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.format_quote, size: 40, color: AppColors.primary),
                const SizedBox(height: 16),
                Text(
                  '"${widget.statement}"',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ActionButton(
                      icon: Icons.close,
                      color: AppColors.onSurface,
                      onTap: () => widget.onSwiped(false),
                    ),
                    _ActionButton(
                      icon: Icons.check,
                      color: AppColors.primary,
                      onTap: () => widget.onSwiped(true),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _ActionButton({required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(border: Border.all(color: color, width: 2)),
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }
}
