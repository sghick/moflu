import 'package:rego/base_core/routes/navigators.dart';
import 'package:rego/base_core/routes/router.dart';
import 'package:flutter/material.dart';

// TODO:临时解决push页面自定义动画使用
bool _transitionFade = false;

Future<T?> goPageWithRoute<T>(
  Future<T?> goPage, {
  bool transFade = true,
}) {
  _transitionFade = transFade;
  return goPage;
}

abstract class AppRouterMixin implements AppRouter, AppNavigator {
  @override
  RouteObserver<PageRoute> get pageRouteObserver => routeObserver;

  @override
  InitialRouteListFactory get onGenerateInitialRoutes => (String routeName) {
        final Function builder = (BuildContext context) {
          initWithContext(context);
          return routes[routeName]!(context);
        };
        return [_generateRoute(builder, null, RouteSettings(name: routeName))];
      };

  @override
  RouteFactory get onGenerateRoute => (RouteSettings settings) {
        final String routeName = settings.name!;
        final Function pageContentBuilder = routes[routeName]!;
        return _generateRoute(pageContentBuilder, settings.arguments, settings);
      };

  PageRoute<Object> _generateRoute(
      Function builder, dynamic arguments, RouteSettings settings) {
    WidgetBuilder childBuilder = (context) {
      Widget res;
      if (arguments == null) {
        res = builder(context);
      } else {
        res = builder(context, arguments: arguments);
      }
      if (settings.name != null) {
        navigationHistoryObserver.recordRouteWidget(settings.name!, res);
      }
      return res;
    };

    PageRoute<Object> pageRoute;
    if (_transitionFade) {
      pageRoute = PageRouteBuilder(
        settings: settings,
        opaque: false, // set to false
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: childBuilder(context),
          );
        },
      );
      _transitionFade = false;
    } else {
      pageRoute = MaterialPageRoute(settings: settings, builder: childBuilder);
    }
    return pageRoute;
  }

  Map<String, WidgetBuilder> get routes;

  void initWithContext(BuildContext context);
}
