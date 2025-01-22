import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../bloc/cash/cash_bloc.dart';
import '../bloc/saving/saving_bloc.dart';
import '../models/news.dart';
import '../models/saving.dart';
import '../utils.dart';
import '../widgets/category_button.dart';
import '../widgets/my_btn.dart';
import '../widgets/svg_wid.dart';
import '../widgets/text_title.dart';
import 'history_screen.dart';
import 'my_saving_screen.dart';
import 'my_savings_screen.dart';
import 'news_read_screen.dart';
import 'tasks_screen.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).viewPadding.top),
        const SizedBox(
          height: 60,
          child: TextTitle('Home'),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(height: 20),
              const _CurrentBalance(),
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(width: 14),
                  CategoryButton(
                    title: 'Savings',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const MySavingsScreen();
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 16),
                  CategoryButton(
                    title: 'My saving',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MySavingScreen(
                              saving: Saving(
                                id: 0,
                                category: '',
                                amount: 0,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 16),
                  CategoryButton(
                    title: 'History',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const HistoryScreen();
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 14),
                ],
              ),
              const SizedBox(height: 26),
              const TextTitle('Finance'),
              const SizedBox(height: 20),
              const Row(
                children: [
                  SizedBox(width: 14),
                  _TaskManagerCard(income: true),
                  SizedBox(width: 30),
                  _TaskManagerCard(),
                  SizedBox(width: 14),
                ],
              ),
              const SizedBox(height: 20),
              const TextTitle('News'),
              const SizedBox(height: 20),
              ...List.generate(
                3,
                (index) {
                  return _News(news: newsLIST[index]);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class _CurrentBalance extends StatelessWidget {
  const _CurrentBalance();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 124,
      margin: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xff2C1A1A),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: const Color(0xffB26868),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Current Balance',
                  style: TextStyle(
                    color: Color(0xffB26868),
                    fontSize: 22,
                    fontFamily: 'w500',
                  ),
                ),
                Spacer(),
                BlocBuilder<CashBloc, CashState>(
                  builder: (context, state) {
                    return BlocBuilder<SavingBloc, SavingState>(
                      builder: (context, state) {
                        return Text(
                          '\$ ${currentBalance + totalIncomes}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontFamily: 'w600',
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          const SvgWid('assets/balance.svg'),
          const SizedBox(width: 30),
        ],
      ),
    );
  }
}

class _TaskManagerCard extends StatelessWidget {
  const _TaskManagerCard({this.income = false});

  final bool income;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: const Color(0xff2C1A1A),
          borderRadius: BorderRadius.circular(10),
        ),
        child: MyBtn(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return income ? const HistoryScreen() : const TasksScreen();
                },
              ),
            );
          },
          child: Column(
            children: [
              const SizedBox(height: 12),
              Row(
                children: [
                  const SizedBox(width: 8),
                  Container(
                    height: 32,
                    width: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xffB26868).withValues(alpha: .2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: SvgWid(
                        income ? 'assets/task2.svg' : 'assets/task.svg',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    income ? 'Income' : 'Tasks',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'w500',
                      height: 0.9,
                    ),
                  ),
                ],
              ),
              SizedBox(height: income ? 6 : 12),
              Row(
                children: [
                  const SizedBox(width: 14),
                  income
                      ? BlocBuilder<CashBloc, CashState>(
                          builder: (context, state) {
                            return Text(
                              '\$ $totalIncomes',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontFamily: 'w700',
                              ),
                            );
                          },
                        )
                      : const Text(
                          'Make a budget',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'w700',
                          ),
                        ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const SizedBox(width: 14),
                  income
                      ? const Text(
                          'Total incomes',
                          style: TextStyle(
                            color: Color(0xff939393),
                            fontSize: 16,
                            fontFamily: 'w500',
                          ),
                        )
                      : const Expanded(
                          child: Text(
                            'Record income and expenses.',
                            style: TextStyle(
                              color: Color(0xff939393),
                              fontSize: 12,
                              fontFamily: 'w500',
                            ),
                          ),
                        ),
                  const SizedBox(width: 14),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _News extends StatelessWidget {
  const _News({required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      margin: const EdgeInsets.only(
        bottom: 20,
        left: 14,
        right: 14,
      ),
      decoration: BoxDecoration(
        color: const Color(0xff2C1A1A),
        borderRadius: BorderRadius.circular(10),
      ),
      child: MyBtn(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return NewsReadScreen(news: news);
              },
            ),
          );
        },
        child: Row(
          children: [
            const SizedBox(width: 5),
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: const Color(0xffB26868),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: news.image,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    return Container();
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    news.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'w700',
                    ),
                  ),
                  Text(
                    news.published,
                    style: const TextStyle(
                      color: Color(0xff939393),
                      fontSize: 10,
                      fontFamily: 'w500',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 40),
            const RotatedBox(
              quarterTurns: 2,
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: Color(0xffB26868),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
