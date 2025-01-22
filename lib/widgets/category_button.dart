import 'package:flutter/material.dart';

import 'my_btn.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MyBtn(
        onPressed: onPressed,
        minSize: 26,
        child: Container(
          height: 26,
          decoration: BoxDecoration(
            color: const Color(0xffB26868),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'w500',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
