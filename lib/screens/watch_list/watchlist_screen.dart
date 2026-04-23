import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_021/screens/watch_list/watch_list_widget/watch_list_app_bar.dart';
import 'package:trade_021/screens/watch_list/watch_list_widget/watch_list_section_header.dart';
import '../../blocs/watchlist/watchlist_bloc.dart';
import '../../theme/app_theme.dart';
import '../swap/swap_widgets/stock_tile.dart';
import '../swap/swap_widgets/swap_action_bar.dart';
import '../swap/swap_widgets/market_summary_header.dart';
import '../swap/swap_screen.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistBloc>().add(const WatchlistLoaded());
  }

  void _handleStockTap(BuildContext context, WatchlistState state, String id) {
    // if (!state.isSwapMode) return;

   Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<WatchlistBloc>(),
                    child: const SwapScreen(),
                  ),
                ),
              );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppTheme.background,
          appBar: WatchlistAppBar(
            isSwapMode: state.isSwapMode,
            onSwapPressed: () {
              
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<WatchlistBloc>(),
                    child: const SwapScreen(),
                  ),
                ),
              );
            },
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, WatchlistState state) {
    if (state.status == WatchlistStatus.loading ||
        state.status == WatchlistStatus.initial) {
      return const Center(
        child: CircularProgressIndicator(color: AppTheme.accent),
      );
    }

    if (state.status == WatchlistStatus.error) {
      return Center(
        child: Text(
          state.errorMessage ?? 'Something went wrong',
          style: const TextStyle(color: AppTheme.bearish),
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    MarketSummaryHeader(),
                    SizedBox(height: 12),
                    WatchlistSectionHeader(),
                    SizedBox(height: 6),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final stock = state.stocks[index];
                    return StockTile(
                      key: ValueKey(stock.id),
                      stock: stock,
                      rank: index + 1,
                      isSwapMode: state.isSwapMode,
                      isFirstSelected: state.isFirstSelected(stock.id),
                      isSecondSelected: state.isSecondSelected(stock.id),
                      onTap: () {
   Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<WatchlistBloc>(),
                    child: const SwapScreen(),
                  ),
                ),
              );
                      }
                         
                    );
                  },
                  childCount: state.stocks.length,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
            ],
          ),
        ),
        const SwapActionBar(),
        const SizedBox(height: 8),
      ],
    );
  }
}





