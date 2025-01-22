import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cash/cash_bloc.dart';
import '../models/cash.dart';
import '../widgets/dialog_wid.dart';
import '../widgets/field_title.dart';
import '../widgets/btn.dart';
import '../widgets/text_title.dart';
import '../widgets/field.dart';

class EditCashScreen extends StatefulWidget {
  const EditCashScreen({super.key, required this.cash});

  final Cash cash;

  @override
  State<EditCashScreen> createState() => _EditCashScreenState();
}

class _EditCashScreenState extends State<EditCashScreen> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();

  bool active = true;

  void checkActive() {
    setState(() {
      active = controller1.text.isNotEmpty && controller2.text.isNotEmpty;
    });
  }

  void onEdit() {
    final cash = Cash(
      id: widget.cash.id,
      title: controller1.text,
      amount: int.parse(controller2.text),
    );
    context.read<CashBloc>().add(EditCash(cash: cash));
    Navigator.pop(context);
  }

  void onDelete() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogWid(
          title: 'Delete Income?',
          onPressed: () {
            context.read<CashBloc>().add(DeleteCash(cash: widget.cash));
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    controller1.text = widget.cash.title;
    controller2.text = widget.cash.amount.toString();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).viewPadding.top),
          SizedBox(
            height: 60,
            child: TextTitle(
              'Income',
              back: true,
              onDelete: onDelete,
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              SizedBox(width: 14),
              Text(
                'Edit transaction',
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
            title: 'Edit',
            active: active,
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }
}
