import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/btn.dart';
import '../widgets/my_btn.dart';
import '../widgets/svg_wid.dart';
import 'home_screen.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30 + MediaQuery.of(context).viewPadding.top),
          Row(
            children: [
              const SizedBox(width: 28),
              _Indicator(isActive: index == 1),
              const SizedBox(width: 10),
              _Indicator(isActive: index == 2),
              const SizedBox(width: 10),
              _Indicator(isActive: index == 3),
              const SizedBox(width: 28),
            ],
          ),
          Expanded(
            child: index == 3
                ? const SvgWid('assets/o3.svg')
                : Image.asset('assets/o$index.png'),
          ),
          Container(
            height: 320,
            color: const Color(0xff2C1A1A),
            child: Column(
              children: [
                const Spacer(),
                if (index == 1)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28),
                    child: Text(
                      'By tracking your expenses and income, you\'ll be able to plan your goals more effectively, whether it\'s saving for a holiday or education',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'w600',
                      ),
                    ),
                  )
                else ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Text(
                      index == 2
                          ? 'Become the master of income .'
                          : 'We value your feedback',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'w700',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      index == 2
                          ? 'In today\'s world, where financial literacy is becoming an integral part of life, managing your income and expenses is crucial.'
                          : 'Every review is valuable - it helps make our app better for you',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'w300',
                      ),
                    ),
                  ),
                ],
                const Spacer(),
                Btn(
                  title: 'Continue',
                  onPressed: () async {
                    if (index == 3) {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool('onboard', false);
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const HomeScreen();
                            },
                          ),
                          (route) => false,
                        );
                      }
                    } else {
                      setState(() {
                        index++;
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                MyBtn(
                  onPressed: () {},
                  minSize: 20,
                  child: Text(
                    'Terms of use  &  Privacy Policy',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12,
                      fontFamily: 'w400',
                    ),
                  ),
                ),
                const SizedBox(height: 42),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 3,
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xffB26868)
              : Colors.white.withValues(alpha: .33),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}
