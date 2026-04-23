import 'package:equatable/equatable.dart';

enum StockTrend { up, down, neutral }

class Stock extends Equatable {
  final String id;
  final String symbol;
  final String companyName;
  final double currentPrice;
  final double change;
  final double changePercent;
  final StockTrend trend;
  final List<double> sparklineData;
  final String exchange;
  final String sector;

  const Stock({
    required this.id,
    required this.symbol,
    required this.companyName,
    required this.currentPrice,
    required this.change,
    required this.changePercent,
    required this.trend,
    required this.sparklineData,
    required this.exchange,
    required this.sector,
  });

  Stock copyWith({
    String? id,
    String? symbol,
    String? companyName,
    double? currentPrice,
    double? change,
    double? changePercent,
    StockTrend? trend,
    List<double>? sparklineData,
    String? exchange,
    String? sector,
  }) {
    return Stock(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      companyName: companyName ?? this.companyName,
      currentPrice: currentPrice ?? this.currentPrice,
      change: change ?? this.change,
      changePercent: changePercent ?? this.changePercent,
      trend: trend ?? this.trend,
      sparklineData: sparklineData ?? this.sparklineData,
      exchange: exchange ?? this.exchange,
      sector: sector ?? this.sector,
    );
  }

  @override
  List<Object?> get props => [
        id,
        symbol,
        companyName,
        currentPrice,
        change,
        changePercent,
        trend,
        sparklineData,
        exchange,
        sector,
      ];
}
