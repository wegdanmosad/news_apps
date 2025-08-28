import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_apps/app_theme.dart';
import 'package:news_apps/drawer/settings_provider.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  final VoidCallback onGoToHomeClicked;

  const HomeDrawer({super.key, required this.onGoToHomeClicked});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size screenSize = MediaQuery.sizeOf(context);
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    return Container(
      color: AppTheme.black,
      width: screenSize.width * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: screenSize.height * 0.2,
            width: double.infinity,
            alignment: Alignment.center,
            color: AppTheme.white,
            child: Text(
              'News App',
              style: textTheme.titleLarge!.copyWith(
                color: AppTheme.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () {
                onGoToHomeClicked();
                Navigator.of(context).pop();
              },
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/home.svg'),
                  SizedBox(width: 8),
                  Text(
                    'Go To Home',
                    style: textTheme.labelLarge!.copyWith(
                      color: AppTheme.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/theme.svg'),
                    SizedBox(width: 8),
                    Text(
                      "Theme",
                      style: textTheme.labelLarge!.copyWith(
                        color: AppTheme.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.white),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: DropdownButton<String>(
                    value: settingsProvider.themeMode == ThemeMode.dark
                        ? "dark"
                        : "light",
                    isExpanded: true,
                    dropdownColor: AppTheme.black,
                    style: textTheme.labelLarge!.copyWith(
                      color: AppTheme.white,
                    ),
                    underline: const SizedBox(),
                    items: [
                      DropdownMenuItem(value: "light", child: Text("Light")),
                      DropdownMenuItem(value: "dark", child: Text("Dark")),
                    ],
                    onChanged: (value) {
                      if (value == "dark") {
                        settingsProvider.changeTheme(ThemeMode.dark);
                      } else {
                        settingsProvider.changeTheme(ThemeMode.light);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/language.svg'),
                    SizedBox(width: 8),
                    Text(
                      "Language",
                      style: textTheme.labelLarge!.copyWith(
                        color: AppTheme.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.white),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: DropdownButton<String>(
                    value: settingsProvider.languageCode,
                    isExpanded: true,
                    dropdownColor: AppTheme.black,
                    style: textTheme.labelLarge!.copyWith(
                      color: AppTheme.white,
                    ),
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(value: "en", child: Text("English")),
                      DropdownMenuItem(value: "ar", child: Text("العربية")),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        settingsProvider.changeLanguage(value);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_apps/app_theme.dart';

class HomeDrawer extends StatelessWidget {
  VoidCallback onGoToHomeClicked;
  HomeDrawer({required this.onGoToHomeClicked});
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size screenSize = MediaQuery.sizeOf(context);
    return Container(
      color: AppTheme.black,
      width: screenSize.width * 0.7,
      child: Column(
        children: [
          Container(
            height: screenSize.height * 0.2,
            width: double.infinity,
            alignment: Alignment.center,
            color: AppTheme.white,
            child: Text(
              'News App',
              style: textTheme.titleLarge!.copyWith(
                color: AppTheme.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () {
                onGoToHomeClicked();
                Navigator.of(context).pop();
              },
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/home.svg'),
                  SizedBox(width: 8),
                  Text(
                    'Go To Home',
                    style: textTheme.labelLarge!.copyWith(
                      color: AppTheme.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(color: AppTheme.grey),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/theme.svg'),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.white),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(16),
                      underline: SizedBox(),
                      dropdownColor: AppTheme.white,
                      iconEnabledColor: AppTheme.white,
                      hint: Text(
                        "Select Theme",
                        style: textTheme.labelLarge!.copyWith(
                          color: AppTheme.white,
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: "light",
                          child: Text("Light Theme"),
                        ),
                        DropdownMenuItem(
                          value: "dark",
                          child: Text("Dark Theme"),
                        ),
                      ],
                      onChanged: (value) {},
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/language.svg'),
                  SizedBox(width: 8),
                  Text(
                    'Go To Home',
                    style: textTheme.labelLarge!.copyWith(
                      color: AppTheme.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/
