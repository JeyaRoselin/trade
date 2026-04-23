import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_021/blocs/watchlist/watchlist_bloc.dart';
import 'package:trade_021/theme/app_theme.dart';

class WatchlistSectionHeader extends StatelessWidget {
  const WatchlistSectionHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Text(
            'My Stocks',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          BlocBuilder<WatchlistBloc, WatchlistState>(
            builder: (context, state) {
              return Text(
                '${state.stocks.length} stocks',
                style: const TextStyle(
                  color: AppTheme.textMuted,
                  fontSize: 12,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
