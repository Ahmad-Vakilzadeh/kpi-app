import 'package:auto_route/auto_route.dart';

import '../main.dart';
import    'app_router.gr.dart';
@AutoRouterConfig()
class AppRouter extends $AppRouter{
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: RouteMange.page,initial: CheckInitial == 1? true : false),
    AutoRoute(page: OnBoardingRoute.page,initial: CheckInitial == 2? true: false),
    AutoRoute(page: FactorCreate.page,initial: CheckInitial== 3? true: false),
  ];
}

