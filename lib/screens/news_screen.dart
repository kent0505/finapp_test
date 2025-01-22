import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/news.dart';
import '../widgets/my_btn.dart';
import '../widgets/text_title.dart';
import 'news_read_screen.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).viewPadding.top),
        const SizedBox(
          height: 60,
          child: TextTitle('News'),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 20),
            itemCount: newsLIST.length,
            itemBuilder: (context, index) {
              return _Card(news: newsLIST[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 344,
      margin: const EdgeInsets.only(
        left: 14,
        right: 14,
        bottom: 20,
      ),
      decoration: BoxDecoration(
        color: const Color(0xff2C1A1A),
        borderRadius: BorderRadius.circular(14),
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
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
                child: CachedNetworkImage(
                  imageUrl: news.image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    return Container();
                  },
                ),
              ),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    news.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'w700',
                    ),
                  ),
                ),
                const SizedBox(width: 14),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(width: 14),
                Text(
                  news.published,
                  style: const TextStyle(
                    color: Color(0xff939393),
                    fontSize: 14,
                    fontFamily: 'w500',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
