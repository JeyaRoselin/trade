import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/watchlist/watchlist_bloc.dart';
import '../../../theme/app_theme.dart';

class SwapActionBar extends StatelessWidget {
  const SwapActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, state) {
        if (!state.isSwapMode) return const SizedBox.shrink();

        final first = state.firstSelectedStock;
        final second = state.secondSelectedStock;

        return AnimatedSlide(
          offset:
              state.isSwapMode ? Offset.zero : const Offset(0, 1),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.swapModeBanner,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.swapHighlightSecond.withOpacity(0.3)),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.swapHighlightSecond.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Instruction Text
                _InstructionRow(state: state),
                const SizedBox(height: 14),

                // Selection Preview
                if (first != null || second != null)
                  _SelectionPreview(state: state),

                if (first != null || second != null)
                  const SizedBox(height: 14),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        label: 'Cancel',
                        icon: Icons.close_rounded,
                        color: AppTheme.textSecondary,
                        bgColor: AppTheme.surfaceElevated,
                        onTap: () => context
                            .read<WatchlistBloc>()
                            .add(const WatchlistSwapModeExited()),
                      ),
                    ),
                    if (state.swapStatus != SwapStatus.selectingFirst) ...[
                      const SizedBox(width: 10),
                      Expanded(
                        child: _ActionButton(
                          label: 'Reset',
                          icon: Icons.refresh_rounded,
                          color: AppTheme.swapHighlightFirst,
                          bgColor:
                              AppTheme.swapHighlightFirst.withOpacity(0.08),
                          onTap: () => context
                              .read<WatchlistBloc>()
                              .add(const WatchlistSwapSelectionReset()),
                        ),
                      ),
                    ],
                    if (state.canConfirmSwap) ...[
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: _ActionButton(
                          label: 'Swap Now',
                          icon: Icons.swap_vert_rounded,
                          color: Colors.black,
                          bgColor: AppTheme.swapHighlightSecond,
                          onTap: () => context
                              .read<WatchlistBloc>()
                              .add(const WatchlistSwapConfirmed()),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _InstructionRow extends StatelessWidget {
  final WatchlistState state;

  const _InstructionRow({required this.state});

  String get _instructionText {
    switch (state.swapStatus) {
      case SwapStatus.selectingFirst:
        return 'Tap to select the first stock';
      case SwapStatus.selectingSecond:
        return 'Now select the second stock';
      case SwapStatus.readyToConfirm:
        return 'Ready to swap — confirm below';
      default:
        return '';
    }
  }

  Color get _dotColor {
    switch (state.swapStatus) {
      case SwapStatus.selectingFirst:
        return AppTheme.swapHighlightFirst;
      case SwapStatus.selectingSecond:
        return AppTheme.swapHighlightSecond;
      case SwapStatus.readyToConfirm:
        return AppTheme.bullish;
      default:
        return AppTheme.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: _dotColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: _dotColor.withOpacity(0.5), blurRadius: 6),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          _instructionText,
          style: const TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _SelectionPreview extends StatelessWidget {
  final WatchlistState state;

  const _SelectionPreview({required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _StockChip(
              symbol: state.firstSelectedStock?.symbol,
              color: AppTheme.swapHighlightFirst,
              label: 'A',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              Icons.swap_horiz_rounded,
              color: AppTheme.textMuted,
              size: 20,
            ),
          ),
          Expanded(
            child: _StockChip(
              symbol: state.secondSelectedStock?.symbol,
              color: AppTheme.swapHighlightSecond,
              label: 'B',
            ),
          ),
        ],
      ),
    );
  }
}

class _StockChip extends StatelessWidget {
  final String? symbol;
  final Color color;
  final String label;

  const _StockChip({
    required this.symbol,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: symbol != null ? color.withOpacity(0.4) : AppTheme.cardBorder,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: symbol != null ? color : AppTheme.textMuted,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              symbol ?? 'Select...',
              style: TextStyle(
                color: symbol != null ? color : AppTheme.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final Color bgColor;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
