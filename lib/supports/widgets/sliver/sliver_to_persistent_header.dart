import 'package:flutter/cupertino.dart';

typedef SliverWidgetBuilder = Widget Function(
    BuildContext context, double shrinkOffset, bool overlapsContent);
typedef SliverRebuild = bool Function(
    SliverPersistentHeaderDelegate oldDelegate);

class SliverToPersistentHeader extends StatelessWidget {
  final SliverWidgetBuilder builder;
  final double theMaxExtent;
  final double theMinExtent;
  final SliverRebuild? theShouldRebuild;

  const SliverToPersistentHeader({
    Key? key,
    required this.builder,
    this.theMaxExtent = double.maxFinite,
    this.theMinExtent = 44,
    this.theShouldRebuild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: SliverToPersistentHeaderDelegate(
        builder: builder,
        theMaxExtent: theMaxExtent,
        theMinExtent: theMinExtent,
        theShouldRebuild: theShouldRebuild,
      ),
    );
  }
}

class SliverToPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final SliverWidgetBuilder builder;
  final double theMaxExtent;
  final double theMinExtent;
  final SliverRebuild? theShouldRebuild;

  SliverToPersistentHeaderDelegate({
    required this.builder,
    this.theMaxExtent = 44,
    this.theMinExtent = 44,
    this.theShouldRebuild,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return builder(context, shrinkOffset, overlapsContent);
  }

  @override
  double get maxExtent => theMaxExtent;

  @override
  double get minExtent => theMinExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      (theShouldRebuild != null) ? theShouldRebuild!(oldDelegate) : true;
}
