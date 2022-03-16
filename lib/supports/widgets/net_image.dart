import 'package:extended_image/extended_image.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:moflu/supports/styles/common_styles.dart';

///图片内存效率注意：
///1. 图片尽量提供 width 或 height信息，不要采用默认尺寸；cacheWidth/Height会被自动计算。比例与实际width/height保持一致。
///2. 如非 反复销毁/重建的图片（如列表中的图片），将enableMemoryCache 设置为false，及时释放内存。
///3. 页面退出后不会再次出现的图片，将clearMemoryCacheWhenDispose 设置为true，及时释放内存。

///图片内存效率注意：
///1. 图片尽量提供 width 或 height信息，不要采用默认尺寸；cacheWidth/Height会被自动计算。比例与实际width/height保持一致。
///2. 如非 反复销毁/重建的图片（如列表中的图片），将enableMemoryCache 设置为false，及时释放内存。
///3. 页面退出后不会再次出现的图片，将clearMemoryCacheWhenDispose 设置为true，及时释放内存。
ExtendedImage netImage(String url,
    {Key? key,
      String? semanticLabel,
      bool excludeFromSemantics = false,
      double? width,
      double? height,
      Color? color,
      BlendMode? colorBlendMode,
      BoxFit? fit,
      Alignment alignment = Alignment.center,
      ImageRepeat repeat = ImageRepeat.noRepeat,
      Rect? centerSlice,
      bool matchTextDirection = false,
      bool gaplessPlayback = false,
      FilterQuality filterQuality = FilterQuality.low,
      LoadStateChanged? loadStateChanged,
      BoxShape? shape,
      BoxBorder? border,
      BorderRadius? borderRadius,
      Clip clipBehavior = Clip.antiAlias,
      bool enableLoadState = true,
      BeforePaintImage? beforePaintImage,
      AfterPaintImage? afterPaintImage,
      ExtendedImageMode mode = ExtendedImageMode.none,
      bool enableMemoryCache = true,
      bool clearMemoryCacheIfFailed = true,
      DoubleTap? onDoubleTap,
      InitGestureConfigHandler? initGestureConfigHandler,
      bool enableSlideOutPage = false,
      BoxConstraints? constraints,
      CancellationToken? cancelToken,
      int retries = 3,
      Duration? timeLimit,
      Map<String, String>? headers,
      bool cache = true,
      double scale = 1.0,
      Duration timeRetry = const Duration(milliseconds: 100),
      Key? extendedImageEditorKey,
      InitEditorConfigHandler? initEditorConfigHandler,
      HeroBuilderForSlidingPage? heroBuilderForSlidingPage,
      bool clearMemoryCacheWhenDispose = false,
      bool handleLoadingProgress = false,
      Key? extendedImageGestureKey,
      int? cacheWidth,
      int? cacheHeight,
      double cacheScale = 1.1,
      bool isAntiAlias = false}) {
  /// according to Painting.dart/instantiateCodec
  if (width != null) {
    cacheWidth = (width * cacheScale).toPx;
  }
  if (height != null) {
    cacheHeight = (height * cacheScale).toPx;
  }

  return ExtendedImage.network(
    url,
    semanticLabel: semanticLabel,
    excludeFromSemantics: excludeFromSemantics,
    width: width,
    height: height,
    color: color,
    colorBlendMode: colorBlendMode,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
    centerSlice: centerSlice,
    matchTextDirection: matchTextDirection,
    gaplessPlayback: gaplessPlayback,
    filterQuality: filterQuality,
    loadStateChanged: loadStateChanged == null
        ? (ExtendedImageState state) {
      switch (state.extendedImageLoadState) {
        case LoadState.failed:
          return Container(
            width: 58.dp,
            height: 58.dp,
            child: Image.asset(
              "icon_placeholder".png,
            ),
          );
        default:
          return null;
      }
    }
        : loadStateChanged,
    shape: shape,
    border: border,
    borderRadius: borderRadius,
    clipBehavior: clipBehavior,
    enableLoadState: enableLoadState,
    beforePaintImage: beforePaintImage,
    afterPaintImage: afterPaintImage,
    mode: mode,
    enableMemoryCache: enableMemoryCache,
    clearMemoryCacheIfFailed: clearMemoryCacheIfFailed,
    onDoubleTap: onDoubleTap,
    initGestureConfigHandler: initGestureConfigHandler,
    enableSlideOutPage: enableSlideOutPage,
    constraints: constraints,
    cancelToken: cancelToken,
    retries: retries,
    timeLimit: timeLimit,
    headers: headers,
    cache: cache,
    scale: scale,
    timeRetry: timeRetry,
    extendedImageEditorKey: extendedImageEditorKey,
    extendedImageGestureKey: extendedImageGestureKey,
    initEditorConfigHandler: initEditorConfigHandler,
    heroBuilderForSlidingPage: heroBuilderForSlidingPage,
    clearMemoryCacheWhenDispose: clearMemoryCacheWhenDispose,
    handleLoadingProgress: handleLoadingProgress,
    cacheWidth: cacheWidth,
    cacheHeight: cacheHeight,
    isAntiAlias: isAntiAlias,
  );
}

