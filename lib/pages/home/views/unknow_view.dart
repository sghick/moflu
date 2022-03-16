import 'package:flutter/material.dart';
import 'package:moflu/supports/styles/common_styles.dart';
import 'package:moflu/supports/widgets/divider.dart';
import 'package:moflu/supports/widgets/space.dart';
import 'package:rego/base_core/widgets/text_widgets.dart';

class UnKnowView extends StatefulWidget {
  final dynamic object;

  const UnKnowView({Key? key, required this.object}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UnKnowViewState();
}

class _UnKnowViewState extends State<UnKnowView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20.dp, left: 10.dp, right: 10.dp),
            color: Colors.grey,
            child: Row(
              children: [
                Icon(
                  Icons.apps,
                  color: Colors.lightBlue,
                ),
                CBSpace.h(10.dp),
                SimpleText('未知文件,请升级查看'),
                CBSpace.h(10.dp),
              ],
            ),
          ),
          CBDivider.h(),
        ],
      ),
    );
  }
}
