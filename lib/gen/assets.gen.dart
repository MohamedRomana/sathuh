/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsLangGen {
  const $AssetsLangGen();

  /// File path: assets/Lang/ar.json
  String get ar => 'assets/Lang/ar.json';

  /// File path: assets/Lang/en.json
  String get en => 'assets/Lang/en.json';

  /// List of all assets
  List<String> get values => [ar, en];
}

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Tajawal-Bold.ttf
  String get tajawalBold => 'assets/fonts/Tajawal-Bold.ttf';

  /// File path: assets/fonts/Tajawal-Light.ttf
  String get tajawalLight => 'assets/fonts/Tajawal-Light.ttf';

  /// File path: assets/fonts/Tajawal-Medium.ttf
  String get tajawalMedium => 'assets/fonts/Tajawal-Medium.ttf';

  /// List of all assets
  List<String> get values => [tajawalBold, tajawalLight, tajawalMedium];
}

class $AssetsImgGen {
  const $AssetsImgGen();

  /// File path: assets/img/NoCar.png
  AssetGenImage get noCar => const AssetGenImage('assets/img/NoCar.png');

  /// File path: assets/img/alert.json
  String get alert => 'assets/img/alert.json';

  /// File path: assets/img/car.png
  AssetGenImage get car => const AssetGenImage('assets/img/car.png');

  /// File path: assets/img/car2.png
  AssetGenImage get car2 => const AssetGenImage('assets/img/car2.png');

  /// File path: assets/img/clock.png
  AssetGenImage get clock => const AssetGenImage('assets/img/clock.png');

  /// File path: assets/img/easy.png
  AssetGenImage get easy => const AssetGenImage('assets/img/easy.png');

  /// File path: assets/img/emptyorder.json
  String get emptyorder => 'assets/img/emptyorder.json';

  /// File path: assets/img/emptyseach.json
  String get emptyseach => 'assets/img/emptyseach.json';

  /// File path: assets/img/forgotpass.png
  AssetGenImage get forgotpass =>
      const AssetGenImage('assets/img/forgotpass.png');

  /// File path: assets/img/loading.json
  String get loading => 'assets/img/loading.json';

  /// File path: assets/img/login.json
  String get login => 'assets/img/login.json';

  /// File path: assets/img/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/img/logo.png');

  /// File path: assets/img/mail.png
  AssetGenImage get mail => const AssetGenImage('assets/img/mail.png');

  /// File path: assets/img/noti_empty.json
  String get notiEmpty => 'assets/img/noti_empty.json';

  /// File path: assets/img/saudi-arabia.png
  AssetGenImage get saudiArabia =>
      const AssetGenImage('assets/img/saudi-arabia.png');

  /// File path: assets/img/savemony.png
  AssetGenImage get savemony => const AssetGenImage('assets/img/savemony.png');

  /// File path: assets/img/saver.png
  AssetGenImage get saver => const AssetGenImage('assets/img/saver.png');

  /// File path: assets/img/united-kingdom.png
  AssetGenImage get unitedKingdom =>
      const AssetGenImage('assets/img/united-kingdom.png');

  /// List of all assets
  List<dynamic> get values => [
    noCar,
    alert,
    car,
    car2,
    clock,
    easy,
    emptyorder,
    emptyseach,
    forgotpass,
    loading,
    login,
    logo,
    mail,
    notiEmpty,
    saudiArabia,
    savemony,
    saver,
    unitedKingdom,
  ];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/chat.svg
  String get chat => 'assets/svg/chat.svg';

  /// File path: assets/svg/document.svg
  String get document => 'assets/svg/document.svg';

  /// File path: assets/svg/driver.svg
  String get driver => 'assets/svg/driver.svg';

  /// File path: assets/svg/file.svg
  String get file => 'assets/svg/file.svg';

  /// File path: assets/svg/home.svg
  String get home => 'assets/svg/home.svg';

  /// File path: assets/svg/language.svg
  String get language => 'assets/svg/language.svg';

  /// File path: assets/svg/location.svg
  String get location => 'assets/svg/location.svg';

  /// File path: assets/svg/logout.svg
  String get logout => 'assets/svg/logout.svg';

  /// File path: assets/svg/privacy.png
  AssetGenImage get privacyPng => const AssetGenImage('assets/svg/privacy.png');

  /// File path: assets/svg/privacy.svg
  String get privacySvg => 'assets/svg/privacy.svg';

  /// File path: assets/svg/time.svg
  String get time => 'assets/svg/time.svg';

  /// List of all assets
  List<dynamic> get values => [
    chat,
    document,
    driver,
    file,
    home,
    language,
    location,
    logout,
    privacyPng,
    privacySvg,
    time,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsLangGen lang = $AssetsLangGen();
  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsImgGen img = $AssetsImgGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

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
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
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

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
