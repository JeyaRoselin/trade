import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trade_021/theme/app_theme.dart';

class SwapButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SwapButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppTheme.swapHighlightFirst, AppTheme.swapHighlightSecond],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.swap_vert_rounded, color: Colors.black, size: 14),
            SizedBox(width: 4),
            Text(
              'Swap',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
