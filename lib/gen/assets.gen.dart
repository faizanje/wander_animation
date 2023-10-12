/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/hamburger.svg
  String get hamburger => 'assets/icons/hamburger.svg';

  /// List of all assets
  List<String> get values => [hamburger];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Ellipse 36.png
  AssetGenImage get ellipse36 =>
      const AssetGenImage('assets/images/Ellipse 36.png');

  /// File path: assets/images/Ellipse 37.png
  AssetGenImage get ellipse37 =>
      const AssetGenImage('assets/images/Ellipse 37.png');

  /// File path: assets/images/Ellipse 39.png
  AssetGenImage get ellipse39 =>
      const AssetGenImage('assets/images/Ellipse 39.png');

  /// File path: assets/images/Ellipse 53.png
  AssetGenImage get ellipse53 =>
      const AssetGenImage('assets/images/Ellipse 53.png');

  /// File path: assets/images/pexels-aleksey-kuprikov-3493777.jpg
  AssetGenImage get pexelsAlekseyKuprikov3493777 =>
      const AssetGenImage('assets/images/pexels-aleksey-kuprikov-3493777.jpg');

  /// File path: assets/images/pexels-lisa-fotios-1534560.jpg
  AssetGenImage get pexelsLisaFotios1534560 =>
      const AssetGenImage('assets/images/pexels-lisa-fotios-1534560.jpg');

  /// File path: assets/images/pexels-lisa-fotios-1559908.jpg
  AssetGenImage get pexelsLisaFotios1559908 =>
      const AssetGenImage('assets/images/pexels-lisa-fotios-1559908.jpg');

  /// File path: assets/images/pexels-michael-block-3225528.jpg
  AssetGenImage get pexelsMichaelBlock3225528 =>
      const AssetGenImage('assets/images/pexels-michael-block-3225528.jpg');

  /// File path: assets/images/pexels-trace-hudson-2724664.jpg
  AssetGenImage get pexelsTraceHudson2724664 =>
      const AssetGenImage('assets/images/pexels-trace-hudson-2724664.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [
        ellipse36,
        ellipse37,
        ellipse39,
        ellipse53,
        pexelsAlekseyKuprikov3493777,
        pexelsLisaFotios1534560,
        pexelsLisaFotios1559908,
        pexelsMichaelBlock3225528,
        pexelsTraceHudson2724664
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
