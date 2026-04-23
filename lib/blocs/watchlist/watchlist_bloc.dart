import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/stock.dart';
import '../../utils/stock_repository.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc() : super(const WatchlistState()) {
    on<WatchlistLoaded>(_onLoaded);
    on<WatchlistSwapModeEntered>(_onSwapModeEntered);
    on<WatchlistSwapModeExited>(_onSwapModeExited);
    on<WatchlistSwapFirstSelected>(_onFirstSelected);
    on<WatchlistSwapSecondSelected>(_onSecondSelected);
    on<WatchlistSwapConfirmed>(_onSwapConfirmed);
    on<WatchlistSwapSelectionReset>(_onSelectionReset);
    on<WatchlistReordered>(_onReordered);
  }

  void _onLoaded(WatchlistLoaded event, Emitter<WatchlistState> emit) {
    emit(state.copyWith(status: WatchlistStatus.loading));
    try {
      final stocks = StockRepository.getSampleWatchlist();
      emit(state.copyWith(
        status: WatchlistStatus.loaded,
        stocks: stocks,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: WatchlistStatus.error,
        errorMessage: 'Failed to load watchlist.',
      ));
    }
  }

  void _onSwapModeEntered(
      WatchlistSwapModeEntered event, Emitter<WatchlistState> emit) {
    emit(state.copyWith(
      isSwapMode: true,
      swapStatus: SwapStatus.selectingFirst,
      clearFirstSelected: true,
      clearSecondSelected: true,
    ));
  }

  void _onSwapModeExited(
      WatchlistSwapModeExited event, Emitter<WatchlistState> emit) {
    emit(state.copyWith(
      isSwapMode: false,
      swapStatus: SwapStatus.idle,
      clearFirstSelected: true,
      clearSecondSelected: true,
    ));
  }

  void _onFirstSelected(
      WatchlistSwapFirstSelected event, Emitter<WatchlistState> emit) {
    emit(state.copyWith(
      firstSelectedId: event.stockId,
      swapStatus: SwapStatus.selectingSecond,
      clearSecondSelected: true,
    ));
  }

  void _onSecondSelected(
      WatchlistSwapSecondSelected event, Emitter<WatchlistState> emit) {
    // Prevent selecting the same stock twice
    if (event.stockId == state.firstSelectedId) return;

    emit(state.copyWith(
      secondSelectedId: event.stockId,
      swapStatus: SwapStatus.readyToConfirm,
    ));
  }

  void _onSwapConfirmed(
      WatchlistSwapConfirmed event, Emitter<WatchlistState> emit) {
    if (!state.canConfirmSwap) return;

    final updatedStocks = List<Stock>.from(state.stocks);
    final firstIndex =
        updatedStocks.indexWhere((s) => s.id == state.firstSelectedId);
    final secondIndex =
        updatedStocks.indexWhere((s) => s.id == state.secondSelectedId);

    if (firstIndex == -1 || secondIndex == -1) return;

    // Perform the swap
    final temp = updatedStocks[firstIndex];
    updatedStocks[firstIndex] = updatedStocks[secondIndex];
    updatedStocks[secondIndex] = temp;

    emit(state.copyWith(
      stocks: updatedStocks,
      isSwapMode: false,
      swapStatus: SwapStatus.idle,
      clearFirstSelected: true,
      clearSecondSelected: true,
    ));
  }

  void _onSelectionReset(
      WatchlistSwapSelectionReset event, Emitter<WatchlistState> emit) {
    emit(state.copyWith(
      swapStatus: SwapStatus.selectingFirst,
      clearFirstSelected: true,
      clearSecondSelected: true,
    ));
  }

  void _onReordered(WatchlistReordered event, Emitter<WatchlistState> emit) {
    final updatedStocks = List<Stock>.from(state.stocks);
    final item = updatedStocks.removeAt(event.oldIndex);
    final newIndex =
        event.newIndex > event.oldIndex ? event.newIndex - 1 : event.newIndex;
    updatedStocks.insert(newIndex, item);

    emit(state.copyWith(stocks: updatedStocks));
  }
}
