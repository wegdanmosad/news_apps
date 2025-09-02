import 'package:flutter/material.dart';
import 'package:news_apps/shared/app_theme.dart';
import 'package:news_apps/home/view/widgets/drawer/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:news_apps/sources/data/models/source.dart';

class TabItem extends StatelessWidget {
  Source source;
  bool isSelected;
  TabItem({required this.source, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Text(
      source.name!,
      style: (isSelected ? textTheme.titleMedium : textTheme.titleSmall),
      selectionColor: settingsProvider.isDark ? AppTheme.white : AppTheme.black,
    );
  }
}
