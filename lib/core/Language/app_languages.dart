import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Utilities/router_config.dart';
import '../../Utilities/shared_preferences.dart';

enum Languages { en, ar }

Languages appLan(BuildContext context) => Provider.of<AppLanguage>(context, listen: false).appLang;

bool appLangIsArabic({BuildContext? context}) => appLan(context??currentContext_!) == Languages.ar;

class AppLanguage extends ChangeNotifier {
  static Languages defaultLang = Languages.en;
  Languages _appLanguage = defaultLang;

  Languages get appLang => _appLanguage;

  Future fetchLocale(BuildContext context) async {
    if (SharedPref.getLanguage() == null) {
      _appLanguage = Languages.values.firstWhereOrNull((lang) => View.of(context).platformDispatcher.locale.languageCode.contains(lang.name)) ?? defaultLang;
    } else {
      _appLanguage = Languages.values.firstWhere((lang) => lang.name == SharedPref.getLanguage());
    }
  }

  Future changeLanguage({Languages? language}) async {
    if (language == _appLanguage) return;
    switch (language) {
      case Languages.en:
        _appLanguage = Languages.en;
        break;
      case Languages.ar:
        _appLanguage = Languages.ar;
        break;
      case null:
        _appLanguage = _appLanguage == Languages.ar ? Languages.en : Languages.ar;
        break;
    }
    await SharedPref.setLanguage(lang: _appLanguage.name);
    notifyListeners();
  }
}
