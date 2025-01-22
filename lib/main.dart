import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/cash/cash_bloc.dart';
import 'bloc/nav/nav_bloc.dart';
import 'bloc/saving/saving_bloc.dart';
import 'screens/loading_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    precacheImage(AssetImage('assets/o1.png'), context);
    precacheImage(AssetImage('assets/o2.png'), context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CashBloc()..add(GetCash())),
        BlocProvider(create: (context) => SavingBloc()..add(GetSaving())),
        BlocProvider(create: (context) => NavBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          brightness: Brightness.dark,
          useMaterial3: false,
        ),
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: child!,
          );
        },
        home: const LoadingScreen(),
      ),
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return GlowingOverscrollIndicator(
      color: Color(0xffB26868),
      axisDirection: details.direction,
      child: child,
    );
  }
}
