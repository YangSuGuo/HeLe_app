import 'package:flutter/material.dart';
import 'package:hele_app/l10n/gen/app_g.dart';
import 'package:hele_app/pages/settings/widget/select_dialog.dart';
import 'package:hele_app/pages/settings/widget/switch_item.dart';
import 'package:hele_app/providers/application/application.dart';
import 'package:hele_app/themes/multiple_themes_mode/multiple_themes.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = Theme.of(context).textTheme.titleMedium!;
    TextStyle subTitleStyle =
        Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.outline);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        title: Text(
          '设置',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Consumer<ApplicationProvider>(builder: (_, applicationProvider, child) {
        ApplicationProvider applicationProvider = context.read<ApplicationProvider>();

        return ListView(
          children: [
            ListTile(
              dense: false,
              title: Text('语言设置', style: titleStyle),
              subtitle: Text(
                '当前正在使用「${Localizations.localeOf(context)}」语言',
                style: subTitleStyle,
              ),
              onTap: () async {
                String? result = await showDialog(
                  context: context,
                  builder: (context) {
                    return SelectDialog<String>(
                      title: '语言列表',
                      value: applicationProvider.locale.toString(),
                      values: S.supportedLocales,
                    );
                  },
                );
                switch (result) {
                  case 'zh_CN':
                    applicationProvider.locale = const Locale('zh', 'CN');
                    applicationProvider.localeSystem = false;
                    break;
                  case 'zh':
                    applicationProvider.locale = const Locale('zh');
                    applicationProvider.localeSystem = false;
                    break;
                  case 'en':
                    applicationProvider.locale = const Locale('en');
                    applicationProvider.localeSystem = false;
                    break;
                  case 'en_US':
                    applicationProvider.locale = const Locale('en');
                    applicationProvider.localeSystem = false;
                    break;
                  case 'zh_HK':
                    applicationProvider.locale = const Locale('zh', 'HK');
                    applicationProvider.localeSystem = false;
                    break;
                  case 'zh_TW':
                    applicationProvider.locale = const Locale('zh', 'TW');
                    applicationProvider.localeSystem = false;
                    break;
                }
              },
            ),
            SetSwitchItem(
              title: '跟随系统语言',
              subTitle: '默认跟随系统设置语言',
              setKey: "appIsLocaleSystem",
              callFn: (val) {
                applicationProvider.localeSystem = val;
              },
              defaultVal: false,
            ),
            const SetSwitchItem(
              title: '动态取色',
              subTitle: '自定义颜色将失效「未实现」',
              setKey: "dynamicColor",
              defaultVal: false,
            ),
            ListTile(
              dense: false,
              title: Text('种子颜色', style: titleStyle),
              subtitle: Text(
                '当前正在使用「${applicationProvider.multipleThemesMode}」颜色',
                style: subTitleStyle,
              ),
              onTap: () async {
                final List appMultipleThemesModeKey = [];
                appMultipleThemesMode.forEach((key, value) => appMultipleThemesModeKey.add(key));

                String? result = await showDialog(
                  context: context,
                  builder: (context) {
                    return SelectDialog<String>(
                      title: '种子颜色',
                      value: applicationProvider.multipleThemesMode,
                      values: appMultipleThemesModeKey,
                      isRadio: false,
                    );
                  },
                );
                switch (result) {
                  case 'zh_CN':
                    applicationProvider.locale = const Locale('zh', 'CN');
                    applicationProvider.localeSystem = false;
                    break;
                  case 'zh':
                    applicationProvider.locale = const Locale('zh');
                    applicationProvider.localeSystem = false;
                    break;
                  case 'en':
                    applicationProvider.locale = const Locale('en');
                    applicationProvider.localeSystem = false;
                    break;
                  case 'en_US':
                    applicationProvider.locale = const Locale('en');
                    applicationProvider.localeSystem = false;
                    break;
                  case 'zh_HK':
                    applicationProvider.locale = const Locale('zh', 'HK');
                    applicationProvider.localeSystem = false;
                    break;
                  case 'zh_TW':
                    applicationProvider.locale = const Locale('zh', 'TW');
                    applicationProvider.localeSystem = false;
                    break;
                }
              },
            ),
            const SetSwitchItem(
              title: '无痕模式',
              subTitle: '暂停记录浏览历史「未实现」',
              setKey: "incognitoMode",
              defaultVal: false,
            ),
            const SetSwitchItem(
              title: '自动浏览历史清理',
              subTitle: '7天自动浏览历史清理「未实现」',
              setKey: "incognitoMode",
              defaultVal: false,
            ),
          ],
        );
      }),
    );
  }
}
