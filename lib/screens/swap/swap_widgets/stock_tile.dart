import 'package:flutter/material.dart';
import '../../../models/stock.dart';
import '../../../theme/app_theme.dart';
import 'sparkline_chart.dart';

class StockTile extends StatelessWidget {
  final Stock stock;
  final int rank;
  final bool isSwapMode;
  final bool isFirstSelected;
  final bool isSecondSelected;
  final VoidCallback? onTap;

  const StockTile({
    super.key,
    required this.stock,
    required this.rank,
    this.isSwapMode = false,
    this.isFirstSelected = false,
    this.isSecondSelected = false,
    this.onTap,
  });

  Color get _selectionBorderColor {
    if (isFirstSelected) return AppTheme.swapHighlightFirst;
    if (isSecondSelected) return AppTheme.swapHighlightSecond;
    return Colors.transparent;
  }

  Color get _selectionBgColor {
    if (isFirstSelected) return AppTheme.swapHighlightFirst.withOpacity(0.08);
    if (isSecondSelected) return AppTheme.swapHighlightSecond.withOpacity(0.08);
    if (isSwapMode) return AppTheme.surfaceElevated.withOpacity(0.5);
    return AppTheme.surfaceElevated;
  }

  @override
  Widget build(BuildContext context) {
    final isPositive = stock.trend == StockTrend.up;
    final isNeutral = stock.trend == StockTrend.neutral;
    final priceColor = isNeutral
        ? AppTheme.neutral
        : isPositive
            ? AppTheme.bullish
            : AppTheme.bearish;

    final isSelected = isFirstSelected || isSecondSelected;

    return GestureDetector(
      onTap: onTap ,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        decoration: BoxDecoration(
          color: _selectionBgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? _selectionBorderColor : AppTheme.cardBorder,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: _selectionBorderColor.withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              // Rank Badge
              _RankBadge(rank: rank, isSelected: isSelected, color: _selectionBorderColor),
              const SizedBox(width: 12),

              // Stock Symbol & Name
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          stock.symbol,
                          style: const TextStyle(
                            color: AppTheme.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizedBox(width: 6),
                        _ExchangeBadge(exchange: stock.exchange),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      stock.companyName,
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Sparkline
              SparklineChart(
                data: stock.sparklineData,
                isPositive: isPositive,
              ),

              const SizedBox(width: 12),

              // Price & Change
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹${_formatPrice(stock.currentPrice)}',
                    style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 3),
                  _ChangeChip(
                    change: stock.change,
                    changePercent: stock.changePercent,
                    color: priceColor,
                    isNeutral: isNeutral,
                  ),
                ],
              ),

              // Swap Mode Indicator
              if (isSwapMode) ...[
                const SizedBox(width: 10),
                _SwapIndicator(
                  isFirstSelected: isFirstSelected,
                  isSecondSelected: isSecondSelected,
                  selectionColor: _selectionBorderColor,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatPrice(double price) {
    if (price >= 10000) {
      return price.toStringAsFixed(2);
    }
    return price.toStringAsFixed(2);
  }
}

class _RankBadge extends StatelessWidget {
  final int rank;
  final bool isSelected;
  final Color color;

  const _RankBadge({
    required this.rank,
    required this.isSelected,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: isSelected ? color.withOpacity(0.15) : AppTheme.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? color.withOpacity(0.5) : AppTheme.cardBorder,
        ),
      ),
      child: Center(
        child: Text(
          '$rank',
          style: TextStyle(
            color: isSelected ? color : AppTheme.textMuted,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _ExchangeBadge extends StatelessWidget {
  final String exchange;

  const _ExchangeBadge({required this.exchange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
      decoration: BoxDecoration(
        color: AppTheme.accent.withOpacity(0.08),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        exchange,
        style: const TextStyle(
          color: AppTheme.accent,
          fontSize: 9,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _ChangeChip extends StatelessWidget {
  final double change;
  final double changePercent;
  final Color color;
  final bool isNeutral;

  const _ChangeChip({
    required this.change,
    required this.changePercent,
    required this.color,
    required this.isNeutral,
  });

  @override
  Widget build(BuildContext context) {
    final sign = change >= 0 ? '+' : '';
    final arrow = isNeutral ? '—' : change > 0 ? '▲' : '▼';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        '$arrow $sign${changePercent.toStringAsFixed(2)}%',
        style: TextStyle(
          color: color,
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
      ),
    );
  }
}

class _SwapIndicator extends StatelessWidget {
  final bool isFirstSelected;
  final bool isSecondSelected;
  final Color selectionColor;

  const _SwapIndicator({
    required this.isFirstSelected,
    required this.isSecondSelected,
    required this.selectionColor,
  });

  @override
  Widget build(BuildContext context) {
    if (isFirstSelected) {
      return const _SelectionDot(label: 'A', color: AppTheme.swapHighlightFirst);
    }
    if (isSecondSelected) {
      return const _SelectionDot(label: 'B', color: AppTheme.swapHighlightSecond);
    }
    return const Icon(
      Icons.radio_button_unchecked_rounded,
      size: 18,
      color: AppTheme.textMuted,
    );
  }
}

class _SelectionDot extends StatelessWidget {
  final String label;
  final Color color;

  const _SelectionDot({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 10,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
