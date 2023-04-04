import 'package:get/get.dart';

import '../../../../config/utils/my_string.dart';
import 'ar.dart';
import 'en.dart';
import 'fr.dart';

class LocalizationApp extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {ene: en, ara: ar, fra: fr};
}
