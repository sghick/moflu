import 'package:rego/base_core/routes/navigators.dart';
import 'package:moflu/supports/styles/common_styles.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('this is splash page'),
            TextButton(
              onPressed: () {
                goBack();
              },
              child: Text('结束', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}
