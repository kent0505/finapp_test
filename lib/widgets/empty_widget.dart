import 'package:flutter/material.dart';

import 'svg_wid.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgWid(
            'assets/empty.svg',
            color: Color(0xffB26868),
          ),
          SizedBox(height: 60),
          Text(
            'No information on income yet',
            style: TextStyle(
              color: Color(0xffB26868),
              fontSize: 22,
              fontFamily: 'w500',
            ),
          ),
        ],
      ),
    );
  }
}
