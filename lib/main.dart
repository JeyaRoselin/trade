import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/watchlist/watchlist_bloc.dart';
import 'screens/watch_list/watchlist_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const Trade021App());
}

class Trade021App extends StatelessWidget {
  const Trade021App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WatchlistBloc(),
      child: MaterialApp(
        title: '021 Trade',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const WatchlistScreen(),
      ),
    );
  }
}
