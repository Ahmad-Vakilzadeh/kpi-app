// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:kpi_app/Screens/factorCreate/factor_create_screen.dart' as _i1;
import 'package:kpi_app/Screens/Measure/page_manage.dart' as _i3;
import 'package:kpi_app/Screens/OnBoardingScreens/on_boarding.dart' as _i2;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    FactorCreate.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.FactorCreate(),
      );
    },
    OnBoardingRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.OnBoardingScreen(),
      );
    },
    RouteMange.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.PageMange(),
      );
    },
  };
}

/// generated route for
/// [_i1.FactorCreate]
class FactorCreate extends _i4.PageRouteInfo<void> {
  const FactorCreate({List<_i4.PageRouteInfo>? children})
      : super(
          FactorCreate.name,
          initialChildren: children,
        );

  static const String name = 'FactorCreate';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.OnBoardingScreen]
class OnBoardingRoute extends _i4.PageRouteInfo<void> {
  const OnBoardingRoute({List<_i4.PageRouteInfo>? children})
      : super(
          OnBoardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnBoardingRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.PageMange]
class RouteMange extends _i4.PageRouteInfo<void> {
  const RouteMange({List<_i4.PageRouteInfo>? children})
      : super(
          RouteMange.name,
          initialChildren: children,
        );

  static const String name = 'RouteMange';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
