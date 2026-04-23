part of 'watchlist_bloc.dart';

enum WatchlistStatus { initial, loading, loaded, error }

enum SwapStatus { idle, selectingFirst, selectingSecond, readyToConfirm }

class WatchlistState extends Equatable {
  final WatchlistStatus status;
  final List<Stock> stocks;
  final SwapStatus swapStatus;
  final String? firstSelectedId;
  final String? secondSelectedId;
  final bool isSwapMode;
  final String? errorMessage;

  const WatchlistState({
    this.status = WatchlistStatus.initial,
    this.stocks = const [],
    this.swapStatus = SwapStatus.idle,
    this.firstSelectedId,
    this.secondSelectedId,
    this.isSwapMode = false,
    this.errorMessage,
  });

  bool get canConfirmSwap =>
      firstSelectedId != null && secondSelectedId != null;

  Stock? get firstSelectedStock => firstSelectedId != null
      ? stocks.firstWhere((s) => s.id == firstSelectedId,
          orElse: () => stocks.first)
      : null;

  Stock? get secondSelectedStock => secondSelectedId != null
      ? stocks.firstWhere((s) => s.id == secondSelectedId,
          orElse: () => stocks.first)
      : null;

  bool isSelected(String stockId) =>
      stockId == firstSelectedId || stockId == secondSelectedId;

  bool isFirstSelected(String stockId) => stockId == firstSelectedId;

  bool isSecondSelected(String stockId) => stockId == secondSelectedId;

  WatchlistState copyWith({
    WatchlistStatus? status,
    List<Stock>? stocks,
    SwapStatus? swapStatus,
    String? firstSelectedId,
    String? secondSelectedId,
    bool? isSwapMode,
    String? errorMessage,
    bool clearFirstSelected = false,
    bool clearSecondSelected = false,
    bool clearError = false,
  }) {
    return WatchlistState(
      status: status ?? this.status,
      stocks: stocks ?? this.stocks,
      swapStatus: swapStatus ?? this.swapStatus,
      firstSelectedId:
          clearFirstSelected ? null : firstSelectedId ?? this.firstSelectedId,
      secondSelectedId: clearSecondSelected
          ? null
          : secondSelectedId ?? this.secondSelectedId,
      isSwapMode: isSwapMode ?? this.isSwapMode,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        stocks,
        swapStatus,
        firstSelectedId,
        secondSelectedId,
        isSwapMode,
        errorMessage,
      ];
}
