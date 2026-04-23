import 'package:flutter/widgets.dart';
import 'package:trade_021/theme/app_theme.dart';

class IconBtn extends StatelessWidget {
  final IconData icon;

  const IconBtn({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppTheme.surfaceElevated,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Icon(icon, color: AppTheme.textSecondary, size: 18),
    );
  }
}