class ExtendedHDImageController {
  ExtendedNetworkImageProvider? _provider;
  ExtendedNetworkImageProvider? _hdProvider;

  void bindingProvider(ExtendedNetworkImageProvider? provider) {
    _provider = provider;
  }

  void bindingHdProvider(ExtendedNetworkImageProvider? provider) {
    _hdProvider = provider;
  }

  void clearMemoryCache() {
    _clearMemoryCache(_provider);
    _clearMemoryCache(_hdProvider);
  }

  void _clearMemoryCache(ImageProvider? provider) {
    if (provider != null) {
      provider
          .obtainCacheStatus(configuration: ImageConfiguration.empty)
          .then((ImageCacheStatus? value) {
        if (value?.keepAlive ?? false) {
          provider.evict();
        }
      });
    }
  }
}

typedef ExtendedHDImageBuilder = Widget Function(
    BuildContext context, String? url, ExtendedNetworkImageProvider? provider);

class ExtendedHDImage extends StatefulWidget {
  final String url;
  final String? hdUrl;
  final ExtendedHDImageBuilder? builder;
  final ExtendedHDImageBuilder? hdBuilder;
  final ExtendedHDImageController? controller;
  final bool clearMemoryCacheWhenDispose;

  const ExtendedHDImage(
      this.url,
      this.hdUrl, {
        Key? key,
        this.builder,
        this.hdBuilder,
        this.controller,
        this.clearMemoryCacheWhenDispose = false,
      }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ExtendedHDImageState();
}

class ExtendedHDImageState extends State<ExtendedHDImage> {
  bool _hasHD = false;
  ExtendedNetworkImageProvider? _provider;
  ExtendedNetworkImageProvider? _hdProvider;

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _precacheHDImage(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return _hasHD
              ? _buildHDImageWidget(context)
              : _buildImageWidget(context);
        });
  }

  Widget _buildImageWidget(BuildContext context) {
    _provider = ExtendedNetworkImageProvider(widget.url, cache: true);
    if (widget.controller != null) {
      widget.controller!.bindingProvider(_provider);
    }
    if (widget.builder != null) {
      return widget.builder!(context, widget.url, _provider);
    } else {
      return ExtendedImage(
        image: _provider!,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
        clearMemoryCacheWhenDispose: widget.clearMemoryCacheWhenDispose,
      );
    }
  }

  Widget _buildHDImageWidget(BuildContext context) {
    if (widget.hdBuilder != null) {
      return widget.hdBuilder!(context, widget.hdUrl, _hdProvider);
    } else {
      return ExtendedImage(
        image: _hdProvider!,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
        clearMemoryCacheWhenDispose: widget.clearMemoryCacheWhenDispose,
      );
    }
  }

  Future<void> _precacheHDImage() {
    return _memoizer.runOnce(() {
      if (widget.hdUrl != null && widget.hdUrl!.isNotEmpty) {
        _hdProvider = ExtendedNetworkImageProvider(widget.hdUrl!, cache: true);
        precacheImage(_hdProvider!, context).whenComplete(() {
          _hasHD = true;
          if (mounted) {
            setState(() {});
          }
        });
        if (widget.controller != null) {
          widget.controller!.bindingHdProvider(_hdProvider);
        }
      }
      return Future.value();
    });
  }
}

Future<void> precacheExtendedImage(String? url, BuildContext context) {
  if (url != null && url.isNotEmpty) {
    var provider = ExtendedNetworkImageProvider(url, cache: true);
    return precacheImage(provider, context);
  }
  return Future.value();
}
