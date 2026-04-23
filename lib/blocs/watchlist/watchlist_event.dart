part of 'watchlist_bloc.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object?> get props => [];
}

/// Fired once on app start to seed the watchlist
class WatchlistLoaded extends WatchlistEvent {
  const WatchlistLoaded();
}

/// Fired when the user enters swap mode
class WatchlistSwapModeEntered extends WatchlistEvent {
  const WatchlistSwapModeEntered();
}

/// Fired when the user exits swap mode (cancel or confirm)
class WatchlistSwapModeExited extends WatchlistEvent {
  const WatchlistSwapModeExited();
}

/// Fired when the user taps the first stock to swap
class WatchlistSwapFirstSelected extends WatchlistEvent {
  final String stockId;
  const WatchlistSwapFirstSelected(this.stockId);

  @override
  List<Object?> get props => [stockId];
}

/// Fired when the user taps the second stock to swap
class WatchlistSwapSecondSelected extends WatchlistEvent {
  final String stockId;
  const WatchlistSwapSecondSelected(this.stockId);

  @override
  List<Object?> get props => [stockId];
}

/// Fired to confirm and execute the swap
class WatchlistSwapConfirmed extends WatchlistEvent {
  const WatchlistSwapConfirmed();
}

/// Fired to reset selection without exiting swap mode
class WatchlistSwapSelectionReset extends WatchlistEvent {
  const WatchlistSwapSelectionReset();
}

/// Fired when drag-and-drop reorder happens directly on watchlist
class WatchlistReordered extends WatchlistEvent {
  final int oldIndex;
  final int newIndex;

  const WatchlistReordered({
    required this.oldIndex,
    required this.newIndex,
  });

  @override
  List<Object?> get props => [oldIndex, newIndex];
}
