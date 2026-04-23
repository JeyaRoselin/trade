import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_021/blocs/watchlist/watchlist_bloc.dart';
import 'package:trade_021/screens/swap/swap_widgets/stock_row.dart';

class ReorderList extends StatelessWidget {
  final WatchlistState state;

  const ReorderList({required this.state});

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: state.stocks.length,
physics: NeverScrollableScrollPhysics(),
      // 🔥 CORE LOGIC (insertion shift)
      onReorder: (oldIndex, newIndex) {
        context.read<WatchlistBloc>().add(
          WatchlistReordered(
            oldIndex: oldIndex,
            newIndex: newIndex,
          ),
        );
      },

      itemBuilder: (context, index) {
        final stock = state.stocks[index];

        return StockRow(
          key: ValueKey(stock.id),
          stock: stock,
          index: index,
        );
      },
    );
  }
}