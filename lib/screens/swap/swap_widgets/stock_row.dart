import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trade_021/models/stock.dart';
import 'package:trade_021/theme/app_theme.dart';
import 'package:trade_021/screens/swap/swap_widgets/sparkline_chart.dart';

class StockRow extends StatelessWidget {
  final Stock stock;
  final int index;

  const StockRow({
    super.key,
    required this.stock,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = stock.trend == StockTrend.up;

    final priceColor = stock.trend == StockTrend.neutral
        ? AppTheme.neutral
        : isPositive
            ? AppTheme.bullish
            : AppTheme.bearish;

    return Container(
      key: key,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.surfaceElevated,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            // Position
            SizedBox(
              width: 24,
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: AppTheme.textMuted,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(width: 10),

            // Stock Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stock.symbol,
                    style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    stock.sector,
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            // Sparkline
            SparklineChart(
              data: stock.sparklineData,
              isPositive: isPositive,
              width: 56,
              height: 28,
            ),

            const SizedBox(width: 10),

            // Price
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹${stock.currentPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${stock.changePercent >= 0 ? '+' : ''}${stock.changePercent.toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: priceColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(width: 10),

            // 🔥 DRAG HANDLE
            ReorderableDragStartListener(
              index: index,
              child: const Icon(
                Icons.drag_handle,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}