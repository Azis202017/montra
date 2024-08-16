import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/routes/app_pages.dart';
import 'app/shared/theme/theme.dart';

void main() {
  GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting('en_US', null).then((_) => runApp(
        GetMaterialApp(
          title: "Montra",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          theme: themeData,
        ),
      ));
}
