import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class MarketSummaryHeader extends StatelessWidget {
  const MarketSummaryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.surfaceElevated,
            AppTheme.surfaceElevated.withBlue(60),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Row(
        children: const [
          Expanded(
            child: _IndexChip(
              label: 'NIFTY 50',
              value: '22,418.65',
              change: '+0.72%',
              isUp: true,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: _IndexChip(
              label: 'SENSEX',
              value: '73,852.94',
              change: '+0.68%',
              isUp: true,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: _IndexChip(
              label: 'BANK NIFTY',
              value: '48,112.30',
              change: '-0.15%',
              isUp: false,
            ),
          ),
        ],
      ),
    );
  }
}

class _IndexChip extends StatelessWidget {
  final String label;
  final String value;
  final String change;
  final bool isUp;

  const _IndexChip({
    required this.label,
    required this.value,
    required this.change,
    required this.isUp,
  });

  @override
  Widget build(BuildContext context) {
    final color = isUp ? AppTheme.bullish : AppTheme.bearish;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textMuted,
            fontSize: 9,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          change,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
