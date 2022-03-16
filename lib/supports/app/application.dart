import 'package:moflu/supports/styles/common_styles.dart';
import 'package:rego/base_core/app/application.dart';
import 'package:rego/base_core/routes/page_jump.dart';
import 'package:moflu/supports/app/navigator.dart';
import 'package:moflu/supports/app/router.dart';
import 'package:moflu/supports/utils/pref_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

abstract class ApplicationMixin
    with AppNavigatorMixin, AppRouterMixin, AppPageJumper
    implements Application {
  @override
  void start() {
    WidgetsFlutterBinding.ensureInitialized();
    coreInit().whenComplete(() {
      Future.wait([_innerAppInit(), appInit()]).whenComplete(() {
        runApp(buildAppWidget());
      });
    });
  }

  @override
  Widget buildAppWidget() => MaterialApp(
        title: title,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        theme: theme,
        navigatorKey: navigatorKey,
        navigatorObservers: [navigationHistoryObserver, pageRouteObserver],
        initialRoute: initialRoute,
        onGenerateInitialRoutes: onGenerateInitialRoutes,
        onGenerateRoute: onGenerateRoute,
        builder: builder,
      );

  @override
  ThemeData get theme => ThemeData(
        primarySwatch: Colors.lightBlue,
        primaryColor: Colors.blue[300],
        platform: TargetPlatform.iOS,
        scaffoldBackgroundColor: Color(0xfff5f5f5),
      );

  @override
  bool get debugShowCheckedModeBanner => false;

  @override
  Iterable<Locale> get supportedLocales => [Locale('zh', 'CN')];

  @override
  Iterable<LocalizationsDelegate> get localizationsDelegates => [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];

  @override
  TransitionBuilder get builder => (BuildContext context, Widget? child) {
        // forbidden text scaling
        var data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(textScaleFactor: 1),
          child: child ?? Container(),
        );
      };

  @override
  CacheLimitation get imageCacheLimitation =>
      CacheLimitation(80 * 1024 * 1024, 100);

  @override
  void initWithContext(BuildContext context) {
    ScreenUtil.init(context);
  }

  Future<void> _innerAppInit() {
    SystemChrome.setPreferredOrientations(appOrientation());
    PaintingBinding.instance?.imageCache?.maximumSizeBytes =
        imageCacheLimitation.maxSizeInBytes;
    PaintingBinding.instance?.imageCache?.maximumSize =
        imageCacheLimitation.maxFiles;
    return Future.value();
  }

  List<DeviceOrientation> appOrientation() {
    return [DeviceOrientation.portraitUp];
  }

  Future<void> appInit() async {
    await initSharedPref();
    initAppPageJump();
    return Future.value();
  }
}
