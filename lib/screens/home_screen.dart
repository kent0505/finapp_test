import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/nav/nav_bloc.dart';
import '../widgets/my_btn.dart';
import '../widgets/svg_wid.dart';
import 'initial_screen.dart';
import 'add_cash_screen.dart';
import 'news_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 86),
            child: BlocBuilder<NavBloc, NavState>(
              builder: (context, state) {
                if (state is NavIncome) return const AddCashScreen();
                if (state is NavNews) return const NewsScreen();

                return const InitialScreen();
              },
            ),
          ),
          const BottomNav(),
        ],
      ),
    );
  }
}

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 86,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          color: Color(0xff2C1A1A),
        ),
        child: BlocBuilder<NavBloc, NavState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _Button(id: 1, title: 'Home', active: state is NavInitial),
                _Button(id: 2, title: 'Income', active: state is NavIncome),
                _Button(id: 3, title: 'News', active: state is NavNews),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.id,
    required this.title,
    required this.active,
  });

  final int id;
  final String title;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return MyBtn(
      onPressed: active
          ? null
          : () {
              context.read<NavBloc>().add(ChangePage(id: id));
            },
      padding: 0,
      child: SizedBox(
        width: 62,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: active
                    ? const Color(0xffB26868).withValues(alpha: .2)
                    : null,
              ),
              child: Center(
                child: SvgWid(
                  'assets/$id.svg',
                  color: active ? const Color(0xffB26868) : Colors.white,
                ),
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: active ? const Color(0xffB26868) : Colors.white,
                fontSize: 14,
                fontFamily: 'w500',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
