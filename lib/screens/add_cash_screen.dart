import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cash/cash_bloc.dart';
import '../bloc/nav/nav_bloc.dart';
import '../utils.dart';
import '../models/cash.dart';
import '../widgets/field_title.dart';
import '../widgets/btn.dart';
import '../widgets/text_title.dart';
import '../widgets/field.dart';

class AddCashScreen extends StatefulWidget {
  const AddCashScreen({super.key});

  @override
  State<AddCashScreen> createState() => _AddCashScreenState();
}

class _AddCashScreenState extends State<AddCashScreen> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();

  bool active = false;

  void checkActive() {
    setState(() {
      active = controller1.text.isNotEmpty && controller2.text.isNotEmpty;
    });
  }

  void onAdd() {
    final cash = Cash(
      id: getTimestamp(),
      title: controller1.text,
      amount: int.parse(controller2.text),
    );
    context.read<CashBloc>().add(AddCash(cash: cash));
    context.read<NavBloc>().add(ChangePage(id: 1));
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).viewPadding.top),
        const SizedBox(
          height: 60,
          child: TextTitle('Income'),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20),
            children: [
              const Row(
                children: [
                  SizedBox(width: 16),
                  Text(
                    'Add transaction',
                    style: TextStyle(
                      color: Color(0xffB26868),
                      fontSize: 22,
                      fontFamily: 'w500',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const FieldTitle('Title'),
              const SizedBox(height: 6),
              Field(
                controller: controller1,
                hintText: 'Title',
                onChanged: checkActive,
              ),
              const SizedBox(height: 20),
              const FieldTitle('Amount'),
              const SizedBox(height: 6),
              Field(
                controller: controller2,
                hintText: '\$5000',
                number: true,
                onChanged: checkActive,
              ),
              const SizedBox(height: 10),
              Btn(
                title: 'Add',
                active: active,
                onPressed: onAdd,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
