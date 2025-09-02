import 'package:flutter/material.dart';
import 'package:news_apps/shared/app_theme.dart';
import 'package:news_apps/home/view/widgets/drawer/settings_provider.dart';
import 'package:news_apps/news/data/models/news.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class NewsItem extends StatelessWidget {
  News news;
  NewsItem(this.news);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.5,
              minChildSize: 0.3,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: settingsProvider.isDark
                          ? AppTheme.white
                          : AppTheme.black,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              news.urlToImage ??
                                  'https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg',
                              height: MediaQuery.sizeOf(context).height * 0.25,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            news.description ?? "No description available",
                            style: textTheme.titleSmall!.copyWith(
                              color: settingsProvider.isDark
                                  ? AppTheme.black
                                  : AppTheme.white,
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: settingsProvider.isDark
                                  ? AppTheme.black
                                  : AppTheme.white,
                              foregroundColor: settingsProvider.isDark
                                  ? AppTheme.black
                                  : AppTheme.white,
                              minimumSize: Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: EdgeInsets.all(16),
                            ),
                            onPressed: () async {
                              if (news.url != null && news.url!.isNotEmpty) {
                                final Uri url = Uri.parse(news.url!);

                                if (await canLaunchUrl(url)) {
                                  await launchUrl(
                                    url,
                                    mode: LaunchMode.externalApplication,
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Cannot open the article!',
                                        style: textTheme.titleMedium!.copyWith(
                                          color: settingsProvider.isDark
                                              ? AppTheme.black
                                              : AppTheme.white,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            child: Text(
                              'View Full Article',
                              style: textTheme.titleMedium!.copyWith(
                                color: settingsProvider.isDark
                                    ? AppTheme.white
                                    : AppTheme.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: settingsProvider.isDark ? AppTheme.white : AppTheme.black,
          ),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                news.urlToImage ??
                    'https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg',
                height: MediaQuery.sizeOf(context).height * 0.25,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 10),
            Text(
              news.title ?? "No title available",
              style: textTheme.titleMedium!.copyWith(
                color: settingsProvider.isDark
                    ? AppTheme.white
                    : AppTheme.black,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'By : ${news.source!.name}',
                  style: textTheme.titleSmall!.copyWith(color: AppTheme.grey),
                ),
                Text(
                  timeago.format(news.publishedAt!),
                  style: textTheme.titleSmall!.copyWith(color: AppTheme.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
