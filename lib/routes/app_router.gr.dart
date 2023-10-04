// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:kpi_app/Screens/factorCreate/factor_create_screen.dart' as _i1;
import 'package:kpi_app/Screens/Measure/page_manage.dart' as _i3;
import 'package:kpi_app/Screens/OnBoardingScreens/on_boarding.dart' as _i2;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    FactorCreateRoute.name: (routeData) {
      final args = routeData.argsAs<FactorCreateRouteArgs>(
          orElse: () => const FactorCreateRouteArgs());
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.FactorCreateScreen(
          key: args.key,
          urlPath: args.urlPath,
        ),
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
/// [_i1.FactorCreateScreen]
class FactorCreateRoute extends _i4.PageRouteInfo<FactorCreateRouteArgs> {
  FactorCreateRoute({
    _i5.Key? key,
    String? urlPath,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          FactorCreateRoute.name,
          args: FactorCreateRouteArgs(
            key: key,
            urlPath: urlPath,
          ),
          initialChildren: children,
        );

  static const String name = 'FactorCreateRoute';

  static const _i4.PageInfo<FactorCreateRouteArgs> page =
      _i4.PageInfo<FactorCreateRouteArgs>(name);
}

class FactorCreateRouteArgs {
  const FactorCreateRouteArgs({
    this.key,
    this.urlPath,
  });

  final _i5.Key? key;

  final String? urlPath;

  @override
  String toString() {
    return 'FactorCreateRouteArgs{key: $key, urlPath: $urlPath}';
  }
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
