import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_021/screens/swap/swap_widgets/reorder_list.dart';
import '../../blocs/watchlist/watchlist_bloc.dart';
import '../../models/stock.dart';
import '../../theme/app_theme.dart';
import 'swap_widgets/sparkline_chart.dart';

class SwapScreen extends StatelessWidget {
  const SwapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppTheme.background,
          appBar: AppBar(
            backgroundColor: AppTheme.background,
            title: const Text(
              'Reorder Watchlist',
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconTheme: const IconThemeData(color: AppTheme.textPrimary),
          ),
          body: ReorderList(state: state),
        );
      },
    );
  }
}



