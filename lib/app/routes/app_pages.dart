import 'package:get/get.dart';
import 'package:saweria_webhook/app/utils/constant.dart';

import '../modules/create_webhook_command/bindings/create_webhook_command_binding.dart';
import '../modules/create_webhook_command/views/create_webhook_command_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.CREATE_WEBHOOK_COMMAND,
      page: () => CreateWebhookCommandView(),
      binding: CreateWebhookCommandBinding(),
      transition: Transition.cupertino,
      transitionDuration: kDefaultDuration,
    ),
  ];
}
