import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Btn extends StatelessWidget {
  const Btn({
    super.key,
    required this.title,
    this.active = true,
    required this.onPressed,
  });

  final String title;
  final bool active;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: active ? const Color(0xffB26868) : const Color(0xff2C1A1A),
        borderRadius: BorderRadius.circular(14),
      ),
      child: CupertinoButton(
        onPressed: active ? onPressed : null,
        padding: EdgeInsets.zero,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color:
                  active ? Colors.black : Colors.white.withValues(alpha: 0.2),
              fontSize: 16,
              fontFamily: 'w500',
            ),
          ),
        ),
      ),
    );
  }
}
