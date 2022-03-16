import 'package:moflu/pages/root/launch_page.dart';
import 'package:moflu/pages/root/private_page.dart';
import 'package:moflu/supports/widgets/root_state.dart';
import 'package:flutter/material.dart';


class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends CBRootState<RootPage> {
  @override
  String get privateVersion => '1.0';

  @override
  Function? get privateDialogHandler => () => showPrivateDialog();

  @override
  String get splashVersion => '1.0';

  @override
  String? get splashPage => '/splash';

  // @override
  // String? get advertPage => '/advert';

  @override
  String get homePage => '/home';

  @override
  Widget launchPage(VoidCallback endAnimated) =>
      LaunchPage(endAnimated: endAnimated);
}
