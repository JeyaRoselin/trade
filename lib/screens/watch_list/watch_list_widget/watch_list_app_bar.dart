import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trade_021/screens/watch_list/watch_list_widget/icon_btn.dart';
import 'package:trade_021/screens/watch_list/watch_list_widget/swap_button.dart';
import 'package:trade_021/theme/app_theme.dart';

class WatchlistAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSwapMode;
  final VoidCallback onSwapPressed;

  const WatchlistAppBar({
    required this.isSwapMode,
    required this.onSwapPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.background,
      title: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppTheme.accent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                '021',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'Watchlist',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      actions: [
        SwapButton(onPressed: onSwapPressed),
        const SizedBox(width: 8),
        IconBtn(icon: Icons.search_rounded),
        const SizedBox(width: 4),
        IconBtn(icon: Icons.notifications_none_rounded),
        const SizedBox(width: 12),
      ],
    );
  }
}
