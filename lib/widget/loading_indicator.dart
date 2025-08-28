import 'package:flutter/material.dart';
import 'package:news_apps/app_theme.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: AppTheme.white));
  }
}
